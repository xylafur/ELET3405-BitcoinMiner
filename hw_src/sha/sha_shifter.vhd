library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;

entity SHA_Shifter is
    port(
        reset   :  in std_logic;
        en      :  in std_logic;
        i       :  in unsigned(0 to 5);

        clk     : in std_logic;

        k       : in word;
        w       : in word;

        dm_in   : in hash;

        dm_out  : out hash
    );
end SHA_Shifter;

architecture behavior of SHA_Shifter is
begin
    compress: process(clk)
        variable a, b, c, d, e, f, g, h : word;
        variable temp1, temp2           : word;
    begin
        if(clk = '1' and clk'event) then
            a := word(dm_in(0*32 to 0*32 + 31));
            b := word(dm_in(1*32 to 1*32 + 31));
            c := word(dm_in(2*32 to 2*32 + 31));
            d := word(dm_in(3*32 to 3*32 + 31));
            e := word(dm_in(4*32 to 4*32 + 31));
            f := word(dm_in(5*32 to 5*32 + 31));
            g := word(dm_in(6*32 to 6*32 + 31));
            h := word(dm_in(7*32 to 7*32 + 31));


            -- bottleneck right here
            temp1 := add_words(
                        add_words(
                            add_words(h, k),
                            add_words(ch(e, f, g), w)),
                        big_sigma1(e));

            temp2 := add_words(big_sigma0(a), maj(a, b, c));

            h := g;
            g := f;
            f := e;
            e := add_words(d, temp1);
            d := c;
            c := b;
            b := a;
            a := add_words(temp1, temp2);

            dm_out <= a & b & c & d & e & f & g & h;

        end if;
    end process compress;
end architecture behavior;

