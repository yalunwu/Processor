library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch is
  port (
			clock: 				in 	std_logic;
			reset:	 			in 	std_logic;
			readIn:				in  std_logic_vector(31 downto 0);

			Branched:			in  std_logic;
			BranchLocation:		in  std_logic_vector(31 downto 0);

			requestFetch:		in 	std_logic;
			
			programCounter:		out std_logic_vector(31 downto 0);
			nextInstruction:	out std_logic_vector(31 downto 0)
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
			elsif Branched = '1' then
				PCounter :=(unsigned(BranchLocation));
			else
				if requestFetch = '1' then
					PCounter := PCounter + 1;
				end if ;

			end if ;
			if PCounter>=to_unsigned(500,32) then
				PCounter:=to_unsigned(500,32);
			end if ;
			counterValue:=to_integer((PCounter));

			programCounter <=std_logic_vector(PCounter);
		end if ;

	end process ; --

	nextInstruction<=readIn; 

end architecture ; -- 