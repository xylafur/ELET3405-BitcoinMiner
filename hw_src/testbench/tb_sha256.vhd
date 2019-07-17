
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_tb is
end SHA_tb;

architecture testbench of SHA_tb is
    signal reset : std_logic := '0';
    signal enable: std_logic := '1';


    signal shifter_out: word;

    signal clk: std_logic;

    constant clk_period : time := 10 ns;

begin
    shifter_tb: entity work.SHA_Shifter
        port map(
            reset => reset,
            en => enable,
            --i => 0,
            clk => clk,
            wi_out => shifter_out
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
        wait for clk_period * 2;

        assert shifter_out = x"FFFFFFFF"

            report "Shifter output is not correct: " & to_string(shifter_out);

        report "Test bench has finished!" & cr;

        wait;


    end process stimulus;

end architecture testbench;
