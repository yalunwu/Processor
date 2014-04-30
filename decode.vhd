library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode is
  port (
	clock 				: 	in 	std_logic;
	reset 				: 	in 	std_logic;
	fetchedInstruction	:	in 	std_logic_vector(31 downto 0);

	RequestUpdate		:	in 	std_logic;
	UpdateRegister		:	in 	std_logic_vector(4 downto 0);
	UpdateRegValue		:	in 	std_logic_vector(31 downto 0);
	RequestUpdate2		:	in 	std_logic;
	UpdateRegister2		:	in 	std_logic_vector(4 downto 0);
	UpdateRegValue2		:	in 	std_logic_vector(31 downto 0);

	RequestFetch		: 	out std_logic;


	executeIsReady		:	in 	std_logic;
	mode				:	out	std_logic_vector(4 downto 0);
	outputAddress		: 	out std_logic_vector(4 downto 0);
	outputAddress2		: 	out std_logic_vector(4 downto 0);
	value1 				:	out	std_logic_vector(31 downto 0);
	value2				:	out	std_logic_vector(31 downto 0);
	value3				:	out	std_logic_vector(31 downto 0)
  ) ;
end entity ; -- decode :

architecture arch of decode is

	constant NOP :		std_logic_vector(4 downto 0) :="00000";
	constant MOV :		std_logic_vector(4 downto 0) :="00001";
	constant ADD :		std_logic_vector(4 downto 0) :="00010";
	constant ADDI:		std_logic_vector(4 downto 0) :="00011";

	constant INC :		std_logic_vector(4 downto 0) :="00100";
	constant SUB :		std_logic_vector(4 downto 0) :="00101";
	constant SUBI:		std_logic_vector(4 downto 0) :="00110";
	constant DEC :		std_logic_vector(4 downto 0) :="00111";

	constant MUT :		std_logic_vector(4 downto 0) :="01000";
	constant MUTI:		std_logic_vector(4 downto 0) :="01001";
	constant DIV :		std_logic_vector(4 downto 0) :="01010";
	constant DIVI:		std_logic_vector(4 downto 0) :="01011";

	constant SHL :		std_logic_vector(4 downto 0) :="01100"; --sla
	constant SHR :		std_logic_vector(4 downto 0) :="01101";	--sra
	constant AN  :		std_logic_vector(4 downto 0) :="01110";	--AND
	constant ANDI:		std_logic_vector(4 downto 0) :="01111";	

	constant O 	 :		std_logic_vector(4 downto 0) :="10000";--or
	constant ORI :		std_logic_vector(4 downto 0) :="10001";
	constant NO  :		std_logic_vector(4 downto 0) :="10010";--nor
	constant NT  :		std_logic_vector(4 downto 0) :="10011";--not

	constant XO  :		std_logic_vector(4 downto 0) :="10100";--xor
	constant LOD :		std_logic_vector(4 downto 0) :="10101";
	constant STE :		std_logic_vector(4 downto 0) :="10110";
	constant WRT :		std_logic_vector(4 downto 0) :="10111";

	constant SWP :		std_logic_vector(4 downto 0) :="11000";
	constant BRH :		std_logic_vector(4 downto 0) :="11001";
	constant BEQ :		std_logic_vector(4 downto 0) :="11010";
	constant BNE :		std_logic_vector(4 downto 0) :="11011";
	constant INT :		std_logic_vector(4 downto 0) :="11100";



	signal 			Operation:			std_logic_vector(4 downto 0) :="00000";
	type 			ArrayData			is array (31 downto 0 ) of std_logic_vector(31 downto 0);
	signal			GPR:				ArrayData;
	type			IntegerArray		is array (5 downto 0) of integer;
	type 			tempIntegerArray	is array (1 downto 0) of integer;
	signal			ListOfUsedReg:		IntegerArray;
	signal 			tempList:			tempIntegerArray;
