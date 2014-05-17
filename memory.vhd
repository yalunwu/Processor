library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
  port (
	clock				: 	in 	std_logic;
	reset 				: 	in 	std_logic;

	toReg	 			: 	in  std_logic;
	toWrite				:	in  std_logic;
	toLoad				:	in 	std_logic;
	toSwap				:	in 	std_logic;
	StoreAddress 		:	in  std_logic_vector(4 downto 0);
	StoreAddress2		: 	in 	std_logic_vector(4 downto 0);
	StoreValue 			:	in  std_logic_vector(31 downto 0);
	StoreValue2 		:	in 	std_logic_vector(31 downto 0);

	writebackIsReady	:	in	std_logic;

	RAMHasValue			:	out std_logic;
	RAMValue			:	out	std_logic_vector(31 downto 0);

	outReg				:	out std_logic;
	outSwap				:	out std_logic;
	memoryIsReady		:	out std_logic;
	RegAddress			:	out	std_logic_vector(4 downto 0);
	RegValue			:	out	std_logic_vector(31 downto 0);
	RegAddress2			:	out	std_logic_vector(4 downto 0);
	RegValue2			:	out	std_logic_vector(31 downto 0)

  ) ;
end entity ; -- memory

architecture arch of memory is
component sdpram 
generic (width : integer := 32; addr_width : integer := 7);
port (
        wrclk           : in std_logic;
        reset			: in std_logic;
        data            : in std_logic_vector(width-1 downto 0);
        wraddress       : in std_logic_vector(addr_width-1 downto 0);
        wren            : in std_logic;

        rdclk           : in std_logic;
        rdaddress       : in std_logic_vector(addr_width-1 downto 0);
        dout            : out std_logic_vector(width-1 downto 0)
);
end component ;
	signal 	RAMWriteData: 		std_logic_vector(31 downto 0);
	signal 	RAMWriteAddress:	std_logic_vector(7 downto 0);
	signal	RAMWriteEnable:		std_logic;
	signal	RAMReadAddress:		std_logic_vector(7 downto 0);
	signal	RAMReadData:		std_logic_vector(31 downto 0);

begin
	RAM:sdpram
	generic map(
		width => 32,
		addr_width =>8
		) 
	port map(
		wrclk 		=>clock,
		reset		=>reset,
		data  		=>RAMWriteData,
		wraddress 	=>RAMWriteAddress,
		wren		=>RAMWriteEnable,
		rdclk		=>clock,
		rdaddress 	=>RAMReadAddress,
		dout 		=>RAMReadData
		);
	process( clock, reset,RAMReadData )
	begin
		if rising_edge(clock) then
			if reset ='1'then
				RAMWriteData 	<= 	std_logic_vector(to_unsigned(0,32));
				RAMWriteAddress	<= 	std_logic_vector(to_unsigned(0,8));
				RAMReadAddress 	<= 	std_logic_vector(to_unsigned(0,8));
				RAMWriteEnable	<= 	'0';
				RegValue  		<=	std_logic_vector(to_unsigned(0,32));
				RegValue2 		<= 	std_logic_vector(to_unsigned(0,32));
			 	RegAddress 		<=	std_logic_vector(to_unsigned(0,5));
			 	RegAddress2 	<=	std_logic_vector(to_unsigned(0,5));
			 	outReg 			<=	'0';
			 	outSwap 		<=	'0';
			 	memoryIsReady 	<= 	'0';
			 	RAMHasValue		<= 	'0';
			else
				memoryIsReady <= '0';
				RAMWriteEnable 	<='0';
				if toLoad = '1' then
					RAMReadAddress 	<=StoreValue(7 downto 0);
					RAMHasValue		<='1';
					
				elsif toWrite = '1' then
					RAMHasValue		<='0';
					RAMWriteEnable 	<='1';
					
					RAMWriteAddress <=StoreValue2(7 downto 0);
					RAMWriteData 	<=StoreValue;
				elsif toReg ='1' then
					outReg 		<=	'1';
					RAMHasValue	<=	'0';
					RAMWriteEnable 	<='0';
				else
					outReg		<=	'0';
					RAMHasValue	<=	'0';
					
				end if ;
				memoryIsReady <= '1';
			end if ;
			outSwap 	<= 	toSwap;
			RegValue 	<=	StoreValue;
			RegAddress 	<=	StoreAddress;
			RegValue2	<=	StoreValue2;
			RegAddress2 <= 	StoreAddress2;

		end if ;
		RAMValue	<=	RAMReadData;

	end process ; -- 

end architecture ; 
