library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;

entity SHA256 is
    port(
        clk     : in std_logic;
        en      : in std_logic;

        packer_processing : out std_logic := '0';
        packer_finished : out std_logic := '0';

        preprocessor_processing : out std_logic := '0';
        preprocessor_finished   : out std_logic := '0';

        sha_manager_processing : out std_logic := '0';

        ready   : out std_logic := '0';
        dm_out  : out hash
    );
end SHA256;

architecture behavior of SHA256 is
    signal reset: std_logic := '0';
    signal enable: std_logic := '0';

    signal hash_finished: std_logic := '0';
    signal running_hash : hash;


    signal packer_output_valid       : std_logic := '0';
    signal preprocessor_output_valid : std_logic := '0';

    signal sha_manager_finished: std_logic := '0';

    signal wo: word;
    signal w: word;

    constant msg_length : input_msg_length := b"01000000";
    constant dm_in: input_msg := X"FEDC_BA98_7654_3210_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000";

    signal clk_o_4 : std_logic := '0';
begin

    exposer: process(en, sha_manager_finished)
        variable a, b, c, d, e, f, g, h : word;
    begin
        if(en = '1' and en'event) then
            hash_finished <= '0';
        end if;

        if(sha_manager_finished = '1' and sha_manager_finished'event ) then

            a := word(running_hash(0*32 to 0*32 + 31));
            b := word(running_hash(1*32 to 1*32 + 31));
            c := word(running_hash(2*32 to 2*32 + 31));
            d := word(running_hash(3*32 to 3*32 + 31));
            e := word(running_hash(4*32 to 4*32 + 31));
            f := word(running_hash(5*32 to 5*32 + 31));
            g := word(running_hash(6*32 to 6*32 + 31));
            h := word(running_hash(7*32 to 7*32 + 31));

            -- Will have to figure out what to do here (and everywhere really)
            -- if we want input messages larger than 512 bytes
            dm_out <= add_words(H_init(0), a) & add_words(H_init(1), b) &
                      add_words(H_init(2), c) & add_words(H_init(3), d) &
                      add_words(H_init(4), e) & add_words(H_init(5), f) &
                      add_words(H_init(6), g) & add_words(H_init(7), h);

            hash_finished <= '1';
            ready <= '1';
        end if;
    end process exposer;


    enabler: process (en, hash_finished)
    begin
        if(en = '1' and en'event) then
            if enable = '0' then
                enable <= '1';
                ready <= '0';
            end if;
        end if;

        if(hash_finished = '1' and hash_finished'event ) then
            enable <= '0';
        end if;
    end process enabler;

    mod_4_clock: process(clk)
        variable counter : unsigned(0 to 0) := b"0";
    begin
        if(clk = '1' and clk'event ) then
            if enable = '1' then
                if counter = b"0" then
                    clk_o_4 <= not clk_o_4;
                end if;

                counter := counter + 1;
            end if;
        end if;
    end process mod_4_clock;

    packer: entity work.SHA_Packer
        port map(
            msg => dm_in,
            msg_length => msg_length,
            en => enable,
            clk => clk_o_4,
            processing => packer_processing,
            valid => packer_output_valid,
            finished => packer_finished,
            w_out => wo
        );

    preprocessor: entity work.SHA_Preprocessor
        port map(
            clk => clk_o_4,
            en => packer_output_valid,

            processing => preprocessor_processing,
            finished => preprocessor_finished,
            output_valid => preprocessor_output_valid,

            word_in => wo,
            word_out => w
        );


    manager: entity work.SHA_Manager
        port map(
            clk => clk,

            en => preprocessor_output_valid,
            reset => reset,

            processing => sha_manager_processing,

            w_in => w,
            finished => sha_manager_finished,
            hash_out => running_hash
        );

end architecture behavior;
