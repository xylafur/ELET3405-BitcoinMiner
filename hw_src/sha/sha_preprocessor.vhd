library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;

--Extend the first 16 words into the remaining 48 words w[16..63] of the message schedule array:
--for i from 16 to 63
--    s0 := (w[i-15] rightrotate  7) xor (w[i-15] rightrotate 18) xor (w[i-15] rightshift  3)
--    s1 := (w[i- 2] rightrotate 17) xor (w[i- 2] rightrotate 19) xor (w[i- 2] rightshift 10)
--    w[i] := w[i-16] + s0 + w[i-7] + s1


entity SHA_Preprocessor is
    port(
        clk         : in std_logic;
        en          : in std_logic;

        -- these guys are basically compliements... I can probably remove these
        processing  : out std_logic := '0';
        finished : out std_logic := '0';

        output_valid : out std_logic := '0';

        word_in     : in word;
        word_out    : out word
    );
end entity SHA_Preprocessor;

architecture behavior of SHA_Preprocessor is
    -- we have 64 words that we will be getting from the packer
    signal current_word         : integer;
    signal enabled              : std_logic := '0';
    signal internal_finished    : std_logic := '0';

    signal buffer_index         : integer := 0;
    constant buffer_length      : integer := 17;
    signal word_buffer          : word_vector(0 to buffer_length - 1) := (
        X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000"
    );

    constant num_words          : integer := 64;

begin
    starter: process(en, internal_finished)
    begin
        if( en = '1' and en'event ) then
            enabled <= '1';
            processing <= '1';
            finished <= '0';
        end if;

        if (internal_finished = '1' and internal_finished'event ) then
            enabled <= '0';
            processing <= '0';
            finished <= '1';
        end if;
    end process starter;

    counter: process(clk, enabled)
    begin
        if(enabled = '1' and enabled'event) then
            current_word <= 0;
            internal_finished <= '0';
        end if;

        if(clk = '1' and clk'event ) then
            if enabled = '1' then

                if current_word = num_words - 1 then
                    current_word <= 0;
                    internal_finished <= '1';
                else
                    current_word <= current_word + 1;
                end if;
            end if;
        end if;
    end process counter;

    processor: process(clk)
        variable w2, w7, w15, w16   : word;
        variable s0, s1             : word;
        variable val                : word;

        subtype sixty_four_counter is integer range 0 to 63;
        variable word_counter       : sixty_four_counter := 0;
    begin
        if( clk = '1' and clk'event ) then
            if enabled = '1' then
                if word_counter < 16 then
                    word_out <= word_in;
                    word_buffer(buffer_index) <= word_in;

                else
                    w2 := word_buffer(calculate_index(buffer_length, buffer_index,  2));
                    w7 := word_buffer(calculate_index(buffer_length, buffer_index,  7));
                    w15 := word_buffer(calculate_index(buffer_length, buffer_index,  15));
                    w16 := word_buffer(calculate_index(buffer_length, buffer_index,  16));

                    s0 := little_sigma0(w15);
                    s1 := little_sigma1(w2);


                    val := add_words(add_words(s0, s1), add_words(w16, w7));

                    word_buffer(buffer_index) <= val;

                    word_out <= val;

                end if;

                if word_counter < 63 then
                    if word_counter = 0 then
                        output_valid <= '1';
                    end if;

                    word_counter := word_counter + 1;
                else
                    output_valid <= '1';
                    word_counter := 0;
                end if;

                buffer_index <= (buffer_index + 1) mod buffer_length;
            end if;
        end if;

    end process processor;




end architecture behavior;
