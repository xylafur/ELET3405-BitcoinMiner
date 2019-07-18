
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_Package_tb is
end SHA_Package_tb;

architecture testbench of SHA_Package_tb is
begin
    stimulus: process
    begin

        -- Test the words_equal function
        assert  words_equal(X"00112233", X"00112233")
            report "Words equal function incorrect!";

        assert (not words_equal(X"00112233", X"00112234"))
            report "Words equal function incorrect!";


        -- Test that we can add words
        assert words_equal(add_words(X"00000011", X"00000011"), X"00000022")
            report "Can't add words!";

        assert words_equal(add_words(X"ffffffff", X"ffffffff"), X"fffffffe")
            report "Can't add words!";


        -- check the right rotate functin
        assert words_equal(rotate_right(X"00112233", 4), X"30011223")
            report "Right rotate incorrect!";

        assert words_equal(rotate_right(X"fedcba98", 8), X"98fedcba")
            report "Right rotate incorrect!";


        -- check that the shift rigth function works
        assert words_equal(shift_right(X"44332211", 4), X"04433221")
            report "Shift right function does not work!";

        assert words_equal(shift_right(X"44332211", 16), X"00004433")
            report "Shift right function does not work!";


        -- test the little sigma0 function
        assert words_equal(little_sigma0(X"ff00aa55"), X"9e8b6bde")
            report "little sigma 0 calculation not correct!";

        -- test the little sigma 1 functino
        assert words_equal(little_sigma1(X"ff00aa55"), X"405f804a")
            report "little Sigma 1 calculation is not correct!";

        -- test the big sigma 0 functino
        assert words_equal(big_sigma0(X"ff00aa55"), X"2fc6856c")
            report "big Sigma 0 calculation is not correct!";

        -- test the big sigma 1 functino
        assert words_equal(big_sigma1(X"ff00aa55"), X"9d16c843")
            report "big Sigma 1 calculation is not correct!";

        -- check the ch function
        assert words_equal(ch(X"f6129abd", X"aad43217", X"94759373"), X"a2751357")
            report "Maj calculation is incorrect!";

        -- check the maj function
        assert words_equal(maj(X"f6129abd", X"aad43217", X"94759373"), X"b6549237")
            report "Maj calculation is incorrect!";



        report "Testing Over!";
        wait;


    end process stimulus;
end architecture testbench;
