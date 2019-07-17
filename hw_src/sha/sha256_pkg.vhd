library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package sha256_pkg is
    subtype word is std_logic_vector(31 downto 0);
    subtype hash is std_logic_vector(255 downto 0);
    subtype uint_64 is integer range 63 to 0;
    subtype uint_32 is integer range 32 to 0;

    function sigma1(x: word) return word;
    function to_string ( a: word) return string;

end sha256_pkg;

package body sha256_pkg is

    function sigma1(x: word) return word is
    begin
        return (x(1 downto 0) & x(31 downto 2)) xor
               (x(12 downto 0) & x(31 downto 13)) xor
               (x(24 downto 0) & x(31 downto 25));
    end function;

function to_string ( a: word) return string is
    variable b : string (1 to a'length) := (others => NUL);
    variable stri : integer := 1;
begin
    for i in a'range loop
        b(stri) := std_logic'image(a((i)))(2);
        stri := stri+1;
    end loop;

    return b;
end function;

end package body sha256_pkg;

