library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionList is
  port (
  	reset:			in std_logic;
	programCounter:	in std_logic_vector(31 downto 0);
	readIn: 		out std_logic_vector(31 downto 0)
  ) ;
end entity ; -- InstructionList

architecture arch of InstructionList is
	
begin
	process(reset,programCounter)
	variable 			counterValue:		integer 	:= 0;
	variable			PCounter:			unsigned(31 downto 0):=to_unsigned(0,32);
	begin
		PCounter :=unsigned(programCounter);
		counterValue:=to_integer((PCounter));
		if reset = '1' then
			readIn <= "00000000000000000000000000000000";
		else
			case( counterValue ) is
		
					when 0 	=>
						readIn <="00011000000000000000000000000001";
					when 1 	=>
						readIn <="00011000010000000000000000000001";
					when 2 	=>
						readIn <="00011111000000000000000000011011";
					when 3	=>
						readIn <="00011111010000000000000001100100";
					when 4 	=>
						readIn <="00011111100000000000000000001010";
					when 5 	=>
						readIn <="10110000011111100000000000000000";
					when 6 	=>
						readIn <="00100111110000000000000000000000";
					when 7 	=>
						readIn <="00001000010001000000000000000000";
					when 8 	=>
						readIn <="00010000010001000000000000000000";
					when 9 	=>
						readIn <="10110000101111100000000000000000";
					when 10	=>
						readIn <="00100111110000000000000000000000";
					when 11	=>
						readIn <="00001000010001100000000000000000";
					when 12	=>
						readIn <="00010000100001100000000000000000";
					when 13	=>
						readIn <="10110000111111100000000000000000";
					when 14	=>
						readIn <="11101000111110111100000000000000";
					when 15	=>
						readIn <="00100111110000000000000000000000";
					when 16	=>
						readIn <="00001000100000100000000000000000";
					when 17	=>
						readIn <="00010000110000100000000000000000";
					when 18	=>
						readIn <="10110000011111100000000000000000";
					when 19	=>
						readIn <="11101000011110111100000000000000";
					when 20	=>
						readIn <="00100111110000000000000000000000";
					when 21	=>
						readIn <="00001000110001000000000000000000";
					when 22	=>
						readIn <="00010000010001000000000000000000";
					when 23	=>
						readIn <="10110000101111100000000000000000";
					when 24	=>
						readIn <="11101111010001011110000000000000";
					when 25	=>
						readIn <="00000000000000000000000000000000";
					when 26	=>
						readIn <="00000000000000000000000000000000";
					when 27	=>
						readIn <="10111111110000000000000000000000";
					when 28	=>
						readIn <="10101000001111100000000000000000";
					when 29	=>
						readIn <="00100111110000000000000000000000";
					when 30	=>
						readIn <="10101000011111100000000000000000";
					when 31	=>
						readIn <="00100111110000000000000000000000";
					when 32	=>
						readIn <="10101000101111100000000000000000";
					when 33	=>
						readIn <="00100111110000000000000000000000";
					when 34	=>
						readIn <="10101000111111100000000000000000";
					when 35	=>
						readIn <="00100111110000000000000000000000";
					when 36	=>
						readIn <="10101001001111100000000000000000";
					when 37	=>
						readIn <="00100111110000000000000000000000";
					when 38	=>
						readIn <="10101001011111100000000000000000";
					when 39	=>
						readIn <="00100111110000000000000000000000";
					when 40	=>
						readIn <="10101001101111100000000000000000";
					when 41	=>
						readIn <="00100111110000000000000000000000";
					when 42	=>
						readIn <="10101001111111100000000000000000";
					when 43	=>
						readIn <="00100111110000000000000000000000";
					when 44	=>
						readIn <="10101010001111100000000000000000";
					when 45	=>
						readIn <="00100111110000000000000000000000";
					when 46	=>
						readIn <="10101010011111100000000000000000";
					when 47	=>
						readIn <="00100111110000000000000000000000";
					when 48	=>
						readIn <="10101010101111100000000000000000";
					when 49	=>
						readIn <="00100111110000000000000000000000";
					when 50	=>
						readIn <="10101010111111100000000000000000";
					when 51	=>
						readIn <="00100111110000000000000000000000";
				
					when others => readIn <= "00000000000000000000000000000000";
				
				end case ;
			end if ;
	end process ; -- identifier

end architecture ; -- arch