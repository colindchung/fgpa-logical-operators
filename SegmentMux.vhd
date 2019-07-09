library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
------------------------------------------------------------------------
-- This mux uses the pb logic vector to determine what to display on the segments
-- Input parameters: push button logic vector, switch 7-0 inputs, total result from Adder
-- Returns an 8-bit logic vector

-- Entity for mux
entity SegmentMux is port (
   
	control					: in	std_logic_vector(3 downto 0);
	seg						: in	std_logic_vector(7 downto 0);
	total 					: in  std_logic_vector(7 downto 0);
	output					: out	std_logic_vector(7 downto 0)
	
); 
end SegmentMux;

-- Architecture for 2:1 mux
architecture Behavioral of SegmentMux is

begin
		with control select				 
		output 		 <= seg when "1111",
						  seg when "1110", -- AND  
						  seg when "1101", -- OR  
						  seg when "1011", -- XOR
						  total when "0111",                   -- ADD
						 "10001000" when others;               -- ERROR
							 
end architecture Behavioral; 

-- End of file