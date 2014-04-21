library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode is
  port (
	clock 				: 	in std_logic;
	reset 				: 	in std_logic;
	EnabledFetch		: 	out std_logic;
	nextInstruction		:	in std_logic_vector(31 downto 0);
	mode				:	out	std_logic_vector(4 downto 0);
	address1			:	out	std_logic_vector(4 downto 0);
	address2 			:	out	std_logic_vector(4 downto 0);
	address3			:	out	std_logic_vector(4 downto 0);
	value1 				:	out	std_logic_vector(27 downto 0)
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

begin
	IR : process( clock )
	begin
		
	end process ; -- IR

end architecture ; -- arch