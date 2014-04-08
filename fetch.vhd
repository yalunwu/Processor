library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch is
  port (
			clock: 				in 	std_logic;
			reset:	 			in 	std_logic;
			readIn:				in 	std_logic_vector(31 downto 0);
			programCounter:		inout std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32));
			nextInstruction:	out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32))
  ) ;
end entity ; -- Fetch

architecture  of fetch is

	signal			temp
	signal 			state:				std_logic_vector(2 downto 0):='111';
	constant		waiting:			std_logic_vector(2 downto 0):='000';
	constant		resetMode:			std_logic_vector(2 downto 0):='111';
	constant		readIn:				std_logic_vector(2 downto 0):='001';
	constant		readWait:			std_logic_vector(2 downto 0):='010';

begin

	process(clock,reset)
	begin
		if rising_edge(clock) then
			case( state ) is
				when waiting =>
					if reset = '1' then
						state <= resetMode;
					elsif readIn = '1' then
						state <= readIn;
					end if ;

				when resetMode =>
					programCounter <= std_logic_vector(to_unsigned(0,32));
					nextInstruction <=std_logic_vector(to_unsigned(0,32));
				when readIn =>
					nextInstruction <=readIn;				
			
				when others =>
				state <=resetMode;

			
			end case ;
			programCounter = programCounter +1;
		end if ;
	end process ; -- 
end architecture ; -- 