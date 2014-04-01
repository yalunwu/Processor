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

component Multiplier 
  port (
			clock: 		in 	std_logic;
			reset:	 	in 	std_logic;
			data1:		in 	std_logic_vector(31 downto 0);
			data2:		in	std_logic_vector(31 downto 0);
			dataOut:	out std_logic_vector(31 downto 0)
  ) ;
end component ; 

component divider 
  port (
			clock: 		in 	std_logic;
			reset:	 	in 	std_logic;
			data1:		in 	std_logic_vector(31 downto 0);
			data2:		in	std_logic_vector(31 downto 0);
			dataOut:	out std_logic_vector(31 downto 0)	
  ) ;
end component ; 
		signal	data1:			std_logic_vector(31 downto 0)	:=std_logic_vector(to_unsigned(0,32));
		signal	data2:			std_logic_vector(31 downto 0)	:=std_logic_vector(to_unsigned(0,32));
		signal	dataOut1:		std_logic_vector(31 downto 0);	
		signal	dataOut2:		std_logic_vector(31 downto 0);
begin
	M:Multiplier
	port map(
		clock 	=>	clock,
		reset	=>	reset,
		data1	=> 	data1,
		data2 	=>	data2,
		dataOut => 	dataOut1
		);
	D:divider
	port map(
		clock 	=>	clock,
		reset	=>	reset,
		data1	=> 	data1,
		data2 	=>	data2,
		dataOut => 	dataOut2
		);

	process(clock,reset)
	begin
		if rising_edge(clock) then
			data1 <= std_logic_vector(to_unsigned(10,32));
			data1 <= std_logic_vector(to_unsigned(5,32));

		end if ;
		
	end process ; -- 
end architecture ; -- 