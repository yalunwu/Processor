library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output is
  port (
	clock:		in 	std_logic;
	reset:		in	std_logic;
	requestUpdate		:	in	std_logic;
	requestUpdate2		:	in	std_logic;
	UpdateRegister		:	in	std_logic_vector(4 downto 0);
	UpdateRegValue		:	in	std_logic_vector(31 downto 0);
	UpdateRegister2		:	in	std_logic_vector(4 downto 0);
	UpdateRegValue2		:	in	std_logic_vector(31 downto 0);
	TX:			out std_logic
  ) ;
end entity ; -- output

architecture arch of output is
component sc_uart
	generic (addr_bits : integer;
			 clk_freq : integer;
			 baud_rate : integer;
			 txf_depth : integer; txf_thres : integer;
			 rxf_depth : integer; rxf_thres : integer);
	port (
		clk		: in std_logic;
		reset	: in std_logic:='0';
		address		: in std_logic_vector(addr_bits-1 downto 0);
		wr_data		: in std_logic_vector(31 downto 0);
		rd, wr		: in std_logic;
		rd_data		: out std_logic_vector(31 downto 0);
		rdy_cnt		: out unsigned(1 downto 0);

		txd		: out std_logic;
		rxd		: in std_logic;
		ncts	: in std_logic;
		nrts	: out std_logic;
		TXCLK 	: out std_logic;
		RXCLK 	: out std_logic
		);
end component;
		signal		TXDataUART	:	std_logic_vector(31 downto 0)	:=std_logic_vector(to_unsigned(0,32));
		signal		RXDataUART	:	std_logic_vector(31 downto 0)	;
		signal		rdUART		:	std_logic 						;
		signal		wrUART		:	std_logic 						:='0';
		signal		rdyCntUART	:	unsigned(1 downto 0)			;
		signal		txdUART		:	std_logic 						;
		signal		rxdUART		:	std_logic 						;
		signal		nctsUART	:	std_logic 						;
		signal		nrtsUART	:	std_logic 						;
		signal		resetUART	:	std_logic   					:='0';
		signal 		txCLK:			std_logic;
		signal 		rxCLK:			std_logic;
		signal		RXValue:		std_logic;
		type 		ArrayData			is array (31 downto 0 ) of std_logic_vector(31 downto 0);
		signal		GPR:	ArrayData;
begin
	serial:sc_uart 
	generic map (
		addr_bits => 2,
		clk_freq => 50000000,
		baud_rate => 115200,
		txf_depth => 32,
		txf_thres => 32,
		rxf_depth => 32, 
		rxf_thres => 32
		)
	port map (
		clk			=> 	clock,
		reset		=> 	reset,
		address		=>	"01",
		wr_data		=>	TXDataUART,
		rd          =>	rdUART, 
		wr          =>	'1', 
		rd_data		=>	RXDataUART,
		rdy_cnt		=> 	rdyCntUART,

		txd			=> 	TX,
		rxd			=> 	'0',
		ncts		=> 	'0',
		nrts		=>	nrtsUART,
		TXCLK  		=> 	txCLK,
		RXCLK		=> 	rxCLK
		);
	process( clock,reset )
	begin
		if rising_edge(clock) then
			if reset ='1' then
				GPR 		<=	(others=> (others=>'0'));
			else
				if requestUpdate = '1' then
					GPR(to_integer(unsigned(UpdateRegister))) <= UpdateRegValue;
				end if ;
				if requestUpdate2 = '1' then
					GPR(to_integer(unsigned(UpdateRegister2))) <= UpdateRegValue2;
				end if ;		
			end if ;
		end if ;
	end process ;

	process(txCLK)
	variable sendData : boolean := false;
	variable counter  :	integer := 0;
	begin

		if rising_edge(txCLK) then
			if(sendData = true) then
				TXDataUART 	<= GPR(counter);
				counter :=counter + 1;
				sendData :=false;
			else
				sendData :=true;
				TXDataUART	<= std_logic_vector(to_unsigned(counter,32));
			end if;
			if counter>31 then
				counter :=0;
			end if ;
		end if;	
	end process;


end architecture ; -- arch