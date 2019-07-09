library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
------------------------------------------------------------------------

-- This mux uses the pb logic vector to determine which leds to light up
-- Input parameters: push button logic vector, switch 7-4 inputs, switch 3-0 inputs, total result from Adder
-- Returns an 8-bit logic vector

-- Entity for mux
entity LedMux is port (
   
	control					: in	std_logic_vector(3 downto 0);
	hex_A						: in	std_logic_vector(3 downto 0);
	hex_B						: in	std_logic_vector(3 downto 0);
	total 					: in std_logic_vector(7 downto 0);
	output					: out	std_logic_vector(7 downto 0)
	
); 
end LedMux;

-- Architecture for 2:1 mux
architecture Behavioral of LedMux is

begin
		with control select				 
		output 		 <= "00000000" when "1111",
						 "0000" & hex_A AND hex_B when "1110", -- AND  
						 "0000" & hex_A OR hex_B  when "1101", -- OR  
						 "0000" & hex_A XOR hex_B when "1011", -- XOR
						  total when "0111",                   -- ADD
						 "11111111" when others;               -- ERROR
							 
end architecture Behavioral; 

-- End of file