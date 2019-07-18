library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package sha256_pkg is
    subtype word is std_logic_vector(0 to 31);
    subtype hash is std_logic_vector(0 to 255);
    subtype uint_64 is unsigned(0 to 63);
    subtype uint_32 is unsigned(0 to 31);

    function rotate_right(x: word; i: integer) return word;
    function shift_right(x: word; i: integer) return word;

    function little_sigma0(x: word) return word;
    function little_sigma1(x: word) return word;

    function big_sigma0(x: word) return word;
    function big_sigma1(x: word) return word;

    function ch(e: word; f: word; g: word) return word;
    function maj(a: word; b: word; c: word) return word;

    function add_words(a: word; b: word) return word;
    function words_equal(a: word; b: word) return boolean;
    function to_string ( a: word) return string;

end sha256_pkg;

package body sha256_pkg is

    ---------------------------------------------------------------------------
    --  Bit manipulation functions for words
    ---------------------------------------------------------------------------
    function rotate_right(x: word; i: integer) return word is
    begin
        if i = integer(1) then
            return x(31) & x(0 to 30);
        else
            return x(31 - i + 1 to 31) & x(0 to 31 - i);
        end if;
    end function;

    -- logical shift< sign is not preserved
    function shift_right(x: word; i: integer) return word is
    begin
        return (0 to i-1 => '0') & x(0 to 31 - i);
    end function;

    ---------------------------------------------------------------------------
    -- Little sigma functions
    ---------------------------------------------------------------------------
    function little_sigma0(x: word) return word is
    begin
        return rotate_right(x, 7) xor rotate_right(x, 18) xor shift_right(x, 3);
    end function;

    function little_sigma1(x: word) return word is
    begin
        return rotate_right(x, 17) xor rotate_right(x, 19) xor shift_right(x, 10);
    end function;

    ---------------------------------------------------------------------------
    -- Big sigma functions
    ---------------------------------------------------------------------------
    function big_sigma0(x: word) return word is
    begin
        return rotate_right(x, 2) xor rotate_right(x, 13) xor rotate_right(x, 22);
    end function;

    function big_sigma1(x: word) return word is
    begin
        return rotate_right(x, 6) xor rotate_right(x, 11) xor rotate_right(x, 25);
    end function;


    ---------------------------------------------------------------------------
    --  Other sha related mathematical functions
    ---------------------------------------------------------------------------
    function ch(e: word; f: word; g: word) return word is
    begin
        return (e and f) xor ((not e) and g);
    end function;

    function maj(a: word; b: word; c: word) return word is
    begin
        return (a and b) xor (a and c) xor (b and c);
    end function;

    ---------------------------------------------------------------------------
    -- For adding words
    ---------------------------------------------------------------------------
    function add_words(a: word; b: word) return word is
        variable a_unsigned     : unsigned(0 to 31);
        variable b_unsigned     : unsigned(0 to 31);
        variable sum            : unsigned(0 to 31);
        variable ret            : std_logic_vector(0 to 31);
    begin
        a_unsigned := unsigned(a);
        b_unsigned := unsigned(b);
        sum := a_unsigned + b_unsigned;
        ret := std_logic_vector(sum);

        return ret;

    end function;

    ---------------------------------------------------------------------------
    -- For comparing words
    ---------------------------------------------------------------------------
    function words_equal(a: word; b: word) return boolean is
    begin
        for i in 0 to 31 loop
            if a(i) /= b(i) then
                return false;
            end if;
        end loop;

        return true;
    end function;

    function to_string ( a: word) return string is
        variable b : string (1 to a'length) := (others => NUL);
        variable stri : integer := 1;
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
            stri := stri+1;
        end loop;

        return b;
    end function;

end package body sha256_pkg;

