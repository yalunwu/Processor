library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch is
  port (
			clock: 				in 	std_logic;
			reset:	 			in 	std_logic;
			readIn:				in 	std_logic_vector(31 downto 0);
			EnabledFetch:		in 	std_logic;
			Branched:			in  std_logic;
			BranchLocation:		in  std_logic_vector(31 downto 0);
			programCounter:		out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32));
			nextInstruction:	out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32))
  ) ;
end entity ; -- Fetch

architecture arch of fetch is

	signal			counter:			std_logic_vector(31 downto 0);
	signal 			state:				std_logic_vector(2 downto 0):="111";		
	constant		waiting:			std_logic_vector(2 downto 0):="000";
	constant		resetMode:			std_logic_vector(2 downto 0):="111";
	constant		reading:			std_logic_vector(2 downto 0):="001";
	constant		readWait:			std_logic_vector(2 downto 0):="010";
	constant		Branching:			std_logic_vector(2 downto 0):="100";
	type 			Cache 				is array (15 downto 0 ) of std_logic_vector(31 downto 0);
	signal			instructionCache: 	Cache 						:=((others=> (others=>'0')));

begin
	

	process(clock,reset)
	begin
		if rising_edge(clock) then
			

			if reset = '1' then
				counter <= std_logic_vector(to_unsigned(0,32));
				programCounter <= std_logic_vector(to_unsigned(0,32));
				nextInstruction <=std_logic_vector(to_unsigned(0,32));
			elsif Branched = '1' then
				counter <=BranchLocation;
				programCounter <= BranchLocation;
				nextInstruction <=std_logic_vector(to_unsigned(0,32));
			elsif EnabledFetch ='1' then
				programCounter <= std_logic_vector(unsigned(counter)+to_unsigned(1,32));
				counter <= std_logic_vector(unsigned(counter)+to_unsigned(1,32));
				nextInstruction	<= instructionCache(0);
				instructionCache(14 downto 0) <= instructionCache(15 downto 1);
				instructionCache(15) <= readIn;
					
			end if ;

		end if ;
	end process ; -- 
end architecture ; -- 