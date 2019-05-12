library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--A clk divider that divides a 100MHz clk to 500 hz and shows that output on LED16_R
entity clkDiv100to500 is 
	port(clk_in : in std_logic;
		 clk_out   : out std_logic;
		 LED16_B  : out std_logic);
end clkDiv100to500;

architecture behaviour of clkDiv100to500 is
	signal count : INTEGER := 1;
	signal clock_out : STD_LOGIC := '0';
begin								-- generates a 1Hz clk_out from a 100MHz clk_in.
	process(clk_in)
		begin
			 if (clk_in'event and clk_in = '1') then
				count <= count + 1;
				if(count = 100000) then           -- if counter == 50,000,000
					clock_out <= not clock_out;     --  toggle clock
				    count <= 1;                         --  reset counter
				end if;
			end if;
	end process;
	clk_out <= clock_out;
end behaviour;