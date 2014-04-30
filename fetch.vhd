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

			flushCache:			out std_logic;

			programCounter:		out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32));
			nextInstruction:	out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32))
  ) ;
end entity ; -- Fetch

architecture arch of fetch is

	signal			PCounter:			unsigned(31 downto 0);

begin
	

	process(clock,reset)
	begin
		if rising_edge(clock) then
			
			flushCache <= '0';

			if reset = '1' then
				PCounter <= to_unsigned(0,32);

				nextInstruction <=std_logic_vector(to_unsigned(0,32));

			elsif Branched = '1' then
				PCounter <=(unsigned(BranchLocation)-1);
				nextInstruction <=std_logic_vector(to_unsigned(0,32));
				flushCache <= '1';
			else
				PCounter <=PCounter+1;

			end if ;
			programCounter <=std_logic_vector(PCounter);
		end if ;
	end process ; -- 
end architecture ; -- 