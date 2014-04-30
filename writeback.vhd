library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity writeBack is
  port (
	clock				: 	in 	std_logic;
	reset 				: 	in 	std_logic;
	
	toSwap				:	in	std_logic;
	toReg				:	in	std_logic;
	RegAddress			:	in	std_logic_vector(4 downto 0);
	RegValue			:	in	std_logic_vector(31 downto 0);
	RegAddress2			:	in	std_logic_vector(4 downto 0);
	RegValue2			:	in	std_logic_vector(31 downto 0);


	writebackIsReady	:	out	std_logic;
	requestUpdate		:	out	std_logic;
	requestUpdate2		:	out	std_logic;
	UpdateRegister		:	out	std_logic_vector(4 downto 0);
	UpdateRegValue		:	out	std_logic_vector(31 downto 0);
	UpdateRegister2		:	out	std_logic_vector(4 downto 0);
	UpdateRegValue2		:	out	std_logic_vector(31 downto 0)
  ) ;
end entity ; 
architecture arch of writeback is



begin

	SendData: process(clock,reset)
	begin
		if rising_edge(clock) then
			if reset = '1'  then
				writebackIsReady 	<= 	'0';
				requestUpdate 		<=	'0';
				requestUpdate2 		<=	'0';
				UpdateRegValue 		<= 	std_logic_vector(to_unsigned(0,32));
				UpdateRegValue2		<= 	std_logic_vector(to_unsigned(0,32));
				UpdateRegister 		<= 	std_logic_vector(to_unsigned(0,5));
				UpdateRegister2		<= 	std_logic_vector(to_unsigned(0,5));
			else
				requestUpdate 		<= '0';
				requestUpdate2 		<= '0';
				writebackIsReady 	<= '0';
				if toReg = '1' then
					requestUpdate 	<= '1';
					UpdateRegister 	<=	RegAddress;
					UpdateRegValue 	<=	RegValue;
				elsif toSwap ='1' then
					requestUpdate 	<= '1';
					UpdateRegister 	<=	RegAddress;
					UpdateRegValue 	<=	RegValue;
					requestUpdate2 	<= '1';
					UpdateRegister2	<=	RegAddress2;
					UpdateRegValue2	<=	RegValue2;
				end if ;
				writebackIsReady	<='1';
						
			end if ;
		end if ;
		
	end process ; -- 
end architecture ; -- arch