library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.costanti.all;


entity SimSubtracter is
generic (nb:integer:=nbit);
end SimSubtracter;
architecture Behavioral of SimSubtracter is
component Subtracter is
Port ( A,B : in STD_LOGIC_VECTOR (nb-1 downto 0);
        clk,clr : in STD_LOGIC;
        Sub : out STD_LOGIC_VECTOR (nb downto 0));
end component;
signal IA, IB: STD_LOGIC_VECTOR (nb-1 downto 0);
signal Iclk, Iclr: STD_LOGIC:='0';
signal OSub: STD_LOGIC_VECTOR (nb downto 0);
constant Tclk: time:=10 ns;
begin
    circ: Subtracter port map (IA,IB,Iclk,Iclr,OSub);
    process
    begin
    wait for Tclk/2;
    Iclk<=not Iclk;
    end process;
    process
    begin
        --t=0
        wait for 110ns; -- attesa per il global reset
        --wait until falling_edge(clk);
        IA<=(others=>'0');
        IB<=(others=>'1');
        wait for 10*Tclk;
        IB<=(others=>'0');
        wait for Tclk;
        --Iclr<='1';
    end process;
end Behavioral;