begin
	process( clock )
	begin
		
		if rising_edge(clock) then
			if reset = '1' then
				value1 		<=	std_logic_vector(to_unsigned(0,32));
				value2 		<=	std_logic_vector(to_unsigned(0,32));
				value3 		<=	std_logic_vector(to_unsigned(0,32));
				RequestFetch<= '0';

				GPR 		<=	(others=> (others=>'0'));
				ListOfUsedReg<= (others=> 0);
				tempList 	<=	(others=> 0);
				outputAddress  <="00000";
				outputAddress2 <="00000";
			else
				RequestFetch <= '1';
				if RequestUpdate = '1' then
					GPR(to_integer(unsigned(UpdateRegister))) <= UpdateRegValue;x
				end if ;
				if RequestUpdate2 = '1' then
					GPR(to_integer(unsigned(UpdateRegister2))) <= UpdateRegValue2;
				end if ;
				Operation <= fetchedInstruction(31 downto 27);
				mode <= Operation;
				tempList(0) <= -1;
				tempList(1) <= -1;
				outputAddress  <="00000";
				outputAddress2 <="00000";
				case( Operation ) is
						
					when MOV|ADD|SUB|MUT|DIV|AN|O|NO|XO|LOD|STE =>
						value1 		<=	GPR(to_integer(unsigned(fetchedInstruction(26 downto 22))));
						value2 		<=	GPR(to_integer(unsigned(fetchedInstruction(21 downto 17))));
						value3 		<=	std_logic_vector(to_unsigned(0,32));
						outputAddress<=fetchedInstruction(21 downto 17);
						tempList(0) <=	to_integer(unsigned(fetchedInstruction(26 downto 22)));
						tempList(1) <=	to_integer(unsigned(fetchedInstruction(21 downto 17)));
					when SWP =>
						value1 		<=	GPR(to_integer(unsigned(fetchedInstruction(26 downto 22))));
						value2 		<=	GPR(to_integer(unsigned(fetchedInstruction(21 downto 17))));
						value3 		<=	std_logic_vector(to_unsigned(0,32));
						outputAddress<=fetchedInstruction(21 downto 17);
						outputAddress2<=fetchedInstruction(26 downto 22);
						tempList(0) <=	to_integer(unsigned(fetchedInstruction(26 downto 22)));
						tempList(1) <=	to_integer(unsigned(fetchedInstruction(21 downto 17)));
					when ADDI|SUBI|MUTI|DIVI|ORI|WRT|ANDI 	=>
						value1 		<=	GPR(to_integer(unsigned(fetchedInstruction(26 downto 22))));
						value2 		<=	std_logic_vector(to_unsigned(0,32)+unsigned(fetchedInstruction(21 downto 0)));
						value3 		<=	std_logic_vector(to_unsigned(0,32));
						outputAddress<=fetchedInstruction(26 downto 22);
						tempList(0) <=	to_integer(unsigned(fetchedInstruction(26 downto 22)));
						tempList(1) <=	-1;
					when INC|DEC|SHL|SHR|NT|BRH 	=>
						value1 		<=	GPR(to_integer(unsigned(fetchedInstruction(26 downto 22))));
						value2 		<=	std_logic_vector(to_unsigned(0,32));
						value3 		<=	std_logic_vector(to_unsigned(0,32));
						outputAddress<=fetchedInstruction(26 downto 22);
						tempList(0) <=	to_integer(unsigned(fetchedInstruction(26 downto 22)));
						tempList(1) <=	-1;
					when BEQ|BNE =>
						value1 		<=	GPR(to_integer(unsigned(fetchedInstruction(26 downto 22))));
						value2 		<=	GPR(to_integer(unsigned(fetchedInstruction(21 downto 17))));
						value3 		<=	GPR(to_integer(unsigned(fetchedInstruction(16 downto 12))));
					when INT =>
						value1 		<=	std_logic_vector(to_unsigned(0,32));
						value2 		<=	std_logic_vector(to_unsigned(0,32));
						value3 		<=	std_logic_vector(to_unsigned(0,32));
					when others =>
						mode <= NOP;
						value1 		<=	std_logic_vector(to_unsigned(0,32));
						value2 		<=	std_logic_vector(to_unsigned(0,32));
						value3 		<=	std_logic_vector(to_unsigned(0,32));
							
				end case ;			
				-- detection for conflict here, check and store a list of address required
				-- for the current and previous 2 operations
				-- only matter for operation on data manipulations
				-- exluded ops: NOP, BEQ,BRH ,BNE, INT
				 for i in 0 to 5 loop
						for j in 0 to 1 loop
							if tempList(j) = ListOfUsedReg(i) then
								RequestFetch<='0';
								mode <=NOP;
							end if ;
						end loop ; -- identifier
				end loop ; -- checkList	
				ListOfUsedReg(3 downto 0) <= ListOfUsedReg(5 downto 2);
				ListOfUsedReg(5) <= tempList(0);
				ListOfUsedReg(4) <= tempList(1);
			end if ;
			--to do: store the previous instruction. 




		end if ;	
	end process ; -- IR



end architecture ; -- arch