library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch is
  port (
			clock: 				in 	std_logic;
			reset:	 			in 	std_logic;
			

			Branched:			in  std_logic;
			BranchLocation:		in  std_logic_vector(31 downto 0);

			requestFetch:		in 	std_logic;
			
			programCounter:		out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32));
			nextInstruction:	out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32))
  ) ;
end entity ; -- Fetch

architecture arch of fetch is

	
	
begin
	

	process(clock,reset)
	variable			PCounter:			unsigned(31 downto 0);
	variable			counterValue:		integer;
	begin
		if rising_edge(clock) then
			

			if reset = '1' then
				PCounter 		:= to_unsigned(0,32);
				nextInstruction <=std_logic_vector(to_unsigned(0,32));
				
			elsif Branched = '1' then
				PCounter :=(unsigned(BranchLocation));
			else
				if requestFetch = '1' then
					PCounter := PCounter + 1;
				end if ;

			end if ;
			counterValue:=to_integer((PCounter));
			case( counterValue ) is
	
				when 0 	=>
					nextInstruction <="00011000000000000000000000000001";
				when 1 	=>
					nextInstruction <="00011000010000000000000000000001";
				when 2 	=>
					nextInstruction <="00011111000000000000000000011011";
				when 3	=>
					nextInstruction <="00011111010000000000000001100100";
				when 4 	=>
					nextInstruction <="00011111100000000000000000001010";
				when 5 	=>
					nextInstruction <="10110000011111100000000000000000";
				when 6 	=>
					nextInstruction <="00100111110000000000000000000000";
				when 7 	=>
					nextInstruction <="00001000010001000000000000000000";
				when 8 	=>
					nextInstruction <="00010000010001000000000000000000";
				when 9 	=>
					nextInstruction <="10110000101111100000000000000000";
				when 10	=>
					nextInstruction <="00100111110000000000000000000000";
				when 11	=>
					nextInstruction <="00001000010001100000000000000000";
				when 12	=>
					nextInstruction <="00010000100001100000000000000000";
				when 13	=>
					nextInstruction <="10110000111111100000000000000000";
				when 14	=>
					nextInstruction <="11101000111110111100000000000000";
				when 15	=>
					nextInstruction <="00100111110000000000000000000000";
				when 16	=>
					nextInstruction <="00001000100000100000000000000000";
				when 17	=>
					nextInstruction <="00010000110000100000000000000000";
				when 18	=>
					nextInstruction <="10110000011111100000000000000000";
				when 19	=>
					nextInstruction <="11101000011110111100000000000000";
				when 20	=>
					nextInstruction <="00100111110000000000000000000000";
				when 21	=>
					nextInstruction <="00001000110001000000000000000000";
				when 22	=>
					nextInstruction <="00010000010001000000000000000000";
				when 23	=>
					nextInstruction <="10110000101111100000000000000000";
				when 24	=>
					nextInstruction <="11101111010001011110000000000000";
				when 25	=>
					nextInstruction <="00000000000000000000000000000000";
				when 26	=>
					nextInstruction <="00000000000000000000000000000000";
				when 27	=>
					nextInstruction <="10111111110000000000000000000000";
				when 28	=>
					nextInstruction <="10101000001111100000000000000000";
				when 29	=>
					nextInstruction <="00100111110000000000000000000000";
				when 30	=>
					nextInstruction <="10101000011111100000000000000000";
				when 31	=>
					nextInstruction <="00100111110000000000000000000000";
				when 32	=>
					nextInstruction <="10101000101111100000000000000000";
				when 33	=>
					nextInstruction <="00100111110000000000000000000000";
				when 34	=>
					nextInstruction <="10101000111111100000000000000000";
				when 35	=>
					nextInstruction <="00100111110000000000000000000000";
				when 36	=>
					nextInstruction <="10101001001111100000000000000000";
				when 37	=>
					nextInstruction <="00100111110000000000000000000000";
				when 38	=>
					nextInstruction <="10101001011111100000000000000000";
				when 39	=>
					nextInstruction <="00100111110000000000000000000000";
				when 40	=>
					nextInstruction <="10101001101111100000000000000000";
				when 41	=>
					nextInstruction <="00100111110000000000000000000000";
				when 42	=>
					nextInstruction <="10101001111111100000000000000000";
				when 43	=>
					nextInstruction <="00100111110000000000000000000000";
				when 44	=>
					nextInstruction <="10101010001111100000000000000000";
				when 45	=>
					nextInstruction <="00100111110000000000000000000000";
				when 46	=>
					nextInstruction <="10101010011111100000000000000000";
				when 47	=>
					nextInstruction <="00100111110000000000000000000000";
				when 48	=>
					nextInstruction <="10101010101111100000000000000000";
				when 49	=>
					nextInstruction <="00100111110000000000000000000000";
				when 50	=>
					nextInstruction <="10101010111111100000000000000000";
				when 51	=>
					nextInstruction <="00100111110000000000000000000000";
			
				when others => nextInstruction <= "00000000000000000000000000000000";
			
			end case ;
			programCounter <=std_logic_vector(PCounter);
		end if ;
	end process ; -- 
end architecture ; -- 