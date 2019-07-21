
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

        assert words_equal(add_words(X"ffffffff", X"00000000"), X"ffffffff")
            report "Can't add words!";

        assert words_equal(add_words(X"123488b8", X"00000000"), X"123488b8")
            report "Can't add words!";


        assert words_equal(add_words(X"2ffdff21", X"ccdcd1e3"), X"fcdad104")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"2ffdff21", X"ccdcd1e3")) &
                   "shdb: " & word_to_string(X"fcdad104");
        assert words_equal(add_words(X"cf457368", X"cbb5bf3e"), X"9afb32a6")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"cf457368", X"cbb5bf3e")) &
                   "shdb: " & word_to_string(X"9afb32a6");
        assert words_equal(add_words(X"69fae97d", X"74b42672"), X"deaf0fef")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"69fae97d", X"74b42672")) &
                   "shdb: " & word_to_string(X"deaf0fef");
        assert words_equal(add_words(X"9e38e0b8", X"6c596a7d"), X"0a924b35")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"9e38e0b8", X"6c596a7d")) &
                   "shdb: " & word_to_string(X"0a924b35");
        assert words_equal(add_words(X"4a4ed261", X"f3ae7ac9"), X"3dfd4d2a")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"4a4ed261", X"f3ae7ac9")) &
                   "shdb: " & word_to_string(X"3dfd4d2a");
        assert words_equal(add_words(X"87c906bf", X"ebfe3b9d"), X"73c7425c")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"87c906bf", X"ebfe3b9d")) &
                   "shdb: " & word_to_string(X"73c7425c");
        assert words_equal(add_words(X"d0779c18", X"d2a51b1d"), X"a31cb735")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"d0779c18", X"d2a51b1d")) &
                   "shdb: " & word_to_string(X"a31cb735");
        assert words_equal(add_words(X"eab3012e", X"07e4afa8"), X"f297b0d6")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"eab3012e", X"07e4afa8")) &
                   "shdb: " & word_to_string(X"f297b0d6");
        assert words_equal(add_words(X"73296b4a", X"646e9eb5"), X"d79809ff")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"73296b4a", X"646e9eb5")) &
                   "shdb: " & word_to_string(X"d79809ff");
        assert words_equal(add_words(X"28079ca3", X"fc1eff6a"), X"24269c0d")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"28079ca3", X"fc1eff6a")) &
                   "shdb: " & word_to_string(X"24269c0d");
        assert words_equal(add_words(X"54ae08fb", X"1c8d1db8"), X"713b26b3")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"54ae08fb", X"1c8d1db8")) &
                   "shdb: " & word_to_string(X"713b26b3");
        assert words_equal(add_words(X"0f75866c", X"7084617c"), X"7ff9e7e8")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"0f75866c", X"7084617c")) &
                   "shdb: " & word_to_string(X"7ff9e7e8");
        assert words_equal(add_words(X"a340082b", X"aa4e8db9"), X"4d8e95e4")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"a340082b", X"aa4e8db9")) &
                   "shdb: " & word_to_string(X"4d8e95e4");
        assert words_equal(add_words(X"77e7d45a", X"331ca17b"), X"ab0475d5")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"77e7d45a", X"331ca17b")) &
                   "shdb: " & word_to_string(X"ab0475d5");
        assert words_equal(add_words(X"cefe4150", X"aa3c60dc"), X"793aa22c")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"cefe4150", X"aa3c60dc")) &
                   "shdb: " & word_to_string(X"793aa22c");
        assert words_equal(add_words(X"a60d7dc9", X"fb83c984"), X"a191474d")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"a60d7dc9", X"fb83c984")) &
                   "shdb: " & word_to_string(X"a191474d");
        assert words_equal(add_words(X"4fe5de05", X"bf416bf7"), X"0f2749fc")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"4fe5de05", X"bf416bf7")) &
                   "shdb: " & word_to_string(X"0f2749fc");
        assert words_equal(add_words(X"2272ebfd", X"7d76f54a"), X"9fe9e147")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"2272ebfd", X"7d76f54a")) &
                   "shdb: " & word_to_string(X"9fe9e147");
        assert words_equal(add_words(X"e5e9da2c", X"57c2a832"), X"3dac825e")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"e5e9da2c", X"57c2a832")) &
                   "shdb: " & word_to_string(X"3dac825e");
        assert words_equal(add_words(X"5eacf132", X"ec1a1fc3"), X"4ac710f5")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"5eacf132", X"ec1a1fc3")) &
                   "shdb: " & word_to_string(X"4ac710f5");
        assert words_equal(add_words(X"7a6a1cb0", X"a72d5539"), X"219771e9")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"7a6a1cb0", X"a72d5539")) &
                   "shdb: " & word_to_string(X"219771e9");
        assert words_equal(add_words(X"15a198e2", X"754aa95d"), X"8aec423f")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"15a198e2", X"754aa95d")) &
                   "shdb: " & word_to_string(X"8aec423f");
        assert words_equal(add_words(X"3a064824", X"7f7535fa"), X"b97b7e1e")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"3a064824", X"7f7535fa")) &
                   "shdb: " & word_to_string(X"b97b7e1e");
        assert words_equal(add_words(X"c89d2f59", X"71de9c95"), X"3a7bcbee")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"c89d2f59", X"71de9c95")) &
                   "shdb: " & word_to_string(X"3a7bcbee");
        assert words_equal(add_words(X"63236d13", X"f005e695"), X"532953a8")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"63236d13", X"f005e695")) &
                   "shdb: " & word_to_string(X"532953a8");
        assert words_equal(add_words(X"55df3598", X"fa77b806"), X"5056ed9e")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"55df3598", X"fa77b806")) &
                   "shdb: " & word_to_string(X"5056ed9e");
        assert words_equal(add_words(X"d4934ee0", X"92a4487a"), X"6737975a")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"d4934ee0", X"92a4487a")) &
                   "shdb: " & word_to_string(X"6737975a");
        assert words_equal(add_words(X"368bc36c", X"c44ca95c"), X"fad86cc8")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"368bc36c", X"c44ca95c")) &
                   "shdb: " & word_to_string(X"fad86cc8");
        assert words_equal(add_words(X"0ad974ac", X"8b2ab6f3"), X"96042b9f")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"0ad974ac", X"8b2ab6f3")) &
                   "shdb: " & word_to_string(X"96042b9f");
        assert words_equal(add_words(X"cbd9d0ec", X"9c41e318"), X"681bb404")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"cbd9d0ec", X"9c41e318")) &
                   "shdb: " & word_to_string(X"681bb404");
        assert words_equal(add_words(X"6bf70a69", X"a285f353"), X"0e7cfdbc")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"6bf70a69", X"a285f353")) &
                   "shdb: " & word_to_string(X"0e7cfdbc");
        assert words_equal(add_words(X"c10b0060", X"13dbeb26"), X"d4e6eb86")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"c10b0060", X"13dbeb26")) &
                   "shdb: " & word_to_string(X"d4e6eb86");
        assert words_equal(add_words(X"6b854d89", X"c0872e07"), X"2c0c7b90")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"6b854d89", X"c0872e07")) &
                   "shdb: " & word_to_string(X"2c0c7b90");
        assert words_equal(add_words(X"f007f9a5", X"b35021d6"), X"a3581b7b")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"f007f9a5", X"b35021d6")) &
                   "shdb: " & word_to_string(X"a3581b7b");
        assert words_equal(add_words(X"7483b1d9", X"58fea18a"), X"cd825363")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"7483b1d9", X"58fea18a")) &
                   "shdb: " & word_to_string(X"cd825363");
        assert words_equal(add_words(X"59a3737b", X"0fae3006"), X"6951a381")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"59a3737b", X"0fae3006")) &
                   "shdb: " & word_to_string(X"6951a381");
        assert words_equal(add_words(X"183e81f2", X"be651d94"), X"d6a39f86")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"183e81f2", X"be651d94")) &
                   "shdb: " & word_to_string(X"d6a39f86");
        assert words_equal(add_words(X"9860a7a2", X"2bc0e940"), X"c42190e2")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"9860a7a2", X"2bc0e940")) &
                   "shdb: " & word_to_string(X"c42190e2");
        assert words_equal(add_words(X"df9f869b", X"e1a528f2"), X"c144af8d")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"df9f869b", X"e1a528f2")) &
                   "shdb: " & word_to_string(X"c144af8d");
        assert words_equal(add_words(X"1f8115eb", X"595dbf33"), X"78ded51e")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"1f8115eb", X"595dbf33")) &
                   "shdb: " & word_to_string(X"78ded51e");
        assert words_equal(add_words(X"bc17acd5", X"cbf60107"), X"880daddc")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"bc17acd5", X"cbf60107")) &
                   "shdb: " & word_to_string(X"880daddc");
        assert words_equal(add_words(X"0a3ba719", X"6c2fe228"), X"766b8941")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"0a3ba719", X"6c2fe228")) &
                   "shdb: " & word_to_string(X"766b8941");
        assert words_equal(add_words(X"bef4585a", X"366639d2"), X"f55a922c")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"bef4585a", X"366639d2")) &
                   "shdb: " & word_to_string(X"f55a922c");
        assert words_equal(add_words(X"e26e7ed2", X"171727f7"), X"f985a6c9")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"e26e7ed2", X"171727f7")) &
                   "shdb: " & word_to_string(X"f985a6c9");
        assert words_equal(add_words(X"b334b5ff", X"0c3b48ac"), X"bf6ffeab")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"b334b5ff", X"0c3b48ac")) &
                   "shdb: " & word_to_string(X"bf6ffeab");
        assert words_equal(add_words(X"3211d5ef", X"4f5ed62a"), X"8170ac19")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"3211d5ef", X"4f5ed62a")) &
                   "shdb: " & word_to_string(X"8170ac19");
        assert words_equal(add_words(X"915534ee", X"6ccf6b06"), X"fe249ff4")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"915534ee", X"6ccf6b06")) &
                   "shdb: " & word_to_string(X"fe249ff4");
        assert words_equal(add_words(X"36ae0b5c", X"ebb2252e"), X"2260308a")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"36ae0b5c", X"ebb2252e")) &
                   "shdb: " & word_to_string(X"2260308a");
        assert words_equal(add_words(X"015a42c8", X"e7443825"), X"e89e7aed")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"015a42c8", X"e7443825")) &
                   "shdb: " & word_to_string(X"e89e7aed");
        assert words_equal(add_words(X"6089bf87", X"817cba07"), X"e206798e")
            report "Python generated add is incorrect!" &
                   "is  : " & word_to_string(add_words(X"6089bf87", X"817cba07")) &
                   "shdb: " & word_to_string(X"e206798e");




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

        ----------------------------------------------------------------------
        -- test the little sigma0 function
        ----------------------------------------------------------------------
        assert words_equal(little_sigma0(X"ff00aa55"), X"9e8b6bde")
            report "little sigma 0 calculation not correct!";

        assert words_equal(little_sigma0(X"77777777"), X"3ddddddd")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"77777777")) &
                   "shdb: " & word_to_string(X"3ddddddd");


        assert words_equal(little_sigma0(X"b1bff1f8"), X"1b2aadb3")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"b1bff1f8")) &
                   "shdb: " & word_to_string(X"1b2aadb3");
        assert words_equal(little_sigma0(X"6a398fcd"), X"f4601868")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"6a398fcd")) &
                   "shdb: " & word_to_string(X"f4601868");
        assert words_equal(little_sigma0(X"b838f6ff"), X"d5c8813c")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"b838f6ff")) &
                   "shdb: " & word_to_string(X"d5c8813c");
        assert words_equal(little_sigma0(X"38267d84"), X"90158d42")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"38267d84")) &
                   "shdb: " & word_to_string(X"90158d42");
        assert words_equal(little_sigma0(X"ec0c49c0"), X"8e29aaa8")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"ec0c49c0")) &
                   "shdb: " & word_to_string(X"8e29aaa8");
        assert words_equal(little_sigma0(X"8bd21878"), X"6673c5cb")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"8bd21878")) &
                   "shdb: " & word_to_string(X"6673c5cb");
        assert words_equal(little_sigma0(X"bed5b6bf"), X"0508f20f")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"bed5b6bf")) &
                   "shdb: " & word_to_string(X"0508f20f");
        assert words_equal(little_sigma0(X"f817f7fd"), X"190daf15")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"f817f7fd")) &
                   "shdb: " & word_to_string(X"190daf15");
        assert words_equal(little_sigma0(X"48c84fba"), X"6e660b5a")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"48c84fba")) &
                   "shdb: " & word_to_string(X"6e660b5a");
        assert words_equal(little_sigma0(X"299ed8ff"), X"4d5f2cc9")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"299ed8ff")) &
                   "shdb: " & word_to_string(X"4d5f2cc9");
        assert words_equal(little_sigma0(X"9af1d19c"), X"5e0cff2c")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"9af1d19c")) &
                   "shdb: " & word_to_string(X"5e0cff2c");
        assert words_equal(little_sigma0(X"b7f603cb"), X"0163c183")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"b7f603cb")) &
                   "shdb: " & word_to_string(X"0163c183");
        assert words_equal(little_sigma0(X"8500c183"), X"27caf8f3")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"8500c183")) &
                   "shdb: " & word_to_string(X"27caf8f3");
        assert words_equal(little_sigma0(X"cad5ebe9"), X"b035641f")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"cad5ebe9")) &
                   "shdb: " & word_to_string(X"b035641f");
        assert words_equal(little_sigma0(X"2226426f"), X"4a9b4c40")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"2226426f")) &
                   "shdb: " & word_to_string(X"4a9b4c40");
        assert words_equal(little_sigma0(X"8c9a1223"), X"d2029546")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"8c9a1223")) &
                   "shdb: " & word_to_string(X"d2029546");
        assert words_equal(little_sigma0(X"2a4013ab"), X"57f648c2")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"2a4013ab")) &
                   "shdb: " & word_to_string(X"57f648c2");
        assert words_equal(little_sigma0(X"88628f9c"), X"8bfbb6f4")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"88628f9c")) &
                   "shdb: " & word_to_string(X"8bfbb6f4");
        assert words_equal(little_sigma0(X"e7410e05"), X"54a7da0c")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"e7410e05")) &
                   "shdb: " & word_to_string(X"54a7da0c");
        assert words_equal(little_sigma0(X"8173764c"), X"54bfa879")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"8173764c")) &
                   "shdb: " & word_to_string(X"54bfa879");
        assert words_equal(little_sigma0(X"499d78fe"), X"ab9f0789")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"499d78fe")) &
                   "shdb: " & word_to_string(X"ab9f0789");
        assert words_equal(little_sigma0(X"65d4f915"), X"18346fa5")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"65d4f915")) &
                   "shdb: " & word_to_string(X"18346fa5");
        assert words_equal(little_sigma0(X"34aa482c"), X"ccf710bf")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"34aa482c")) &
                   "shdb: " & word_to_string(X"ccf710bf");
        assert words_equal(little_sigma0(X"968cb14b"), X"a9ae6ae8")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"968cb14b")) &
                   "shdb: " & word_to_string(X"a9ae6ae8");
        assert words_equal(little_sigma0(X"694bbddf"), X"5c8c3a92")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"694bbddf")) &
                   "shdb: " & word_to_string(X"5c8c3a92");
        assert words_equal(little_sigma0(X"c4a93b96"), X"7bf9c42f")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"c4a93b96")) &
                   "shdb: " & word_to_string(X"7bf9c42f");
        assert words_equal(little_sigma0(X"cd56a4e0"), X"71084a80")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"cd56a4e0")) &
                   "shdb: " & word_to_string(X"71084a80");
        assert words_equal(little_sigma0(X"e9e0f7e7"), X"ef16256b")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"e9e0f7e7")) &
                   "shdb: " & word_to_string(X"ef16256b");
        assert words_equal(little_sigma0(X"2c85d862"), X"b7d13b9d")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"2c85d862")) &
                   "shdb: " & word_to_string(X"b7d13b9d");
        assert words_equal(little_sigma0(X"3cf9b058"), X"dbf0ca55")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"3cf9b058")) &
                   "shdb: " & word_to_string(X"dbf0ca55");
        assert words_equal(little_sigma0(X"b0310188"), X"47046e3e")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"b0310188")) &
                   "shdb: " & word_to_string(X"47046e3e");
        assert words_equal(little_sigma0(X"db517071"), X"a4c0fa3a")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"db517071")) &
                   "shdb: " & word_to_string(X"a4c0fa3a");
        assert words_equal(little_sigma0(X"448d9597"), X"437d78ba")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"448d9597")) &
                   "shdb: " & word_to_string(X"437d78ba");
        assert words_equal(little_sigma0(X"41487418"), X"25ad8e39")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"41487418")) &
                   "shdb: " & word_to_string(X"25ad8e39");
        assert words_equal(little_sigma0(X"9daa13f1"), X"74727133")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"9daa13f1")) &
                   "shdb: " & word_to_string(X"74727133");
        assert words_equal(little_sigma0(X"ea2b598e"), X"d6f28708")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"ea2b598e")) &
                   "shdb: " & word_to_string(X"d6f28708");
        assert words_equal(little_sigma0(X"c7b72aae"), X"8fd23aed")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"c7b72aae")) &
                   "shdb: " & word_to_string(X"8fd23aed");
        assert words_equal(little_sigma0(X"79dc3832"), X"65c4a101")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"79dc3832")) &
                   "shdb: " & word_to_string(X"65c4a101");
        assert words_equal(little_sigma0(X"00b67fad"), X"c5fce327")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"00b67fad")) &
                   "shdb: " & word_to_string(X"c5fce327");
        assert words_equal(little_sigma0(X"c8ac331c"), X"2c43ec2e")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"c8ac331c")) &
                   "shdb: " & word_to_string(X"2c43ec2e");
        assert words_equal(little_sigma0(X"6005c8e9"), X"acfaea8d")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"6005c8e9")) &
                   "shdb: " & word_to_string(X"acfaea8d");
        assert words_equal(little_sigma0(X"6184f613"), X"17774f4f")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"6184f613")) &
                   "shdb: " & word_to_string(X"17774f4f");
        assert words_equal(little_sigma0(X"84c9cd81"), X"60f0cb19")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"84c9cd81")) &
                   "shdb: " & word_to_string(X"60f0cb19");
        assert words_equal(little_sigma0(X"e657e784"), X"ece76aaa")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"e657e784")) &
                   "shdb: " & word_to_string(X"ece76aaa");
        assert words_equal(little_sigma0(X"50d6bdf3"), X"43c7aef0")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"50d6bdf3")) &
                   "shdb: " & word_to_string(X"43c7aef0");
        assert words_equal(little_sigma0(X"2e1879e1"), X"d9e77449")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"2e1879e1")) &
                   "shdb: " & word_to_string(X"d9e77449");
        assert words_equal(little_sigma0(X"37f87905"), X"12d1b22c")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"37f87905")) &
                   "shdb: " & word_to_string(X"12d1b22c");
        assert words_equal(little_sigma0(X"09dd8c96"), X"4e0d88fc")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"09dd8c96")) &
                   "shdb: " & word_to_string(X"4e0d88fc");
        assert words_equal(little_sigma0(X"e7351f09"), X"48eab012")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"e7351f09")) &
                   "shdb: " & word_to_string(X"48eab012");
        assert words_equal(little_sigma0(X"634d7c46"), X"dfbeada3")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"634d7c46")) &
                   "shdb: " & word_to_string(X"dfbeada3");
        assert words_equal(little_sigma0(X"88888888"), X"22222222")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma0(X"88888888")) &
                   "shdb: " & word_to_string(X"22222222");



        --report "Finished Little Sigma!";

        ----------------------------------------------------------------------
        -- test the little sigma 1 functino
        ----------------------------------------------------------------------
        assert words_equal(little_sigma1(X"ff00aa55"), X"405f804a")
            report "little Sigma 1 calculation is not correct!";

        assert words_equal(little_sigma1(X"4116da62"), X"b66d2d1f")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"4116da62")) &
                   "shdb: " & word_to_string(X"b66d2d1f");
        assert words_equal(little_sigma1(X"e352b468"), X"0c81b96e")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"e352b468")) &
                   "shdb: " & word_to_string(X"0c81b96e");
        assert words_equal(little_sigma1(X"bbfa9817"), X"1f27d424")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"bbfa9817")) &
                   "shdb: " & word_to_string(X"1f27d424");
        assert words_equal(little_sigma1(X"6a8876bd"), X"3593ba08")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"6a8876bd")) &
                   "shdb: " & word_to_string(X"3593ba08");
        assert words_equal(little_sigma1(X"789c2034"), X"94029455")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"789c2034")) &
                   "shdb: " & word_to_string(X"94029455");
        assert words_equal(little_sigma1(X"b749acc5"), X"e3d7bf26")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"b749acc5")) &
                   "shdb: " & word_to_string(X"e3d7bf26");
        assert words_equal(little_sigma1(X"286b4c8b"), X"cfdeebeb")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"286b4c8b")) &
                   "shdb: " & word_to_string(X"cfdeebeb");
        assert words_equal(little_sigma1(X"1586a470"), X"86b369da")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"1586a470")) &
                   "shdb: " & word_to_string(X"86b369da");
        assert words_equal(little_sigma1(X"b330468b"), X"2bb863ef")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"b330468b")) &
                   "shdb: " & word_to_string(X"2bb863ef");
        assert words_equal(little_sigma1(X"9baf2f4a"), X"726af569")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"9baf2f4a")) &
                   "shdb: " & word_to_string(X"726af569");
        assert words_equal(little_sigma1(X"5595bb41"), X"6adde516")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"5595bb41")) &
                   "shdb: " & word_to_string(X"6adde516");
        assert words_equal(little_sigma1(X"2889a3f9"), X"e589933d")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"2889a3f9")) &
                   "shdb: " & word_to_string(X"e589933d");
        assert words_equal(little_sigma1(X"dd482808"), X"11322707")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"dd482808")) &
                   "shdb: " & word_to_string(X"11322707");
        assert words_equal(little_sigma1(X"3ca5309d"), X"3e52108a")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"3ca5309d")) &
                   "shdb: " & word_to_string(X"3e52108a");
        assert words_equal(little_sigma1(X"9c1880bc"), X"506edbaf")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"9c1880bc")) &
                   "shdb: " & word_to_string(X"506edbaf");
        assert words_equal(little_sigma1(X"bbf9c823"), X"dd3b54f1")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"bbf9c823")) &
                   "shdb: " & word_to_string(X"dd3b54f1");
        assert words_equal(little_sigma1(X"5e4ba0d8"), X"a460b604")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"5e4ba0d8")) &
                   "shdb: " & word_to_string(X"a460b604");
        assert words_equal(little_sigma1(X"41ac57d2"), X"a10303f6")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"41ac57d2")) &
                   "shdb: " & word_to_string(X"a10303f6");
        assert words_equal(little_sigma1(X"62cb69b9"), X"d9f32fe6")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"62cb69b9")) &
                   "shdb: " & word_to_string(X"d9f32fe6");
        assert words_equal(little_sigma1(X"6a96e04e"), X"ac345da1")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"6a96e04e")) &
                   "shdb: " & word_to_string(X"ac345da1");
        assert words_equal(little_sigma1(X"283aaa1a"), X"00445fb0")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"283aaa1a")) &
                   "shdb: " & word_to_string(X"00445fb0");
        assert words_equal(little_sigma1(X"9f4ae597"), X"2e5eeef5")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"9f4ae597")) &
                   "shdb: " & word_to_string(X"2e5eeef5");
        assert words_equal(little_sigma1(X"47ec4876"), X"ad241019")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"47ec4876")) &
                   "shdb: " & word_to_string(X"ad241019");
        assert words_equal(little_sigma1(X"d906fe0e"), X"a0f0f61c")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"d906fe0e")) &
                   "shdb: " & word_to_string(X"a0f0f61c");
        assert words_equal(little_sigma1(X"ad7ef7eb"), X"a523fcad")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"ad7ef7eb")) &
                   "shdb: " & word_to_string(X"a523fcad");
        assert words_equal(little_sigma1(X"fb1a0ed9"), X"4689046d")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"fb1a0ed9")) &
                   "shdb: " & word_to_string(X"4689046d");
        assert words_equal(little_sigma1(X"d5526002"), X"7c34649b")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"d5526002")) &
                   "shdb: " & word_to_string(X"7c34649b");
        assert words_equal(little_sigma1(X"892f6145"), X"5ca83e6a")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"892f6145")) &
                   "shdb: " & word_to_string(X"5ca83e6a");
        assert words_equal(little_sigma1(X"ad84b94a"), X"cba7625c")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"ad84b94a")) &
                   "shdb: " & word_to_string(X"cba7625c");
        assert words_equal(little_sigma1(X"ea27a038"), X"2421e1bf")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"ea27a038")) &
                   "shdb: " & word_to_string(X"2421e1bf");
        assert words_equal(little_sigma1(X"2fda8bff"), X"148b84b4")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"2fda8bff")) &
                   "shdb: " & word_to_string(X"148b84b4");
        assert words_equal(little_sigma1(X"c2a36a1a"), X"d87e91df")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"c2a36a1a")) &
                   "shdb: " & word_to_string(X"d87e91df");
        assert words_equal(little_sigma1(X"6cb7b7bb"), X"2d31f620")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"6cb7b7bb")) &
                   "shdb: " & word_to_string(X"2d31f620");
        assert words_equal(little_sigma1(X"bcd8e001"), X"6c2fdfcf")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"bcd8e001")) &
                   "shdb: " & word_to_string(X"6c2fdfcf");
        assert words_equal(little_sigma1(X"e588930d"), X"5bde2c51")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"e588930d")) &
                   "shdb: " & word_to_string(X"5bde2c51");
        assert words_equal(little_sigma1(X"a75b5cf2"), X"c5ced191")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"a75b5cf2")) &
                   "shdb: " & word_to_string(X"c5ced191");
        assert words_equal(little_sigma1(X"9f0baef7"), X"a282fe8f")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"9f0baef7")) &
                   "shdb: " & word_to_string(X"a282fe8f");
        assert words_equal(little_sigma1(X"d3674442"), X"4a9dea0e")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"d3674442")) &
                   "shdb: " & word_to_string(X"4a9dea0e");
        assert words_equal(little_sigma1(X"1fe6de1f"), X"b4cb95b8")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"1fe6de1f")) &
                   "shdb: " & word_to_string(X"b4cb95b8");
        assert words_equal(little_sigma1(X"a220546f"), X"2092ad41")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"a220546f")) &
                   "shdb: " & word_to_string(X"2092ad41");
        assert words_equal(little_sigma1(X"b4722b0a"), X"50c9103d")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"b4722b0a")) &
                   "shdb: " & word_to_string(X"50c9103d");
        assert words_equal(little_sigma1(X"f0160244"), X"c156e389")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"f0160244")) &
                   "shdb: " & word_to_string(X"c156e389");
        assert words_equal(little_sigma1(X"e5e96901"), X"9999b413")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"e5e96901")) &
                   "shdb: " & word_to_string(X"9999b413");
        assert words_equal(little_sigma1(X"a9171c92"), X"6df1446e")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"a9171c92")) &
                   "shdb: " & word_to_string(X"6df1446e");
        assert words_equal(little_sigma1(X"bd66469e"), X"ebb3d08e")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"bd66469e")) &
                   "shdb: " & word_to_string(X"ebb3d08e");
        assert words_equal(little_sigma1(X"8f86ea59"), X"a8441789")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"8f86ea59")) &
                   "shdb: " & word_to_string(X"a8441789");
        assert words_equal(little_sigma1(X"2e427a78"), X"72788277")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"2e427a78")) &
                   "shdb: " & word_to_string(X"72788277");
        assert words_equal(little_sigma1(X"175a5087"), X"6256bfd2")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"175a5087")) &
                   "shdb: " & word_to_string(X"6256bfd2");
        assert words_equal(little_sigma1(X"eddce6f2"), X"ef9c5c6c")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"eddce6f2")) &
                   "shdb: " & word_to_string(X"ef9c5c6c");
        assert words_equal(little_sigma1(X"844425c9"), X"967ce3a3")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"844425c9")) &
                   "shdb: " & word_to_string(X"967ce3a3");

        assert words_equal(little_sigma1(X"88888888"), X"55777777")
            report "Python generated sigma0 is incorrect!" &
                   "is  : " & word_to_string(little_sigma1(X"88888888")) &
                   "shdb: " & word_to_string(X"55777777");



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

