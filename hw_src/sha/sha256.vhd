library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;

entity SHA256 is
    port(
        -- reset   :  in std_logic;
        -- en      :  in std_logic;

        clk     : in std_logic;

        --dm_in   : in hash;

        dm_out  : out hash
    );
end SHA256;

architecture behavior of SHA256 is
    signal k: word := X"b5c0fbcf";
    signal w: word := X"55adfba4";

    signal reset: std_logic := '1';
    signal enable: std_logic := '1';

    signal dm_in: hash := X"8888888800000000111111112222222233333333444444445555555566666666";

    signal i: unsigned(0 to 5) := b"000010";
begin
    shifter: entity work.SHA_Shifter
        port map(
            reset => reset,
            en => enable,
            clk => clk,
            k => k,
            w => w,
            dm_in => dm_in,
            dm_out => dm_out
        );
end architecture behavior;


