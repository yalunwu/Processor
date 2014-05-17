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
	SW					:	in 	std_logic;
	TX 					:	out std_logic_vector(17 downto 0)

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
		signal		TXDataUART	:	std_logic_vector(31 downto 0)	;
		signal		RXDataUART	:	std_logic_vector(31 downto 0)	;
		signal		rdUART		:	std_logic 						;

		signal		rdyCntUART	:	unsigned(1 downto 0)			;

		signal		nrtsUART	:	std_logic 						;

		signal 		txCLK:			std_logic;
		signal 		rxCLK:			std_logic;
		signal		RXValue:		std_logic;
		type 		ArrayData		is array (31 downto 0 ) of std_logic_vector(31 downto 0);
		signal		GPR:			ArrayData;
		signal		flip:			std_logic_vector(2 downto 0);
		
begin
	process( clock,reset )
	begin
		if rising_edge(clock) then
			if reset = '1' then
				GPR 		<=	(others=> (others=>'0'));
			else
				if RequestUpdate = '1' then
					GPR(to_integer(unsigned(UpdateRegister))) <= UpdateRegValue;
				end if ;
				if RequestUpdate2 = '1' then
					GPR(to_integer(unsigned(UpdateRegister2))) <= UpdateRegValue2;
				end if ;


			end if ;


		end if ;
		
	end process ; -- identifier
	LED : process( clock,reset,SW )
	variable counter: integer := 0;
	variable checker: boolean := false;
	begin
		if rising_edge(clock) then
			if reset = '1' then
				TX <= GPR(0)(17 downto 0);
				counter :=0;
				checker :=false;
			else
				if checker = false and SW = '1' then
					--time to update value
					TX <= GPR(counter)(17 downto 0);
					counter := counter +1;
					if counter = 12 then
						counter := 0;
					end if ;
					checker := true;
				elsif SW = '0' then
					checker := false;
				end if ;

			end if ;
		end if ;
	end process ; -- LED


end architecture ; -- arch