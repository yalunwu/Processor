library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port (
		clock: 	in		std_logic;
		reset: 	in 		std_logic;
		TX:		out 	std_logic
		);
end entity ; -- top

architecture arch of top is

component fetch 
  port (
			clock: 				in 	std_logic;
			reset:	 			in 	std_logic;
			readIn:				in 	std_logic_vector(31 downto 0);

			Branched:			in  std_logic;
			BranchLocation:		in  std_logic_vector(31 downto 0);

			RequestFetch:		in 	std_logic;
			programCounter:		out std_logic_vector(31 downto 0);
			nextInstruction:	out std_logic_vector(31 downto 0)
  ) ;
end component;
component InstructionList 
 port (
	clock:			in std_logic;
	reset:			in std_logic;
	stopFlag:		in std_logic;
	programCounter:	in std_logic_vector(31 downto 0);
	readIn: 		out std_logic_vector(31 downto 0)
  ) ;
end component;


component decode 
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
end component;

component execute 
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
end component;

component memory 
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

	outReg				:	out std_logic;
	outSwap				:	out std_logic;
	memoryIsReady		:	out std_logic;
	RegAddress			:	out	std_logic_vector(4 downto 0);
	RegValue			:	out	std_logic_vector(31 downto 0);
	RegAddress2			:	out	std_logic_vector(4 downto 0);
	RegValue2			:	out	std_logic_vector(31 downto 0);

	RAMHasValue			:	out	std_logic;
	RAMValue			:	out	std_logic_vector(31 downto 0)
);
end component;

component writeBack 
  port (
	clock				: 	in 	std_logic;
	reset 				: 	in 	std_logic;
	
	toSwap				:	in	std_logic;
	toReg				:	in	std_logic;
	RegAddress			:	in	std_logic_vector(4 downto 0);
	RegValue			:	in	std_logic_vector(31 downto 0);
	RegAddress2			:	in	std_logic_vector(4 downto 0);
	RegValue2			:	in	std_logic_vector(31 downto 0);

	RAMHasValue			:	in	std_logic;
	RAMValue			:	in	std_logic_vector(31 downto 0);

	writebackIsReady	:	out	std_logic;
	requestUpdate		:	out	std_logic;
	requestUpdate2		:	out	std_logic;
	UpdateRegister		:	out	std_logic_vector(4 downto 0);
	UpdateRegValue		:	out	std_logic_vector(31 downto 0);
	UpdateRegister2		:	out	std_logic_vector(4 downto 0);
	UpdateRegValue2		:	out	std_logic_vector(31 downto 0)
  ) ;
end component;
component output
  port (
	clock:					in 	std_logic;
	reset:					in	std_logic;
	requestUpdate		:	in	std_logic;
	requestUpdate2		:	in	std_logic;
	UpdateRegister		:	in	std_logic_vector(4 downto 0);
	UpdateRegValue		:	in	std_logic_vector(31 downto 0);
	UpdateRegister2		:	in	std_logic_vector(4 downto 0);
	UpdateRegValue2		:	in	std_logic_vector(31 downto 0);
	TX:						out std_logic
  ) ;
end component;









	signal 	PC:		std_logic_vector(31 downto 0);
	signal 	RI: 	std_logic_vector(31 downto 0);
	signal 	FC:		std_logic;
	signal 	FullC:	std_logic;
	signal 	B:		std_logic;
	signal 	BL: 	std_logic_vector(31 downto 0);
	signal 	NI:		std_logic_vector(31 downto 0);
	signal 	FI:		std_logic_vector(31 downto 0);
	signal 	RU:		std_logic;
	signal 	RU2:	std_logic;
	signal 	UR1:	std_logic_vector(4 downto 0);
	signal 	UR2:	std_logic_vector(4 downto 0);
	signal	URV1: 	std_logic_vector(31 downto 0);
	signal	URV2:	std_logic_vector(31 downto 0);
	signal	RF:		std_logic;
	signal	ER:		std_logic;
	signal	mode:	std_logic_vector(4 downto 0);
	signal	OA1:	std_logic_vector(4 downto 0);
	signal	OA2:	std_logic_vector(4 downto 0);
	signal	V1:		std_logic_vector(31 downto 0);
	signal	V2:		std_logic_vector(31 downto 0);
	signal	V3:		std_logic_vector(31 downto 0);
	signal	MR:		std_logic;	
	signal	TR:		std_logic;
	signal	TW:		std_logic;
	signal	TL:		std_logic;
	signal	TS:		std_logic;
	signal	SA:		std_logic_vector(4 downto 0);
	signal	SA2:	std_logic_vector(4 downto 0);
	signal	SV:		std_logic_vector(31 downto 0);
	signal	SV2:	std_logic_vector(31 downto 0);
	signal	OREG:	std_logic;
	signal	OS:		std_logic;
	signal	RV:		std_logic_vector(31 downto 0);
	signal	RA:		std_logic_vector(4 downto 0);
	signal	RV2:	std_logic_vector(31 downto 0);
	signal	RA2:	std_logic_vector(4 downto 0);
	signal 	WR:		std_logic;
	signal 	RAMV:	std_logic_vector(31 downto 0);
	signal	RHV:	std_logic;

