library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructionCache is
  port (
			clock: 				in 	std_logic;
			reset:	 			in 	std_logic;
			flushCache:			in 	std_logic;
			requestForInst:		in 	std_logic;
			nextInstruction:	in	std_logic_vector(31 downto 0);
			fullCache:			out	std_logic;
			fetchedInstruction:	out	std_logic_vector(31 downto 0)

  ) ;
end entity ; -- instructionCache

architecture arch of instructionCache is
	

	type 			Cache 				is array (15 downto 0 ) of std_logic_vector(31 downto 0);
	signal			instructionCache: 	Cache 						;
	signal			counter:			integer						:=0;
	signal 			fullFlag:			std_logic;
begin
	cacheUpdate : process( clock,reset )
	begin
		if rising_edge(clock) then
			if reset='1' or flushCache = '1' then
				instructionCache <=((others=> (others=>'0')));
				counter <= 0;
				fullFlag <='0';
				fetchedInstruction <=std_logic_vector(to_unsigned(0,32));
			else
				if counter<15  then
					instructionCache(counter) <=nextInstruction;
					counter <= counter + 1;
				end if ;

				if requestForInst = '1' then
					fetchedInstruction <= instructionCache(0);
					instructionCache(counter - 1 downto 0) <= instructionCache(counter downto 1);
					counter <= counter - 1;

				end if ;
				if counter=15 then
					fullFlag <='1';
				else
					fullFlag <='0';
				end if ;

			end if ;
		end if ;
		fullCache <= fullFlag;
	end process ; -- cacheUpdate

end architecture ; -- arch