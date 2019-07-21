
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
            X"bbbbbbbb", X"a0778665", X"48c89554", X"0fe7958f",
            X"f1f085be", X"a96d20fa", X"bcaa36a2", X"122638b0",
            X"fe21a9b2", X"2413182d", X"f1b83e4d", X"e10ab80b",
            X"c24049de", X"c7e704ac", X"400a622a", X"f0029b6e",
            X"9be6b661", X"35f3fd0b", X"b22e52e4", X"9603ade5",
            X"451ba335", X"6c2839e1", X"3ee6aec4", X"da394a9d",
            X"4f8bd3f2", X"ecb44ef5", X"c1323325", X"8c80fb57",
            X"0e86b757", X"2dbb93e1", X"0cc25e60", X"78e9ca47",
            X"dd3191eb", X"1f3453bd", X"6c443efc", X"d31d590a",
            X"ccb6ee00", X"a48ba438", X"d517f8c9", X"77b03f00",
            X"57fb57f4", X"50e3b960", X"d5bde9c2", X"06d81bff",
            X"201308d7", X"676f2e9b", X"5d69430f", X"ebd2cd1e"
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
            X"237c894b", X"a781ee2d", X"913fe6ae", X"4d942fd0",
            X"c9a6e20b", X"98d4a15f", X"80f069f6", X"591614b3",
            X"463dc665", X"7c3b8b09", X"a983b478", X"53a9ba0b",
            X"c13e6b89", X"70bdd91f", X"02e9efa4", X"88056fb9",
            X"9e12a79f", X"21bdbe55", X"8ee317db", X"2de05acb",
            X"a816a4ee", X"a9586a2e", X"78729749", X"e37426be",
            X"810c6dc5", X"ac4c6f48", X"052ef3de", X"476e7196",
            X"58dd7c03", X"13ca8fbf", X"31f4cbb5", X"a4580cf5",
            X"08e0dfb6", X"91f16a43", X"cfd68760", X"8074f13b",
            X"a242d824", X"fa14ccc6", X"bc10ce64", X"6c6d230f",
            X"30d2e3e5", X"b2783a72", X"6b2c72ee", X"56b79e86"
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
            X"914f8ace", X"895aee01", X"efd68526", X"adbc4bc1",
            X"4c4c6c79", X"b38e937f", X"8f1ac273", X"9e43d7f0",
            X"2d04ba9a", X"c31a7363", X"97d15dcb", X"6f494489",
            X"bb10c9e1", X"23c3aa55", X"0186e403", X"74c28985",
            X"aca509c5", X"28883682", X"092daeb3", X"6677cf3e",
            X"2066e950", X"19d86794", X"b470343e", X"a983f0ea",
            X"b5800c23", X"2531f019", X"5417db46", X"3c237e86",
            X"3072d1e2", X"6803c106", X"83dca083", X"9fb90f9b",
            X"a328dd3a", X"2f5490f0", X"3e318ce3", X"8f708165",
            X"b33ad95e", X"555bfe80", X"c82b58c1", X"20063219",
            X"f7098988", X"b3a67466", X"adaea9d7", X"5a07f1a1"
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
