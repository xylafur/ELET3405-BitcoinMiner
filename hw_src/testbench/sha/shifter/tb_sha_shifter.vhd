
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_Shifter_tb is
end SHA_Shifter_tb;

architecture testbench of SHA_Shifter_tb is
    signal reset : std_logic := '0';
    signal enable: std_logic := '1';

    signal i: unsigned(0 to 5) := b"000010";

    signal clk: std_logic;

    signal k: word := X"b5c0fbcf";
    signal w: word := X"55adfba4";

    signal dm_in: hash := X"8888888800000000111111112222222233333333444444445555555566666666";

    signal dm_out: hash;

    constant clk_period : time := 50 ns;

begin
    shifter_tb: entity work.SHA_Shifter
        port map(
            reset => reset,
            en => enable,
            clk => clk,
            k => k,
            w => w,
            dm_in => dm_in,
            dm_out => dm_out
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
    begin
        wait for 5 * clk_period;

        assert dm_out = X"2d9119948888888800000000111111110b6ef772333333334444444455555555"
            report "Shifter output is not correct: " & hash_to_string(dm_out);

        report "Test bench has finished!" & cr;

        wait;


    end process stimulus;

end architecture testbench;
