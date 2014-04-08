library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Adder is
  port (
			clock: 		in 	std_logic;
			reset:	 	in 	std_logic;
			data1:		in 	std_logic_vector(31 downto 0);
			data2:		in	std_logic_vector(31 downto 0);
			dataOut:	out std_logic_vector(31 downto 0);	
			overFlow:	out std_logic:='0'
  ) ;
end entity ; -- Adder 

architecture Behaviorial of Adder is

begin
	process(clock,reset)
	begin
		if rising_edge(clock) or rising_edge(reset) then
			if reset = '1' then
				dataOut <= std_logic_vector(to_unsigned(0,32));
			else
				dataOut <= std_logic_vector(to_unsigned(to_integer(unsigned(data1(31 downto 0)))+to_integer(unsigned(data2(31 downto 0))),32));
			end if ;
		end if ;
		
	end process ; -- 
end architecture ; -- 