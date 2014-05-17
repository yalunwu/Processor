library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sdpram is
generic (width : integer := 32; addr_width : integer := 7);
port (
        wrclk           : in std_logic;
        reset           : in std_logic;
        data            : in std_logic_vector(width-1 downto 0);
        wraddress       : in std_logic_vector(addr_width-1 downto 0);
        wren            : in std_logic;

        rdclk           : in std_logic;
        rdaddress       : in std_logic_vector(addr_width-1 downto 0);
        dout            : out std_logic_vector(width-1 downto 0)
);
end sdpram ;

architecture rtl of sdpram is

        signal reg_dout                 : std_logic_vector(width-1 downto 0);

        subtype word is std_logic_vector(width-1 downto 0);
        constant nwords : integer := 2 ** addr_width;
        type ram_type is array(0 to nwords-1) of word;

        signal ram : ram_type;

begin

process (wrclk)
begin
        if rising_edge(wrclk) then

                if wren='1' then
                        ram(to_integer(unsigned(wraddress))) <= data;
                end if;
        end if;
end process;

process (rdclk)
begin
        if rising_edge(rdclk) then
                reg_dout <= ram(to_integer(unsigned(rdaddress)));
                dout <= reg_dout;
        end if;
end process;

end rtl;