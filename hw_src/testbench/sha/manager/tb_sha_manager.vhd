
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_Manager_tb is
end SHA_Manager_tb;

architecture testbench of SHA_Manager_tb is
    signal reset            : std_logic := '0';
    signal enable           : std_logic := '0';

    signal clk              : std_logic;

    signal w                : word;

    signal dm_out           : hash;
    signal tb1_finished     : std_logic := '0';
    signal processing       : std_logic := '0';

    constant clk_period     : time := 50 ns;

begin
    manager_tb_1: entity work.SHA_Manager
        port map(
            clk => clk,
            en => enable,
            reset => reset,
            processing => processing,

            w_in => w,
            finished => tb1_finished,

            hash_out => dm_out
        );

    clock: process

    begin
        -- Can probably just NOT the clock signal
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
    end process clock;

    stimulus: process
        variable i                      : unsigned(0 to 5) := b"000000";
        variable iteration_counter      : unsigned(0 to 6) := b"0000000";

        variable w_values               : word_vector(0 to 63) := (
            b"00110000001100010011000100110000", b"00110001001100000011000000110000",
            b"00110000001100010011000100110000", b"00110000001100010011000000110001",
            b"00110000001100010011000100110000", b"00110001001100010011000000110000",
            b"00110000001100010011000100110000", b"00110001001100010011000000110000",
            b"00110000001100010011000100110000", b"00110001001100010011000100110001",
            b"00110000001100000011000000110000", b"00110001001100000011000100110000",
            b"10000000000000000000000000000000", b"00000000000000000000000000000000",
            b"00000000000000000000000000000000", b"00000000000000000000000110000000",
            b"11001011101010101100110010001011", b"10001100011110101010100010101000",
            b"11001001101100011110000011011101", b"11011011101111011100000110010001",
            b"00100110110000001010101011110000", b"10110100001001111011001001010001",
            b"10011010101010010010001001101100", b"01010110010101100010101001111110",
            b"10011010000100010101011000101001", b"00110101101100101111000011100011",
            b"11110111111011011101010111101000", b"10001111010100011000110011110011",
            b"10000100100111000101000011001111", b"10010010011011011000010010001101",
            b"11111001000101010100000001111010", b"11001010110001100011011010100101",
            b"11110100001001111010011111000000", b"00111100101011111001100111111100",
            b"11001000110011011001000010101100", b"01101110010100100110001000111111",
            b"10001101000110001101000110111111", b"10101101011111000001000111101001",
            b"01010101001101001100011010111010", b"11101011010111001111110101000000",
            b"01001111010001100001001111000011", b"10011010000110111001111001110110",
            b"11000111100100101100100101001001", b"01110100111001101100101011111010",
            b"11011000000111101011000101000100", b"01011110101011111101010101101110",
            b"01010010100100110110011001100010", b"10100000101101100010000010011101",
            b"10000111110000001011000100011111", b"11111101010110101100100000010001",
            b"01110111110110110101000111110001", b"11011110011111010111010000001001",
            b"01110001001100110001110000110000", b"01100100011001000010100000001110",
            b"10000111010110100111111001010100", b"00001111110001000011001110100001",
            b"11010111010011001100010000100001", b"11101010110011010101010011011100",
            b"11101001011111001100100111000011", b"00100101110011000001111111100001",
            b"01011100100110011110001010100001", b"10001001011111111111011110111110",
            b"11010110110110111111111000101001", b"10000000101111100010010111011100"
        );
        variable outputs_each_iter      : hash_vector(0 to 63) := (
            X"2c39b97d6a09e667bb67ae853c6ef372c8f913d2510e527f9b05688c1f83d9ab",
            X"f317845a2c39b97d6a09e667bb67ae859f59ce45c8f913d2510e527f9b05688c",
            X"e59d0db9f317845a2c39b97d6a09e66776e805599f59ce45c8f913d2510e527f",
            X"0a025c4fe59d0db9f317845a2c39b97d2e502d2d76e805599f59ce45c8f913d2",
            X"2f75f2500a025c4fe59d0db9f317845a4f0ea4492e502d2d76e805599f59ce45",
            X"124ed9402f75f2500a025c4fe59d0db987bbb9bb4f0ea4492e502d2d76e80559",
            X"6d931e3b124ed9402f75f2500a025c4f52f32f4587bbb9bb4f0ea4492e502d2d",
            X"34f2b69c6d931e3b124ed9402f75f250a8d5f1fb52f32f4587bbb9bb4f0ea449",
            X"c24b72f834f2b69c6d931e3b124ed94049e74c4fa8d5f1fb52f32f4587bbb9bb",
            X"1d209458c24b72f834f2b69c6d931e3b3ffd08f449e74c4fa8d5f1fb52f32f45",
            X"9e73b35d1d209458c24b72f834f2b69ccfca6e5a3ffd08f449e74c4fa8d5f1fb",
            X"5672c2619e73b35d1d209458c24b72f8b9445d72cfca6e5a3ffd08f449e74c4f",
            X"3f4d8feb5672c2619e73b35d1d2094585586ea33b9445d72cfca6e5a3ffd08f4",
            X"499a731f3f4d8feb5672c2619e73b35dc1924ea35586ea33b9445d72cfca6e5a",
            X"fa716ba4499a731f3f4d8feb5672c2611639ae64c1924ea35586ea33b9445d72",
            X"1df2385afa716ba4499a731f3f4d8feb52f674811639ae64c1924ea35586ea33",
            X"6e989b641df2385afa716ba4499a731fc6a6a64152f674811639ae64c1924ea3",
            X"4ed4d8af6e989b641df2385afa716ba476964cc3c6a6a64152f674811639ae64",
            X"a9a4e1ad4ed4d8af6e989b641df2385a0f97b72d76964cc3c6a6a64152f67481",
            X"16d2b463a9a4e1ad4ed4d8af6e989b64d1ad4f260f97b72d76964cc3c6a6a641",
            X"2775220716d2b463a9a4e1ad4ed4d8af5abb34e6d1ad4f260f97b72d76964cc3",
            X"587ce3612775220716d2b463a9a4e1ad71f0ac345abb34e6d1ad4f260f97b72d",
            X"5bdbf1f9587ce3612775220716d2b4633073b2e571f0ac345abb34e6d1ad4f26",
            X"1e2e03f85bdbf1f9587ce3612775220722870d2c3073b2e571f0ac345abb34e6",
            X"4fcacd481e2e03f85bdbf1f9587ce3617c7c796022870d2c3073b2e571f0ac34",
            X"b5f06bb04fcacd481e2e03f85bdbf1f95c1ca0de7c7c796022870d2c3073b2e5",
            X"95313fdeb5f06bb04fcacd481e2e03f81fcb6e275c1ca0de7c7c796022870d2c",
            X"dfd21e8895313fdeb5f06bb04fcacd48c8c8167e1fcb6e275c1ca0de7c7c7960",
            X"577f1cecdfd21e8895313fdeb5f06bb08591504fc8c8167e1fcb6e275c1ca0de",
            X"448cb233577f1cecdfd21e8895313fde143b31798591504fc8c8167e1fcb6e27",
            X"8db6e40d448cb233577f1cecdfd21e8858983f48143b31798591504fc8c8167e",
            X"9f98565e8db6e40d448cb233577f1ceca119de3758983f48143b31798591504f",
            X"4c322ab99f98565e8db6e40d448cb233a1c8be5ba119de3758983f48143b3179",
            X"15e9362a4c322ab99f98565e8db6e40dfe577431a1c8be5ba119de3758983f48",
            X"29020c9615e9362a4c322ab99f98565e080e6fd5fe577431a1c8be5ba119de37",
            X"aa07d6e529020c9615e9362a4c322ab955ba6af8080e6fd5fe577431a1c8be5b",
            X"8d9eeee0aa07d6e529020c9615e9362aedd6cfc455ba6af8080e6fd5fe577431",
            X"410423938d9eeee0aa07d6e529020c967e0e3560edd6cfc455ba6af8080e6fd5",
            X"dd05cd63410423938d9eeee0aa07d6e5a0aba5577e0e3560edd6cfc455ba6af8",
            X"3afb1893dd05cd63410423938d9eeee08c93eb93a0aba5577e0e3560edd6cfc4",
            X"876cfc5a3afb1893dd05cd6341042393d5c184908c93eb93a0aba5577e0e3560",
            X"26ec1cff876cfc5a3afb1893dd05cd63d783f5d3d5c184908c93eb93a0aba557",
            X"0217888126ec1cff876cfc5a3afb189319ff6c45d783f5d3d5c184908c93eb93",
            X"62fa61400217888126ec1cff876cfc5a3cd8e66419ff6c45d783f5d3d5c18490",
            X"a98cf52862fa61400217888126ec1cff12c35ab93cd8e66419ff6c45d783f5d3",
            X"cd1ef5dca98cf52862fa61400217888120795e5012c35ab93cd8e66419ff6c45",
            X"03a3609ecd1ef5dca98cf52862fa614035a54d2320795e5012c35ab93cd8e664",
            X"9d9d68de03a3609ecd1ef5dca98cf5286d6e175035a54d2320795e5012c35ab9",
            X"17e2051f9d9d68de03a3609ecd1ef5dc9f9eccbf6d6e175035a54d2320795e50",
            X"8cde114317e2051f9d9d68de03a3609edd4564799f9eccbf6d6e175035a54d23",
            X"0c40dd5e8cde114317e2051f9d9d68de6097500add4564799f9eccbf6d6e1750",
            X"3a67a2240c40dd5e8cde114317e2051f60adc8436097500add4564799f9eccbf",
            X"283519a73a67a2240c40dd5e8cde1143b29fe22360adc8436097500add456479",
            X"72157910283519a73a67a2240c40dd5e033b55ccb29fe22360adc8436097500a",
            X"766c953772157910283519a73a67a224c695aa4a033b55ccb29fe22360adc843",
            X"6bfcb2e6766c953772157910283519a76dbaefe3c695aa4a033b55ccb29fe223",
            X"633f2cfd6bfcb2e6766c95377215791019efaa7b6dbaefe3c695aa4a033b55cc",
            X"b24e538b633f2cfd6bfcb2e6766c9537fd4ff05a19efaa7b6dbaefe3c695aa4a",
            X"c32bb2a5b24e538b633f2cfd6bfcb2e68c99ec94fd4ff05a19efaa7b6dbaefe3",
            X"787148b5c32bb2a5b24e538b633f2cfdb61065f68c99ec94fd4ff05a19efaa7b",
            X"11e5915d787148b5c32bb2a5b24e538ba424276fb61065f68c99ec94fd4ff05a",
            X"c36816b511e5915d787148b5c32bb2a5cb803a4fa424276fb61065f68c99ec94",
            X"43da2853c36816b511e5915d787148b550760063cb803a4fa424276fb61065f6",
            X"da21fd9b43da2853c36816b511e5915d13dd5c3150760063cb803a4fa424276f"
        );

    begin
        w <= w_values(to_integer(i));

        enable <= '0';
        wait for 1 ns;
        enable <= '1';
        wait for clk_period;
        assert processing = '1'
            report "The manager has not yet started processing!";
        assert tb1_finished = '0'
            report "The testbench has marked itself as finished!";


        -- let clk pulse have the manager grab w
        wait for clk_period;

        -- update w to next value
        i := i + 1;
        w <= w_values(to_integer(i));

        -- wait for the other 3 clock cycles needed for hash
        wait for 3 * clk_period;

        assert dm_out = outputs_each_iter(0)
            report "Manager output is not correct: " & hash_to_string(dm_out) &
                   "should be: " & hash_to_string(outputs_each_iter(0));


        assert tb1_finished = '0'
            report "The finished value is not 0, but it should be.  It is " &
                   std_logic'image(tb1_finished);

        while tb1_finished = '0' loop
            assert iteration_counter < b"1000000"
                report "We have done more than 64 iterations!!!";
            iteration_counter := iteration_counter + 1;

            assert w = w_values(to_integer(i))
                report "w is not right for iteration: " & unsigned_to_string(i);


            -- Update w for next iteration
            w <= w_values(to_integer(i + 1));

            -- It should take 4 cycles per w
            wait for 4 * clk_period;

            if dm_out /= outputs_each_iter(to_integer(i)) then
                report "Output for iteration " & unsigned_to_string(i) &
                       " is not correct!";
                report "dm_out is: " & hash_to_string(dm_out);
                report "Should be: " & hash_to_string(outputs_each_iter(to_integer(i)));
                exit;
            end if;

            i := i + 1;
        end loop;
        --report std_logic'image(tb1_finished);

        assert iteration_counter = b"0111111"
            report "Did not go through enough iterations!";

        assert dm_out = outputs_each_iter(63)
            report  "Final output is not correct!" & cr &
                    "dm_out is: " & hash_to_string(dm_out) & cr &
                    "Should be: " & hash_to_string(outputs_each_iter(to_integer(i)));

        report "Test bench has finished!" & cr;

        wait;


    end process stimulus;

end architecture testbench;
