library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Divider is
  port (
			clock: 		in 	std_logic;
			reset:	 	in 	std_logic;
			data1:		in 	std_logic_vector(31 downto 0);
			data2:		in	std_logic_vector(31 downto 0);
			dataOut:	out std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(0,32));
			exceptionOut:out std_logic:='0'
  ) ;
end entity ; -- Divider 

architecture Behaviorial of Divider is

begin
	process(clock,reset)
	begin
		if rising_edge(clock) or rising_edge(reset) then
			if reset = '1' or unsigned(data2(31 downto 0)) = 0 then
				dataOut <= std_logic_vector(to_unsigned(0,32));
				if(unsigned(data2(31 downto 0)) = 0) then
					exceptionout<='1';
				else
					exceptionout<='0';
				end if;
			else 
				dataOut <= std_logic_vector(to_unsigned(to_integer(unsigned(data1(31 downto 0)))/to_integer(unsigned(data2(31 downto 0))),32));
			end if ;
		end if ;
		
	end process ; -- 
end architecture ; -- 