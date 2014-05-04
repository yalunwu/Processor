library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch is
  port (
			clock: 				in 	std_logic;
			reset:	 			in 	std_logic;
			readIn:				in 	std_logic_vector(31 downto 0);

			Branched:			in  std_logic;
			BranchLocation:		in  std_logic_vector(31 downto 0);

			requestFetch:				in 	std_logic;
			
			programCounter:		out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32));
			nextInstruction:	out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32))
  ) ;
end entity ; -- Fetch

architecture arch of fetch is

	
	
begin
	

	process(clock,reset)
	variable			PCounter:			unsigned(31 downto 0);
	begin
		if rising_edge(clock) then
			

			if reset = '1' then
				PCounter 		:= to_unsigned(0,32);
				nextInstruction <=std_logic_vector(to_unsigned(0,32));
				
			elsif Branched = '1' then
				PCounter :=(unsigned(BranchLocation)-1);
				nextInstruction <=std_logic_vector(to_unsigned(0,32));
			else
				if requestFetch = '1' then
					PCounter := PCounter + 1;
					nextInstruction<=readIn;
				end if ;

			end if ;
			programCounter <=std_logic_vector(PCounter);
		end if ;
	end process ; -- 
end architecture ; -- 