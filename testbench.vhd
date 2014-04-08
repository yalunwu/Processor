library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
  port (
			clock: 		in 	std_logic;
			reset:	 	in 	std_logic
  ) ;
end entity ; -- Multiplier 

architecture Behaviorial of testbench is


component BufferUnit
  port (
	clock: 		in 		std_logic;
	dataIn: 	in 		std_logic_vector(31 downto 0);
	dataOut:	out 	std_logic_vector (31 downto 0)
  ) ;
end component ; 
		signal	data1:			std_logic_vector(31 downto 0)	:=std_logic_vector(to_unsigned(0,32));
		signal	data2:			std_logic_vector(31 downto 0)	:=std_logic_vector(to_unsigned(0,32));
		signal	dataOut1:		std_logic_vector(31 downto 0);	
		signal	dataOut2:		std_logic_vector(31 downto 0);
		signal  exceptionDivideByZero: std_logic;
begin

	D:BufferUnit
	port map(
		clock   => clock,
		dataIn  => data1,
		dataOut => dataOut1
		);

	process(clock,reset)
	begin
		if rising_edge(clock) then

			data1 <= std_logic_vector(to_unsigned(10,32));
			

		end if ;
		
	end process ; -- 
end architecture ; -- 