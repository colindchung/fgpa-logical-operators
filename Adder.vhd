library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
------------------------------------------------------------------------
-- 4-bit adder. It returns the sum as an 8-bit std_logic_vector
-- This is created as an entity so that it can be reused many times easily

-- Entity for adder
entity Adder is port (
	add_inpA				: in std_logic_vector(7 downto 0);
	add_inpB				: in std_logic_vector(7 downto 0);
   sum					: out	std_logic_vector(7 downto 0) 
); 
end Adder;

-- Architecture for adder
architecture Behavioral of Adder is

begin

	sum (7 downto 0) <= std_logic_vector(unsigned(add_inpA) + unsigned(add_inpB));	
	
end architecture Behavioral; 
-- End of file
	