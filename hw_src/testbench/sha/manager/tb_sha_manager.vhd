
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_Manager_tb is
end SHA_Manager_tb;

architecture testbench of SHA_Manager_tb is
    signal reset : std_logic := '0';
    signal enable: std_logic := '1';

    signal clk: std_logic;

    signal k: word := X"b5c0fbcf";
    signal w: word := X"55adfba4";

    signal dm_in: hash := X"8888888800000000111111112222222233333333444444445555555566666666";

    signal dm_out: hash;

    constant clk_period : time := 50 ns;

begin
    manager_tb: entity work.SHA_Manager
        port map(
            clk => clk,
            en => enable,
            reset => reset,

            k_in => k,
            w_in => w,

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
    begin
        wait for 6 * clk_period;

        assert dm_out = X"c4ed50286a09e667bb67ae853c6ef37261acaa7d510e527f9b05688c1f83d9ab"
            report "Manager output is not correct: " & hash_to_string(dm_out);


        report "Test bench has finished!" & cr;

        wait;


    end process stimulus;

end architecture testbench;