begin
	IL:InstructionList
	port map(
		clock=>clock,
		reset=>reset,
		stopFlag=>RF,
		programCounter => PC,
		readIn =>RI
		);
	F:fetch
	port map(
		clock 				=> clock,
		reset 				=> reset,
		readIn 				=>RI,
		Branched 			=> B,
		BranchLocation 		=> BL,
		RequestFetch		=>RF,
		programCounter 		=> PC,
		nextInstruction 	=>NI
		);

	D:decode
	port map (
		clock 				=> 	clock,
		reset 				=> 	reset,
		fetchedInstruction	=>	NI,

		RequestUpdate		=> 	RU,
		UpdateRegister		=> 	UR1,
		UpdateRegValue		=> 	URV1,
		RequestUpdate2		=>	RU2,
		UpdateRegister2		=>	UR2,
		UpdateRegValue2		=> 	URV2,

		RequestFetch		=>	RF,


		executeIsReady		=>	ER,
		mode				=>	mode,
		outputAddress		=> 	OA1,
		outputAddress2		=> 	OA2,
		value1 				=>	V1,
		value2				=>	V2,
		value3				=>	V3
		);
	 E: execute 
	  port map (
		clock				=>	clock, 	 	
		reset 				=> 	reset,

		mode				=>	mode,
		value1 				=>	V1,
		value2				=>	V2,
		value3				=>	V3,
		inAddress			=>	OA1,
	 	inAddress2			=>	OA2,

		memoryIsReady		=>	MR,
		executeIsReady		=>	ER,
		Branching			=>	B,	
		BranchingLocation	=>	BL,	


		toReg	 			=> 	TR,
		toWrite				=>	TW,
		toLoad				=>	TL,
		toSwap				=>	TS,	
		StoreAddress 		=>	SA, 
		StoreAddress2		=> 	SA2,	
		StoreValue 			=>	SV,
		StoreValue2 		=>	SV2	
	  ) ;
	  M:memory 
	  port map(
		clock				=> 	clock,
		reset 				=> 	reset,

		toReg	 			=>  TR,
		toWrite				=>  TW,
		toLoad				=> 	TL,
		toSwap				=> 	TS,
		StoreAddress 		=>  SA,
		StoreAddress2		=> 	SA2,
		StoreValue 			=>  SV,
		StoreValue2 		=> 	SV2,
		writebackIsReady	=>	WR,
		outReg				=>	OREG,
		outSwap				=>	OS,
		memoryIsReady		=>	MR,

		RAMHasValue			=>	RHV,
		RAMValue 			=>	RAMV,

		RegAddress			=>	RA,
		RegValue			=>	RV,
		RegAddress2			=>	RA2,
		RegValue2			=>	RV2
	);
	WB:writeBack 
	 port map (
		clock				=> 	clock,
		reset 				=> 	reset,
		
		toSwap				=>	OS,
		toReg				=>	OREG,
		RegAddress			=>	RA,
		RegValue			=>	RV,
		RegAddress2			=>	RA2,
		RegValue2			=>	RV2,

		RAMHasValue			=>	RHV,
		RAMValue 			=>	RAMV,
		writebackIsReady	=>	WR,
		requestUpdate		=>	RU,
		requestUpdate2		=>	RU2,
		UpdateRegister		=>	UR1,
		UpdateRegValue		=>	URV1,
		UpdateRegister2		=>	UR2,
		UpdateRegValue2		=>	URV2
	  ) ;
	o:output
	port map(
		clock				=>	clock,
		reset 				=>	reset,
		requestUpdate		=>	RU,
		requestUpdate2		=>	RU2,
		UpdateRegister		=>	UR1,
		UpdateRegValue		=>	URV1,
		UpdateRegister2		=>	UR2,
		UpdateRegValue2		=>	URV2,
		TX					=>	TX
  	) ;
	


end architecture ; -- arch