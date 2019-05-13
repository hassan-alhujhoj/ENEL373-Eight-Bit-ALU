library ieee;
use ieee.std_logic_1164.all;


entity regO is
	generic (n 	: integer := 2);
	port(D 		: in std_logic_vector(n-1 downto 0);
		Clk     : in std_logic;
		Q 		: out std_logic_vector(n-1 downto 0));
end regO;

architecture behaviour of regO is
	begin
	process(Clk)
		begin
			if rising_edge(Clk) then
					Q <= D;
            end if;
	end process;
end behaviour;