
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_Main_tb is
end SHA_Main_tb;

architecture testbench of SHA_Main_tb is
    signal clk              : std_logic;
    signal enable           : std_logic := '0';

    signal packer_processing       : std_logic;
    signal packer_finished         : std_logic;

    signal preprocessor_processing       : std_logic := '0';
    signal preprocessor_finished         : std_logic := '0';

    signal sha_manager_processing       : std_logic := '0';

    signal output_valid     : std_logic := '0';

    signal hash_out         : hash;

    constant clk_period     : time := 50 ns;
begin

    sha256: entity work.SHA256
        port map(
            clk => clk,
            en => enable,

            packer_processing       => packer_processing,
            packer_finished         => packer_finished,

            preprocessor_processing => preprocessor_processing,
            preprocessor_finished   => preprocessor_finished,

            sha_manager_processing => sha_manager_processing,

            ready => output_valid,
            dm_out => hash_out
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
        variable i : integer := 0;
        variable expected_output_1 : hash :=
            X"18f9781b1b2c2d85dc80ea6af8a7acf9bf1911a768411d39280818bf0fa7e28e";
    begin


        enable <= '0';
        wait for 1 ns;
        enable <= '1';

        wait for 1 ns;
        assert packer_finished = '0'
            report "packer has marked himself as finished!";
        assert packer_processing = '1'
            report "packer reports he is not processing!";

        assert preprocessor_processing = '0'
            report "preprocessor reports he is processing!";



        wait for clk_period;

        assert preprocessor_finished = '0'
            report "preprocessor has marked himself as finished!";
        assert preprocessor_processing = '1'
            report "preprocessor reports he is not processing!";


        assert output_valid = '0'
            report "sha_manager has marked himself as finished!";
        assert sha_manager_processing = '0'
            report "sha_manager reports he is processing!";

        wait for 3 * clk_period;
        wait for 4 * clk_period;
        wait for 4 * clk_period;

        assert sha_manager_processing = '1'
            report "sha_manager reports he not processing!    " &
            std_logic'image(sha_manager_processing);

        while output_valid = '0' loop
            wait for clk_period;
            i := i + 1;
        end loop;

        report "Entire hashing took " & integer'image(i) & " cycles!";


        if hash_out /= expected_output_1 then
            report "Output hash is incorrect!";
            report "Is  : " & hash_to_string(hash_out);
            report "Shdb: " & hash_to_string(expected_output_1);
        end if;

        report "Test bench Finished!";



        wait;


    end process stimulus;

end architecture testbench;
