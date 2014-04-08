library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BufferUnit is
  port (
	clock: 		in 		std_logic;
	dataIn: 	in 		std_logic_vector(31 downto 0);
	dataOut:	out 	std_logic_vector(31 downto 0)
  ) ;
end entity ; 

architecture arch of BufferUnit is

	signal tempDataStorage : 		std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32));

begin
	process( clock )
	begin
		if(rising_edge(clock)) then
			dataOut 		<=	tempDataStorage;
			tempDataStorage <=	dataIn;
		end if;		
	end process ; -- 

end architecture ; -- arch