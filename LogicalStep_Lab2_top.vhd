library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------------------------
-- Entity top level 
entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

-- Architecture top level
architecture SimpleCircuit of LogicalStep_Lab2_top is

-- Components used
------------------------------------------------------------------- 
	-- Component for displaying on 7 segment display
	component SevenSegment port (
		hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
	); 
   end component;
	
	component segment7_mux port (
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0);
		DIN1		: in std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
	);
	end component;
	
	-- Component to add 2 inputs, and handle casting issues
	component Adder port (
		add_inpA				: in std_logic_vector(7 downto 0);
		add_inpB				: in std_logic_vector(7 downto 0);
		sum					: out	std_logic_vector(7 downto 0) 
	);
	end component;	
	
	-- Component to get LED display binary
	component LedMux port (
		control					: in	std_logic_vector(3 downto 0);
		hex_A					: in	std_logic_vector(3 downto 0);
		hex_B					: in	std_logic_vector(3 downto 0);
		total					: in	std_logic_vector(7 downto 0);
		output					: out	std_logic_vector(7 downto 0)
	);
	end component; 
	
	-- Component to get 7 segment display binary
	component SegmentMux port (
		control					: in	std_logic_vector(3 downto 0);
		seg					: in	std_logic_vector(7 downto 0);
		total					: in	std_logic_vector(7 downto 0);
		output					: out	std_logic_vector(7 downto 0)
	);
	end component;
		
-- Signals, or temporary variables to be used
-- std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR

	signal seg7_A		: std_logic_vector(6 downto 0); -- Left segment binary
	signal seg7_B		: std_logic_vector(6 downto 0); -- Right segment binary
	signal hex_A		: std_logic_vector(3 downto 0); -- Switch 7-4 inputs
	signal hex_B		: std_logic_vector(7 downto 4); -- Switch 3-0 inputs
	signal total		: std_logic_vector(7 downto 0); -- Result from adder component
	signal resultA		: std_logic_vector(7 downto 0); -- 7 Segment display binary
	signal resultB		: std_logic_vector(7 downto 0); -- LED display binary
	
-- Here the circuit begins
begin

	-- Variable initializations
	hex_A <= sw(7 downto 4);
	hex_B <= sw(3 downto 0);
	leds <= resultB;
						 
-- Component hook-up
	
	INST1: Adder port map("0000" & hex_A, "0000" & hex_B, total); -- Adds 2 4-bit binary numbers
	INST2: LedMux  port map(pb, hex_A, hex_B, total, resultB); -- Determines binary to display on LEDs
	INST3: SegmentMux port map(pb,hex_A & hex_B, total,resultA); -- Determines binary to display to 7 Segment
	INST4: SevenSegment port map(resultA(7 downto 4), seg7_A); -- Display to left segment
	INST5: SevenSegment port map(resultA(3 downto 0), seg7_B); -- Display to right segment
	INST6: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char1, seg7_char2);
	
end SimpleCircuit;

-- End of file 

