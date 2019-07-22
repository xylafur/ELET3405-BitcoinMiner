
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_Packer_tb is
end SHA_Packer_tb;

architecture testbench of SHA_Packer_tb is
    signal clk              : std_logic;

    signal enable           : std_logic := '0';
    signal msg              : input_msg;
    signal msg_length       : input_msg_length;
    signal finished         : std_logic;
    signal processing       : std_logic;
    signal output_valid     : std_logic;
    signal word_out         : word;

    constant clk_period     : time := 50 ns;

begin
    packer_tb_1: entity work.SHA_Packer
        port map(
            msg => msg,
            msg_length => msg_length,

            en => enable,
            clk => clk,

            processing => processing,
            valid => output_valid,
            finished => finished,


            w_out => word_out
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
        constant number_outputs         : integer := 16;
        variable i                      : integer := 0;

        variable msg_1                  : input_msg :=
            X"FFFF_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000";
        variable msg_1_length           : input_msg_length :=
            b"0001_0000";

        variable msg_1_outputs          : word_vector (0 to number_outputs - 1) := (
            X"FFFF8000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000010"
        );


        variable msg_2                  : input_msg :=
            X"0123_4567_89AB_CDEF_8000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000";
        variable msg_2_length           : input_msg_length :=
            b"0100_0001";

        variable msg_2_outputs          : word_vector (0 to number_outputs - 1) := (
            X"01234567", X"89ABCDEF", X"C0000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000041"
        );


        variable msg_3                  : input_msg :=
            X"0123_4567_89AB_CDEF_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000";
        variable msg_3_length           : input_msg_length :=
            b"0100_0000";
        variable msg_3_outputs          : word_vector (0 to number_outputs - 1) := (
            X"01234567", X"89ABCDEF", X"80000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000040"
        );




    begin
        msg <= msg_1;
        msg_length <= msg_1_length;

        enable <= '0';
        wait for 1 ns;
        enable <= '1';

        assert finished = '0'
            report "Packer has marked himself as finished!";

        wait for 1 ns;

        assert processing = '1'
            report "Packer reports he is not processing!";

        for ii in 0 to number_outputs - 1 loop
            wait for clk_period;

            assert word_out = msg_1_outputs(ii)
                report "Incorrect word!" &
                       " is : " & word_to_string(word_out) &
                       " sdb: " & word_to_string(msg_1_outputs(ii));

        end loop;

        assert finished = '1'
            report "Packer has not marked himself as finished!";

        report "Finished testing simple packer!";



        msg <= msg_2;
        msg_length <= msg_2_length;

        enable <= '0';
        wait for 1 ns;
        enable <= '1';
        wait for 1 ns;


        assert finished = '0'
            report "Packer has marked himself as finished!";

        assert processing = '1'
            report "Packer reports he is not processing!";

        for ii in 0 to number_outputs - 1 loop
            wait for clk_period;

            assert word_out = msg_2_outputs(ii)
                report "Incorrect word!";
        end loop;

        assert finished = '1'
            report "Packer has not marked himself as finished!";



        msg <= msg_3;
        msg_length <= msg_3_length;


        enable <= '0';
        wait for 1 ns;
        enable <= '1';
        wait for 1 ns;


        assert finished = '0'
            report "Packer has marked himself as finished!";

        assert processing = '1'
            report "Packer reports he is not processing!";

        for ii in 0 to number_outputs - 1 loop
            wait for clk_period;

            assert word_out = msg_3_outputs(ii)
                report "Incorrect word!";
        end loop;

        assert finished = '1'
            report "Packer has not marked himself as finished!";



        report "Test bench has finished!" & cr;



        wait;


    end process stimulus;

end architecture testbench;
