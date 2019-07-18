library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;

entity SHA_Shifter is
    port(
        reset   :  in std_logic;
        en      :  in std_logic;
        -- i       :  in uint_64;

        clk     : in std_logic;

        -- wi_in   : in word;
        dm_in   : in hash;

        wi_out  : out word
        -- dm_out  : in hash
    );
end SHA_Shifter;

architecture behavior of SHA_Shifter is

begin
    compress: process(clk)
        variable a, b, c, d, e, f, g, h : word;
        variable temp1, temp2, ch, maj  : word;
        variable s0, s1                 : uint_32;
    begin
        if(clk = '1' and clk'event) then

            a := word(dm_in(0*32 to 0*32 + 31));
            b := word(dm_in(1*32 to 1*32 + 31));
            c := word(dm_in(2*32 to 2*32 + 31));
            d := word(dm_in(3*32 to 3*32 + 31));
            e := word(dm_in(4*32 to 4*32 + 31));
            f := word(dm_in(5*32 to 5*32 + 31));
            g := word(dm_in(5*32 to 5*32 + 31));
            h := word(dm_in(5*32 to 5*32 + 31));


            --temp1 = 

            wi_out <= (others => '1');





        end if;
    end process compress;
end architecture behavior;
