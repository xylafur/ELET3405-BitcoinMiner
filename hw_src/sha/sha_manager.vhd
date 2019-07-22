library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sha256_pkg.all;

entity SHA_Manager is
    port(
        clk                 : in std_logic;

        en                  : in std_logic;
        reset               : in std_logic;

        processing          : out std_logic := '0';

        w_in                : in word;

        finished            : out std_logic := '0';
        -- Digest Messages for both manager and shifter, we need an update from
        -- the shifter
        hash_out            : out hash
    );
end SHA_Manager;

architecture behavior of SHA_Manager is
    signal i                : unsigned(0 to 5) := b"000000";

    signal manager_dm       : hash := dm_initial;
    signal internal_finished: std_logic := '0';

    signal manager_enable   : std_logic := '0';
    signal shifter_enable   : std_logic := '0';

    signal shifter_dm       : hash;

    signal w_out            : word;

    -- We can obtain K from the array of constants
    signal k_in             : word;
    signal k_out            : word;
begin

    k_in <= K_constants(to_integer(i));

    -- When we get pused with the rising en signal, start calculating the hash
    manager_enabler: process(en, internal_finished)
    begin
        if(en = '1' and en'event) then
            -- only want to start if nothing is running
            if internal_finished = '0' and manager_enable = '0' and
                shifter_enable = '0' then
                -- First we set the initial value of the hash
                -- This way it is reset for each new input
                finished <= '0';
                processing <= '1';

                manager_enable <= '1';
                shifter_enable <= '1';

            end if;
        end if;

        -- If we start having significant problems with this module, this is
        -- probably why.  I think that this will work, I wish that we could
        -- assign signals from multiple processes....
        if internal_finished = '1' then
            hash_out <= manager_dm;
            finished <= '1';
            manager_enable <= '0';
            shifter_enable <= '0';
            processing <= '0';
       end if;
    end process manager_enabler;

    -- We split 4 clock cycles between this module and the sha shifter module
    --  Clock Cycle 0: MANAGER - Grab k and w and pass them into the shifter module
    --  Clock Cycle 1: SHIFTER - Calculate the two temp values
    --  Clock Cycle 1: SHIFTER - Use the temp values to get the hash
    --  Clock Cycle 1: MANAGER - Move the output of the shifter to the output
    --                           of the manager.  This is either the final
    --                           value of will be passed into the shifter again
    --                           If we have gone 64 iterations, we are done!
    --                           Mark internal finished as 1
    chunk_handler: process(clk)
        -- 4 bit counter for us to sync with shifter
        variable clk_counter  : unsigned(0 to 1) := b"00";
    begin
        if(clk = '1' and clk'event)then
            if manager_enable = '1'  and internal_finished = '0' then


                if clk_counter = 0 then
                    k_out <= k_in;
                    w_out <= w_in;

                elsif clk_counter = 3 then


                    manager_dm <= shifter_dm;

                    if i = b"111111" then
                        internal_finished <= '1';
                    end if;
                    i <= i + 1;

                end if;

                clk_counter := clk_counter + 1;

            end if;

            -- Wait for the manager_enabler processes to realize we are
            -- finished, he does this by setting manager_enable back to 0
            if internal_finished = '1' then
                if manager_enable = '0' then
                    internal_finished <= '0';
                end if;
            end if;

        end if;
    end process chunk_handler;

    shifter: entity work.SHA_Shifter
        port map(
            reset => reset,
            en => shifter_enable,
            clk => clk,
            k => k_out,
            w => w_out,
            dm_in => manager_dm,
            dm_out => shifter_dm
        );

end architecture behavior;
