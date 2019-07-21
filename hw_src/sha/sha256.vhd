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


        ready   : out std_logic := '0';
        dm_out  : out hash
    );
end SHA256;

architecture behavior of SHA256 is
    signal reset: std_logic := '0';
    signal enable: std_logic := '0';

    signal hash_finished: std_logic := '0';
    signal running_hash : hash;

    signal preprocessor_output_valid : std_logic := '0';

    signal sha_manager_processing : std_logic;
    signal sha_manager_finished: std_logic;

    signal wo: word;
    signal w: word;

    signal msg_length : input_msg_length := b"01000000";
    signal dm_in: input_msg := X"FEDC_BA98_7654_3210_0000_0000_0000_0000" &
                               X"0000_0000_0000_0000_0000_0000_0000_0000";

    signal clk_o_4 : std_logic;
begin

    enabler: process (en)
    begin
        if(en = '1' and en'event) then
            if enable = '0' then
                enable <= '1';
            end if;
        end if;
    end process enabler;

    mod_4_clock: process(clk)
        variable counter : unsigned(0 to 1) := b"00";
    begin
        if(clk = '1' and clk'event ) then
            if enable = '1' then
                if counter = b"00" then
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
            finished => packer_finished,
            w_out => wo
        );

    preprocessor: entity work.SHA_Preprocessor
        port map(
            clk => clk_o_4,
            en => enable,

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
