library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity execute is
  port (
	clock				: 	in 	std_logic;
	reset 				: 	in 	std_logic;

	mode				:	in	std_logic_vector(4 downto 0);
	value1 				:	in	std_logic_vector(31 downto 0);
	value2				:	in	std_logic_vector(31 downto 0);
	value3				:	in	std_logic_vector(31 downto 0);
	inAddress			:	in 	std_logic_vector(4 downto 0);
 	inAddress2			:	in 	std_logic_vector(4 downto 0);

	memoryIsReady		:	in 	std_logic;
	executeIsReady		:	out std_logic;
	Branching			:	out	std_logic;
	BranchingLocation	:	out	std_logic_vector(31 downto 0);


	toReg	 			: 	out std_logic;
	toWrite				:	out std_logic;
	toLoad				:	out	std_logic;
	toSwap				:	out	std_logic;
	StoreAddress 		:	out std_logic_vector(4 downto 0);
	StoreAddress2		: 	out	std_logic_vector(4 downto 0);
	StoreValue 			:	out std_logic_vector(31 downto 0);
	StoreValue2 		:	out	std_logic_vector(31 downto 0)

  ) ;
end entity ; -- Execute


architecture arch of execute is

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
	
begin



	process( clock )
	variable 	tempValue:	std_logic_vector(63 downto 0);
	begin
		if rising_edge(clock)  then
			if reset = '1' then
					Branching 	<= 	'0';
					BranchingLocation<=std_logic_vector(to_unsigned(0,32));
					toReg		<=	'0';
					toWrite		<=	'0';
					toLoad 		<= 	'0';
					toSwap		<=	'0';
					executeIsReady<= '0';

					StoreAddress<= 	std_logic_vector(to_unsigned(0,5));
					StoreValue 	<=	std_logic_vector(to_unsigned(0,32)); 	
					StoreAddress2<= std_logic_vector(to_unsigned(0,5));
					StoreValue2	<=	std_logic_vector(to_unsigned(0,32));
					tempValue	:=	std_logic_vector(to_unsigned(0,64));
			else
				executeIsReady <= '0';
				case( mode ) is
					when NOP 		=>
						Branching 	<= 	'0';
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
					when MOV		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value1;					
					when ADD|ADDI	=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=std_logic_vector(unsigned(value1)+unsigned(value2));	
					when SUB	=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						if unsigned(value2)>unsigned(value1) then
							StoreValue	<=std_logic_vector(unsigned(value2)-unsigned(value1));
						else
							StoreValue 	<=std_logic_vector(to_unsigned(0,32));
						end if;
					when SUBI	=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						if unsigned(value1)>unsigned(value2) then
							StoreValue	<=std_logic_vector(unsigned(value1)-unsigned(value2));
						else
							StoreValue 	<=std_logic_vector(to_unsigned(0,32));
						end if;
					when MUT|MUTI	=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						tempValue	:=std_logic_vector(unsigned(value1)*unsigned(value2));
						StoreValue	<=tempValue(31 downto 0);
					when DIV =>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						if unsigned(value1) = to_unsigned(0,32)  then
							StoreValue <=std_logic_vector(to_unsigned(0,32));
						else
							StoreValue	<=std_logic_vector(unsigned(value2)/unsigned(value1));
						end if ;
					when DIVI =>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						if unsigned(value2) = to_unsigned(0,32)  then
							StoreValue <=std_logic_vector(to_unsigned(0,32));
						else
							StoreValue	<=std_logic_vector(unsigned(value1)/unsigned(value2));
						end if ;
					when AN|ANDI	=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value1 and value2;	
					when O|ORI		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value1 or value2;
					when NO 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<= value1 nor value2;
					when XO 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value1 xor value2;
					when LOD 		=>
						Branching 	<= 	'0';
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'1';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value1;
					when STE 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value1;
					when SWP 		=>
						Branching 	<= 	'0';
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'1';
						StoreAddress<=inAddress;
						StoreValue 	<=value1;
						StoreAddress2<=inAddress2;
						StoreValue2 <=value2;
					when WRT 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value2;
					when INC 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=std_logic_vector(unsigned(value1)+1);
					when DEC 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						if unsigned(value1)=to_unsigned(0,32) then
							StoreValue	<=std_logic_vector(to_unsigned(0,32));
						else
							StoreValue	<=std_logic_vector(unsigned(value1)-1);
						end if ;
					when SHL 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						
						StoreValue	<=value1(30 downto 0) & '0';
					when SHR 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<='0' & value1(31 downto 1);
					when NT 		=>
						Branching 	<= 	'0';
						toReg		<=	'1';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<= not value1;
					when BRH 		=>
						Branching 	<= 	'1';
						BranchingLocation<= value1;
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						StoreAddress<=inAddress;
						StoreValue	<=value1;
					when BEQ 		=>
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						if value1 = value2 then
							Branching 	<= 	'1';
							BranchingLocation<=value3;
						else
							Branching <='0';
						end if ;
					when BNE 		=>
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
						if value1 /= value2 then
							Branching 	<= 	'1';
							BranchingLocation<=value3;
						else
							Branching <='0';
						end if ;
					when INT		=>
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
				
					when others =>
						toReg		<=	'0';
						toWrite		<=	'0';
						toLoad 		<= 	'0';
						toSwap		<=	'0';
				
				end case ;
				executeIsReady <='1';

			end if ;
		end if ;
	end process ; -- 
end architecture ; -- arch