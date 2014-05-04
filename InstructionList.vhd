library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionList is
  port (
	clock:			in std_logic;
	reset:			in std_logic;
	stopFlag:		in std_logic;
	programCounter:	in std_logic_vector(31 downto 0);
	readIn: 		out std_logic_vector(31 downto 0)
  ) ;
end entity ; -- InstructionList

architecture arch of InstructionList is
	signal counterValue: integer;
begin
	process( clock,reset )
	begin
		if rising_edge(clock) then
			if reset = '1' then
				readIn <= std_logic_vector(to_unsigned(0,32));
				counterValue <= 0;
			else
				if stopFlag = '1' then
					if counterValue >25 then
						readIn <= "00000000000000000000000000000000";
					else
						case( counterValue ) is
				
							when 0 	=> readIn <= "00000000000000000000000000000000";
							when 1 	=> readIn <= "00000000000000000000000000000000";
							when 2 	=> readIn <= "00011000000000000000000000110111";
							when 3 	=> readIn <= "10111000010000000000000001100011";
							when 4 	=> readIn <= "11011100000110111100000000000000";
							when 5 	=> readIn <= "10111000100000000000000001111011";
							when 6 	=> readIn <= "00100000000000000000000000000000";
							when 7 	=> readIn <= "00111000100000000000000000000000";
							when 8 	=> readIn <= "10111101110000000000000000010001";
							when 9 	=> readIn <= "00010000000001100000000000000000";
							when 10 => readIn <= "00101000000000100000000000000000";
							when 11 => readIn <= "00010000100010000000000000000000";
							when 12 => readIn <= "00010000100010100000000000000000";
							when 13 => readIn <= "00010000100011000000000000000000";
							when 14 => readIn <= "00001000010110100000000000000000";
							when 15 => readIn <= "00110001100000000000000000000010";
							when 16 => readIn <= "11001101110000000000000000000000";
							when 17 => readIn <= "01000001000010100000000000000000";
							when 18 => readIn <= "01001011010000000000000111110100";
							when 19 => readIn <= "00100001110000000000000000000000";
							when 20 => readIn <= "10111010000000000000000001111010";
							when 21 => readIn <= "10111010010000000000000000000010";
							when 22 => readIn <= "01010010010100000000000000000000";
							when 23 => readIn <= "01011011010000000000000001100100";
							when 24 => readIn <= "01100010010000000000000000000000";
							when 25 => readIn <= "01101000000000000000000000000000";
							when 26 => readIn <= "01110001110101000000000000000000";
							when 27 => readIn <= "10000001110101100000000000000000";
							when 28 => readIn <= "01111011000000000000000000000001";
							when 29 => readIn <= "10001011110000000000000000000001";
							when 30 => readIn <= "10100001110111000000000000000000";
							when 31 => readIn <= "10011010100000000000000000000000";
							when 32 => readIn <= "10010100000011100000000000000000";
							when 33 => readIn <= "10110001110110100000000000000000";
							when 34 => readIn <= "11000010100110100000000000000000";
							when 35 => readIn <= "00011011100000000000000001100100";
							when 36 => readIn <= "11010011100111100111000000000000";
							when 37 => readIn <= "10101100101001100000000000000000";
						
							when others => readIn <= "00000000000000000000000000000000";
						
						end case ;
						counterValue <= counterValue +1;
					end if ;

				
				end if ;

			end if ;
		end if ;

		
	end process ; -- identifier

end architecture ; -- arch