library ieee;
use ieee.std_logic_1164.all;


entity led_out is
	   port(led_in 	: in std_logic_vector(7 downto 0);
			clk			: in std_logic;
	       output       : out std_logic_vector(7 downto 0));
end led_out;

architecture behaviour of led_out is
	begin
	process(Clk)
		begin
			if Clk'event and Clk = '1' then
				output <= led_in;
			end if;
	end process;
end behaviour;