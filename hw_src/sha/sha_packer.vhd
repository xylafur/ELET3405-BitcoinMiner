library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;


entity SHA_Packer is
    port(
        msg         : in input_msg;
        msg_length  : in input_msg_length;

        en          : in std_logic;
        clk         : in std_logic;


        processing  : out std_logic := '0';
        valid       : out std_logic := '0';
        finished    : out std_logic := '0';
        w_out       : out word


    );
end entity SHA_Packer;

architecture behavior of SHA_Packer is
    signal bit_index            : unsigned(0 to 8) := b"000000000";
    signal run_counter          : integer := 0;
    signal enabled              : std_logic := '0';
    signal internal_finished    : std_logic := '0';
begin
    starter: process(en, internal_finished)
    begin
        if(en = '1' and en'event ) then
            enabled <= '1';
            processing <= '1';
        end if;

        if(internal_finished = '1' and internal_finished'event ) then
            enabled <= '0';
            processing <= '0';
        end if;
    end process starter;

    exposer: process(enabled)
    begin
        if(enabled = '1' and enabled'event ) then
            finished <= '0';
        end if;

        if(enabled = '0' and enabled'event ) then
            finished <= '1';
        end if;
    end process exposer;

    counter: process(clk, enabled)
        constant word_length : integer := 32;
    begin
        if(clk = '1' and clk'event ) then
            if run_counter = 15 then
                internal_finished <= '1';
                bit_index <= b"000000000";
                run_counter <= 0;
            else
                bit_index <= bit_index + word_length;
                run_counter <= run_counter + 1;
            end if;
        end if;

        if(enabled = '1' and enabled'event ) then
            internal_finished <= '0';
            bit_index <= b"000000000";
        end if;

    end process counter;

    pack: process(clk)
        -- each word is 32 bits
        constant word_length : integer := 32;
        variable temp: integer;
    begin
        if(clk = '1' and clk'event ) then
           if enabled = '1' then
                temp := to_integer(bit_index) + word_length;

                -- we are still taking bits from within the message
                if  temp <= to_integer(msg_length) then
                    w_out <= msg(to_integer(bit_index) to temp-1);
                    valid <= '1';

                -- We are on the final word, we need to output the length of
                -- the message padded with 0's on the left!
                elsif bit_index + word_length = b"000000000" then
                    -- this temp represents this number of zeros to pad with
                    temp := word_length - msg_length'length;
                    w_out <= (0 to temp - 1 => '0') & std_logic_vector(msg_length);


                -- we have finished taking bits from the message, we are beyond
                -- the message, only returning 0's now
                elsif to_integer(bit_index) > to_integer(msg_length) then
                    w_out <= (w_out'range => '0');

                -- we are stratled inbetween the end of the msg and the 0s, we
                -- have to add the 1 in the proper place and then fill the rest
                -- of that word with 0's
                else
                    -- how many bits of the word do we need?  This plus the bit
                    -- index will be where the one will be, the rest will be 0s
                    temp := to_integer(msg_length) - to_integer(bit_index);
                    w_out <= msg(to_integer(bit_index) to
                                 to_integer(msg_length) - 1) &
                            '1' & (temp + 1 to word_length - 1 => '0');

                end if;
            else
                valid <= '0';
            end if;
        end if;
    end process pack;

end architecture behavior;
