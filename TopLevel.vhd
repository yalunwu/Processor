library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel is
  port (
			clock: 		in 	std_logic;
			reset:	 	in 	std_logic;

			TX:			in  std_logic;
			RX:			in	std_logic
  ) ;
end entity ;

architecture RTL of TopLevel is
	signal ProgramCounter:		std_logic_vector(31 downto 0);
	signal 
	

begin
	Instruction : process( clock )
	begin
		if rising_edge(clock) then
				
		end if ;
		
	end process ; -- Fetch



	Execute : process( sensitivity_list )
	begin
		if rising_edge(clock) then
				
		end if ;
		
	end process ; -- Execute




	WriteBack : process( sensitivity_list )
	begin
		if rising_edge(clock) then
				
		end if ;
		
	end process ; -- WriteBack

end architecture ; -- RTL