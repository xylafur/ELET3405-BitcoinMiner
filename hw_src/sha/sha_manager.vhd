library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;


entity SHA_Manager is
    port(
        clk             : in std_logic;
        en              : in std_logic;
        reset           : in std_logic;

        w_in            : in word;
        k_in            : in word;

        -- Digest Messages for both manager and shifter, we need an update from
        -- the shifter
        hash_out        : out hash
    );
end SHA_Manager;

architecture behavior of SHA_Manager is
    signal i            : unsigned(0 to 5);

    signal manager_dm   : hash :=
        x"6a09e667bb67ae853c6ef372a54ff53a510e527f9b05688c1f83d9ab5be0cd19";

    signal shifter_dm   : hash;
    signal w_out        : word;
    signal k_out        : word;
begin


    chunk_handler: process(clk)
        -- 4 bit counter for us to sync with shifter
        variable clk_counter  : unsigned(0 to 1) := b"00";
    begin
        if(clk = '1' and clk'event)then
            if clk_counter = 0 then
                k_out <= k_in;
                w_out <= w_in;

            elsif clk_counter = 3 then
                manager_dm <= shifter_dm;

            end if;

            clk_counter := clk_counter + 1;

        end if;

        hash_out <= manager_dm;
    end process chunk_handler;

    shifter: entity work.SHA_Shifter
        port map(
            reset => reset,
            en => en,
            clk => clk,
            k => k_out,
            w => w_out,
            dm_in => manager_dm,
            dm_out => shifter_dm
        );
end architecture behavior;
