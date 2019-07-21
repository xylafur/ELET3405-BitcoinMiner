
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.sha256_pkg.all;

entity SHA_Preprocessor_tb is
end SHA_Preprocessor_tb;

architecture testbench of SHA_Preprocessor_tb is
    signal clk              : std_logic;
    signal enable           : std_logic := '0';

    signal processing       : std_logic;
    signal finished         : std_logic;

    signal output_valid     : std_logic := '0';

    signal word_in          : word;
    signal word_out         : word;

    constant clk_period     : time := 50 ns;
begin
    preprocessor_tb_1: entity work.SHA_Preprocessor
        port map(
            clk => clk,
            en => enable,

            processing => processing,
            finished => finished,
            output_valid => output_valid,

            word_in => word_in,
            word_out => word_out
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
        constant number_inputs          : integer := 16;
        constant number_outputs         : integer := 64;

        variable i                      : integer := 0;

        variable msg_1_inputs           : word_vector (0 to number_inputs - 1) := (
            X"01234567", X"89ABCDEF", X"C0000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000"
        );

        variable msg_1_outputs          : word_vector (0 to number_outputs - 1) := (
            X"01234567", X"89abcdef", X"c0000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"3e8111b3", X"a32bfdef", X"6ae058d4", X"8162ef0f",
            X"276a003a", X"2a466826", X"40138dd8", X"379e53a4",
            X"5a732ad7", X"4e8bd37c", X"718ac9cc", X"bb2c0c9a",
            X"680a3c6c", X"c8044fc8", X"91400f2f", X"2e64969d",
            X"c7bc1046", X"a20a44a9", X"65143202", X"4503b12d",
            X"61dc566b", X"c61d08c6", X"eacecb69", X"93f3f60c",
            X"bef46977", X"5e247dc0", X"917e87f8", X"29225ac5",
            X"5cb0fdca", X"67c4f9ff", X"a0b65f93", X"629bf9ff",
            X"e0234c7e", X"bc49ffe2", X"1c205194", X"3139b4df",
            X"c41f0078", X"d021d777", X"a4480085", X"2876e72c",
            X"0fc2aed0", X"6cb1658f", X"df31792e", X"2c0cbc42",
            X"8ca11c9e", X"7a629a8c", X"841696ac", X"c3436ac9"
        );




        variable msg_2_inputs           : word_vector (0 to number_inputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"9999999f", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000"
        );


        variable msg_2_outputs          : word_vector (0 to number_outputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"9999999f", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"7bbbbbba", X"c6666665", X"3bc5ad54", X"5b8b7e20",
            X"0974d256", X"c5d5557b", X"8cfd323f", X"7bdfaabf",
            X"05e16f12", X"5bdc52d2", X"f5f5b837", X"ac9a63d7",
            X"30f5cea5", X"0ab73785", X"da69add6", X"188097c0",
            X"05d8ac37", X"d9d47e12", X"c04a9581", X"d7288147",
            X"e6dcc5d4", X"13079dbe", X"3b0ab778", X"3e97cf3e",
            X"a88c6975", X"59f706c8", X"a91c0f66", X"36f8a223",
            X"9115fd43", X"68a68303", X"010092e2", X"98c657c4",
            X"dc0a44ce", X"231733ef", X"1727a399", X"6c244735",
            X"0e6721c3", X"1a38906a", X"d10be84f", X"58fed46a",
            X"aefd066b", X"fd7516eb", X"a14d9d39", X"5948104e",
            X"d3678ce4", X"2485b414", X"a1b1f1ee", X"cb500100"
        );


        variable msg_3_inputs           : word_vector (0 to number_inputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"ffffffff", X"ffffffff",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000"
        );


        variable msg_3_outputs          : word_vector (0 to number_outputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"ffffffff", X"ffffffff",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"7bbbbbba", X"c6666665", X"3bc5ad54", X"5b8b7e20",
            X"0974d256", X"9b6d6f14", X"1363989e", X"9609c139",
            X"85be79a0", X"14642909", X"4f50bc16", X"9b15840a",
            X"e507a981", X"86067427", X"b7d35102", X"0fe3caec",
            X"9d865023", X"7639d17b", X"4d5c7e1f", X"accc7503",
            X"a1f8b07e", X"dfb881f2", X"8303aca0", X"54557e0f",
            X"bac2e48f", X"7d052255", X"926c08e5", X"67980814",
            X"0cd02fd9", X"d5f0db7a", X"4996203a", X"02111db0",
            X"7b090eec", X"decb43d5", X"6b2af452", X"48a7da59",
            X"7ad81518", X"fa1298ea", X"d8e81eaa", X"9fc36bd0",
            X"94142721", X"9c360100", X"989f09b3", X"5b6d53d9",
            X"4677b106", X"a809d1d5", X"3f36032c", X"fd4bd544"
        );


        variable msg_4_inputs           : word_vector (0 to number_inputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"ffffffff", X"ffffffff",
            X"80000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000"
        );



        variable msg_4_outputs          : word_vector (0 to number_outputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"ffffffff", X"ffffffff",
            X"80000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"7bbbbbba", X"c6666665", X"3bc5ad54", X"5b8b7e20",
            X"0974d256", X"9b6d6f14", X"1363989e", X"a709e139",
            X"05be79a0", X"0857d271", X"4f70ec16", X"1ce9832b",
            X"0707a181", X"055b7027", X"cbfb43c4", X"71434d68",
            X"98950216", X"a936e8d6", X"0e6d5a71", X"a598dd5b",
            X"76e3d211", X"b505a41a", X"37df5986", X"8516e342",
            X"0e79a537", X"e322f3f9", X"10b6e664", X"a6171537",
            X"feb00741", X"e56917ba", X"621a86fc", X"a776935e",
            X"91b24c84", X"0b285c8c", X"b929e99b", X"a2d413e0",
            X"70e9de20", X"7fbaf3be", X"e19649ed", X"451e52ce",
            X"5af18e7e", X"f32b4079", X"69347992", X"7d0b1fc1",
            X"5ed57923", X"083fb2de", X"c852e248", X"b9d2f635"
        );

        variable msg_5_inputs           : word_vector (0 to number_inputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"ffffffff", X"ffffffff",
            X"ffffffff", X"ffffffff", X"ffffffff", X"ffffffff",
            X"ffffffff", X"ffffffff", X"00000000", X"00000000"
        );



        variable msg_5_outputs          : word_vector (0 to number_outputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"ffffffff", X"ffffffff",
            X"ffffffff", X"ffffffff", X"ffffffff", X"ffffffff",
            X"ffffffff", X"ffffffff", X"00000000", X"00000000",
            X"7bbbbbb9", X"c6666664", X"3bc68d53", X"5b8b1e1f",
            X"3d73719c", X"b7854f1c", X"f6f2c5c9", X"a9fbe818",
            X"20c6df78", X"e4ebcc89", X"2fe643e9", X"fd6065b5",
            X"c1079ab9", X"3545decd", X"e837815d", X"08e7abe3",
            X"da3ffed8", X"19381913", X"2bea8fcc", X"0ff3e221",
            X"05274930", X"6955ec06", X"2c045e3e", X"135cf24b",
            X"db49a252", X"3f97e851", X"926bbdd4", X"98c198cb",
            X"bf43458b", X"a726b14d", X"f3e5e452", X"c81db3b9",
            X"8bc97b7e", X"5a173f64", X"130867d6", X"fa61f22f",
            X"665c9086", X"92ff72d2", X"774c5e32", X"cc8924a1",
            X"39bd254d", X"5db4d21e", X"a4ea5abb", X"c46db393",
            X"dc60475d", X"508d5d11", X"f25f55b7", X"b9ca9971"
        );


--        note): Word 16: 1000 1000 1000 1000 1000 1000 1000 1000
--        note): Word s0: 0011 1101 1101 1101 1101 1101 1101 1101
--
--                        1100 0110 0110 0110 0110 0110 0110 0101
--                        1100 0110 0110 0110 0110 0110 0110 0101
--                        1010 0000 0111 0111 1000 0110 0110 0101
--
--        ./tb_sha_preprocessor.vhd:567:17:@16902010ps:(report note): prev:
--        10111011101110111011101110111011
--        ./tb_sha_preprocessor.vhd:568:17:@16902010ps:(report note): next:
--        01001000110010001001010101010100
--
--
        variable msg_6_inputs           : word_vector (0 to number_inputs - 1) := (
            X"99999999", X"88888888", X"77777777", X"66666666",
            X"55555555", X"44444444", X"33333333", X"22222222",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000"
        );


        variable msg_6_outputs          : word_vector (0 to number_outputs - 1) := (
            X"99999999", X"88888888", X"77777777", X"66666666",
            X"55555555", X"44444444", X"33333333", X"22222222",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"00000000", X"00000000", X"00000000", X"00000000",
            X"bbbbbbbb", X"c6666665", X"7b955554", X"5b8b7e21",
            X"e684be53", X"c1d3757b", X"c495ea78", X"b200c9eb",
            X"0ea8c607", X"f97984c6", X"d74c4ad1", X"d94abc45",
            X"6dda77d8", X"ce31ef9b", X"270d17b6", X"67a4c79a",
            X"2932c63c", X"8baae632", X"27021e81", X"8ded5b29",
            X"34375e05", X"8338c10c", X"6468d78a", X"92043ad8",
            X"ff6d8e94", X"6682e1af", X"1b6b95d4", X"5b14fad5",
            X"ff263ac1", X"4203bc15", X"9cf5a51c", X"dda616e3",
            X"c3af3458", X"f1bf8715", X"131abe6d", X"9bd78764",
            X"b85d50c8", X"814de3dc", X"f234f68d", X"f91f483b",
            X"c14f6060", X"14f107e5", X"b2b128f8", X"c9285528",
            X"ff85225b", X"981c631a", X"2525c869", X"c1a21760"
        );



        variable msg_7_inputs           : word_vector (0 to number_inputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"99999999", X"88888888",
            X"77777777", X"66666666", X"55555555", X"44444444",
            X"33333333", X"2222222f", X"00000000", X"00000000"
        );

        variable msg_7_outputs          : word_vector (0 to number_outputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"99999999", X"88888888",
            X"77777777", X"66666666", X"55555555", X"44444444",
            X"33333333", X"2222222f", X"00000000", X"00000000",
            X"e2222220", X"1bbbbbba", X"2ac23b31", X"399b8f31",
            X"237c894b", X"a781ee2d", X"913fe6ae", X"73830fd0",
            X"fc73a20b", X"6c8cce5e", X"c57d92f6", X"138d733f",
            X"2855cf5e", X"cb5e91c8", X"d1d1d423", X"6c6b85f3",
            X"b8ff5e13", X"7d5799a9", X"09c14bc5", X"526bc45a",
            X"afa7c896", X"cab4e330", X"8881537b", X"fb43ab30",
            X"809aec2c", X"a8a7c46a", X"6436be97", X"a854fceb",
            X"a81a638d", X"5e3406ba", X"54dc6398", X"588f573d",
            X"da8b3dbd", X"fcd86662", X"fb757924", X"04d65d3f",
            X"6173d5e7", X"b7aa6917", X"05ba77fa", X"416cf922",
            X"23d59cb1", X"15add4d5", X"e434393e", X"f16e2898",
            X"7a1aef8d", X"5825dd47", X"64e29419", X"810d49bd"
        );



        variable msg_8_inputs           : word_vector (0 to number_inputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"99999999", X"88888888",
            X"77777777", X"66666666", X"55555555", X"44444444",
            X"33333333", X"22222222", X"ffffffff", X"ffffffff"
        );

        variable msg_8_outputs          : word_vector (0 to number_outputs - 1) := (
            X"ffffffff", X"eeeeeeee", X"dddddddd", X"cccccccc",
            X"bbbbbbbb", X"aaaaaaaa", X"99999999", X"88888888",
            X"77777777", X"66666666", X"55555555", X"44444444",
            X"33333333", X"22222222", X"ffffffff", X"ffffffff",
            X"e262221f", X"1bfbbbb9", X"2ac9eb49", X"399c3f59",
            X"914f8ace", X"895aee01", X"efd68526", X"d3ab2bc1",
            X"7f192c79", X"7731e06e", X"d3aefbe3", X"4e87d4e4",
            X"27d021d8", X"42f5b6ad", X"088a0ed9", X"97bc5960",
            X"3ff05162", X"854351e8", X"567b5631", X"920d2e2d",
            X"3fc9eaec", X"b649bb41", X"a2d990b2", X"b48444b7",
            X"a8d7f3b5", X"dbb7bac2", X"a1b76531", X"7525489f",
            X"7ba07352", X"23c67ca7", X"ba6cc4b9", X"0a3d368b",
            X"2c664b3c", X"2280ec21", X"bb820417", X"1e875824",
            X"a1adfb4f", X"ccf9d6c0", X"58d18418", X"351c0d2d",
            X"2e6321a9", X"ccb22408", X"17922655", X"24e16798",
            X"7596a360", X"70e55ef9", X"d03b41ea", X"2c7b1655"
        );





    begin


        report "RUNNING TESTCASE 1";
        word_in <= msg_1_inputs(0);

        enable <= '0';
        wait for 1 ns;
        enable <= '1';

        wait for 1 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_1_inputs(ii);
            wait for clk_period;


            assert word_out = msg_1_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_1_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is : " & word_to_string(word_out);
                report "shd: " & word_to_string(msg_1_outputs(ii));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";






        report "RUNNING TESTCASE 2";
        word_in <= msg_2_inputs(0);

        enable <= '0';
        wait for 0.001 ns;
        enable <= '1';

        wait for 0.001 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_2_inputs(ii);
            wait for clk_period;


            assert word_out = msg_2_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_2_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is  : " & word_to_string(word_out);
                report "shd : " & word_to_string(msg_2_outputs(ii));
                report "prev: " & word_to_string(msg_2_outputs(ii - 1));
                report "next: " & word_to_string(msg_2_outputs(ii + 1));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";





        report "RUNNING TESTCASE 3";
        word_in <= msg_3_inputs(0);

        enable <= '0';
        wait for 0.001 ns;
        enable <= '1';

        wait for 0.001 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_3_inputs(ii);
            wait for clk_period;


            assert word_out = msg_3_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_3_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is  : " & word_to_string(word_out);
                report "shd : " & word_to_string(msg_3_outputs(ii));
                report "prev: " & word_to_string(msg_3_outputs(ii - 1));
                report "next: " & word_to_string(msg_3_outputs(ii + 1));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";



        report "RUNNING TESTCASE 4";
        word_in <= msg_4_inputs(0);

        enable <= '0';
        wait for 0.001 ns;
        enable <= '1';

        wait for 0.001 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_4_inputs(ii);
            wait for clk_period;


            assert word_out = msg_4_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_4_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is  : " & word_to_string(word_out);
                report "shd : " & word_to_string(msg_4_outputs(ii));
                report "prev: " & word_to_string(msg_4_outputs(ii - 1));
                report "next: " & word_to_string(msg_4_outputs(ii + 1));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";



        report "RUNNING TESTCASE 5";
        word_in <= msg_5_inputs(0);

        enable <= '0';
        wait for 0.001 ns;
        enable <= '1';

        wait for 0.001 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_5_inputs(ii);
            wait for clk_period;


            assert word_out = msg_5_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_5_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is  : " & word_to_string(word_out);
                report "shd : " & word_to_string(msg_5_outputs(ii));
                report "prev: " & word_to_string(msg_5_outputs(ii - 1));
                report "next: " & word_to_string(msg_5_outputs(ii + 1));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";


        report "RUNNING TESTCASE 6";
        word_in <= msg_6_inputs(0);

        enable <= '0';
        wait for 0.001 ns;
        enable <= '1';

        wait for 0.001 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_6_inputs(ii);
            wait for clk_period;


            assert word_out = msg_6_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_6_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is  : " & word_to_string(word_out);
                report "shd : " & word_to_string(msg_6_outputs(ii));
                report "prev: " & word_to_string(msg_6_outputs(ii - 1));
                report "next: " & word_to_string(msg_6_outputs(ii + 1));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";



        report "RUNNING TESTCASE 7";
        word_in <= msg_7_inputs(0);

        enable <= '0';
        wait for 0.001 ns;
        enable <= '1';

        wait for 0.001 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_7_inputs(ii);
            wait for clk_period;


            assert word_out = msg_7_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_7_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is  : " & word_to_string(word_out);
                report "shd : " & word_to_string(msg_7_outputs(ii));
                report "prev: " & word_to_string(msg_7_outputs(ii - 1));
                report "next: " & word_to_string(msg_7_outputs(ii + 1));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";


        report "RUNNING TESTCASE 8";
        word_in <= msg_8_inputs(0);

        enable <= '0';
        wait for 0.001 ns;
        enable <= '1';

        wait for 0.001 ns;
        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in 0 to number_inputs - 1 loop
            word_in <= msg_8_inputs(ii);
            wait for clk_period;


            assert word_out = msg_8_outputs(ii)
                report "Incorrect word at index " & integer'image(ii);

        end loop;

        assert finished = '0'
            report "Preprocessor has marked himself as finished!";
        assert processing = '1'
            report "Preprocessor reports he is not processing!";

        for ii in number_inputs to number_outputs - 1 loop
            wait for clk_period;

            if word_out /= msg_8_outputs(ii) then
                report "Incorrect word at index " & integer'image(ii);
                report "Is  : " & word_to_string(word_out);
                report "shd : " & word_to_string(msg_8_outputs(ii));
                report "prev: " & word_to_string(msg_8_outputs(ii - 1));
                report "next: " & word_to_string(msg_8_outputs(ii + 1));
                wait;
            end if;

        end loop;

        assert finished = '1'
            report "Preprocessor has not marked himself as finished!";

        assert processing = '0'
            report "preprocessor reports he is not done processing!";


        report "Test bench has finished!" & cr;

        wait;


    end process stimulus;

end architecture testbench;
