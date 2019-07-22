library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;

entity SHA_Shifter is
    port(
        reset   :  in std_logic;
        en      :  in std_logic;

        clk     : in std_logic;

        k       : in word;
        w       : in word;

        dm_in   : in hash;

        dm_out  : out hash
    );
end SHA_Shifter;

architecture behavior of SHA_Shifter is
    signal temp1, temp2                 : word;
    signal temp1_valid, temp2_valid     : std_logic := '0';
    signal clk_counter                  : unsigned(0 to 1) := b"00";
begin
    clk_counter_process: process(clk, en)
    begin
        -- WHen enable is toggled, we want to make sure that we are in sync
        -- with the manager module, so we reset to 0
        if(en = '1' and en'event) then
            clk_counter <= b"00";
        end if;

        if(clk = '1' and clk'event and en = '1') then
            clk_counter <= clk_counter + 1;
        end if;

    end process clk_counter_process;

    temp1_calc: process(clk)
        variable a, b, c, d, e, f, g, h : word;
    begin
        if(clk = '1' and clk'event) then
            if en = '1' then
                if clk_counter = 1 then
                    a := word(dm_in(0*32 to 0*32 + 31));
                    b := word(dm_in(1*32 to 1*32 + 31));
                    c := word(dm_in(2*32 to 2*32 + 31));
                    d := word(dm_in(3*32 to 3*32 + 31));
                    e := word(dm_in(4*32 to 4*32 + 31));
                    f := word(dm_in(5*32 to 5*32 + 31));
                    g := word(dm_in(6*32 to 6*32 + 31));
                    h := word(dm_in(7*32 to 7*32 + 31));

                    -- bottleneck right here
                    temp1 <= add_words(
                                add_words(
                                    add_words(h, k),
                                    add_words(ch(e, f, g), w)),
                                big_sigma1(e));
                end if;
            end if;
        end if;
    end process temp1_calc;

    temp2_calc: process(clk)
        variable a, b, c, d, e, f, g, h : word;
    begin
        if(clk = '1' and clk'event) then
            if en = '1' then
                if clk_counter = 1 then
                    a := word(dm_in(0*32 to 0*32 + 31));
                    b := word(dm_in(1*32 to 1*32 + 31));
                    c := word(dm_in(2*32 to 2*32 + 31));
                    d := word(dm_in(3*32 to 3*32 + 31));
                    e := word(dm_in(4*32 to 4*32 + 31));
                    f := word(dm_in(5*32 to 5*32 + 31));
                    g := word(dm_in(6*32 to 6*32 + 31));
                    h := word(dm_in(7*32 to 7*32 + 31));

                    temp2 <= add_words(big_sigma0(a), maj(a, b, c));
                end if;
            end if;
        end if;
    end process temp2_calc;

    compress: process(clk)
        variable a, b, c, d, e, f, g, h : word;
        variable calc_hash: hash;
    begin
        if(clk = '1' and clk'event) then
            if en = '1' then
                if clk_counter = 2 then
                    a := word(dm_in(0*32 to 0*32 + 31));
                    b := word(dm_in(1*32 to 1*32 + 31));
                    c := word(dm_in(2*32 to 2*32 + 31));
                    d := word(dm_in(3*32 to 3*32 + 31));
                    e := word(dm_in(4*32 to 4*32 + 31));
                    f := word(dm_in(5*32 to 5*32 + 31));
                    g := word(dm_in(6*32 to 6*32 + 31));
                    h := word(dm_in(7*32 to 7*32 + 31));

                    h := g;
                    g := f;
                    f := e;
                    e := add_words(d, temp1);
                    d := c;
                    c := b;
                    b := a;
                    a := add_words(temp1, temp2);

                    calc_hash := a & b & c & d & e & f & g & h;
                    --report "Shifter Hash: " & hash_to_string(calc_hash);

                    dm_out <= calc_hash;

                end if;
            end if;
        end if;
    end process compress;

end architecture behavior;


