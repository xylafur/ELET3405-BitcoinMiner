library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package sha256_pkg is

    ---------------------------------------------------------------------------
    --  Types
    ---------------------------------------------------------------------------
    subtype word is std_logic_vector(0 to 31);
    type word_vector is array(integer range <>) of word;

    subtype input_msg_length is unsigned(0 to 7);
    subtype input_msg is std_logic_vector(0 to 2**input_msg_length'length - 1);


    subtype hash is std_logic_vector(0 to 255);
    type hash_vector is array(integer range <>) of hash;

    subtype uint_64 is unsigned(0 to 63);
    subtype uint_32 is unsigned(0 to 31);


    ---------------------------------------------------------------------------
    --  Constant Values
    ---------------------------------------------------------------------------

----------------------------------
--array of initial hash values
----------------------------------
    constant H_init : word_vector(0 to 7) := (
        x"6a09e667",
        x"bb67ae85",
        x"3c6ef372",
        x"a54ff53a",
        x"510e527f",
        x"9b05688c",
        x"1f83d9ab",
        x"5be0cd19"
    );

    constant dm_initial: hash :=
        H_init(0) & H_init(1) & H_init(2) & H_init(3) &
        H_init(4) & H_init(5) & H_init(6) & H_init(7);


    constant K_constants :  word_vector(0 to 63) := (
        x"428a2f98", x"71374491", x"b5c0fbcf", x"e9b5dba5", x"3956c25b", x"59f111f1", x"923f82a4", x"ab1c5ed5",
        x"d807aa98", x"12835b01", x"243185be", x"550c7dc3", x"72be5d74", x"80deb1fe", x"9bdc06a7", x"c19bf174",
        x"e49b69c1", x"efbe4786", x"0fc19dc6", x"240ca1cc", x"2de92c6f", x"4a7484aa", x"5cb0a9dc", x"76f988da",
        x"983e5152", x"a831c66d", x"b00327c8", x"bf597fc7", x"c6e00bf3", x"d5a79147", x"06ca6351", x"14292967",
        x"27b70a85", x"2e1b2138", x"4d2c6dfc", x"53380d13", x"650a7354", x"766a0abb", x"81c2c92e", x"92722c85",
        x"a2bfe8a1", x"a81a664b", x"c24b8b70", x"c76c51a3", x"d192e819", x"d6990624", x"f40e3585", x"106aa070",
        x"19a4c116", x"1e376c08", x"2748774c", x"34b0bcb5", x"391c0cb3", x"4ed8aa4a", x"5b9cca4f", x"682e6ff3",
        x"748f82ee", x"78a5636f", x"84c87814", x"8cc70208", x"90befffa", x"a4506ceb", x"bef9a3f7", x"c67178f2"
    );


    ---------------------------------------------------------------------------
    --  Function Declarations
    ---------------------------------------------------------------------------
    function calculate_index(buf_len: integer; current_index: integer;
                             desired_index: integer) return integer;
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

    function bit_to_string (a: std_logic) return string;
    function word_to_string (a: word) return string;
    function hash_to_string (a: hash) return string;
    function unsigned_to_string ( a: unsigned) return string;

end sha256_pkg;

package body sha256_pkg is
    function calculate_index(buf_len: integer; current_index: integer;
                             desired_index: integer) return integer is
        variable calc_index             : integer;
    begin
        calc_index := current_index - desired_index;
        if  calc_index >= 0 then
            return calc_index;
        else
            return buf_len - (desired_index - current_index);
        end if;
    end function;


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


    ---------------------------------------------------------------------------
    --  Useful in simulation for debugging
    ---------------------------------------------------------------------------
    function bit_to_string (a: std_logic) return string is
        variable b : string (1 to 2) := (others => NUL);
    begin
        b(1) := std_logic'image(a)(2);
        return b;
    end function;


    function word_to_string ( a: word) return string is
        variable b : string (1 to a'length) := (others => NUL);
        variable stri : integer := 1;
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
            stri := stri+1;
        end loop;

        return b;
    end function;


--    function integer_to_string (a: integer) return string is
--        variable b : string (1 to a'length) := (others => NUL);
--        variable stri : integer := 1;
--    begin
--        for i in a'range loop
--            b(stri) := std_logic'image(a((i)))(2);
--            stri := stri+1;
--        end loop;
--
--        return b;
--    end function;


    function hash_to_string ( a: hash) return string is
        variable b : string (1 to a'length) := (others => NUL);
        variable stri : integer := 1;
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
            stri := stri+1;
        end loop;

        return b;
    end function;

    function unsigned_to_string ( a: unsigned) return string is
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

