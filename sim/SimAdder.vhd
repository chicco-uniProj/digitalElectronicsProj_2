library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.costanti.all;


entity SimAdder is
generic (nb:integer:=nbit);
end SimAdder;
architecture Behavioral of SimAdder is
component Adder is
Port ( A,B : in STD_LOGIC_VECTOR (nb-1 downto 0);
        clk,clr : in STD_LOGIC;
        Sum : out STD_LOGIC_VECTOR (nb downto 0));
end component;
signal IA, IB: STD_LOGIC_VECTOR (nb-1 downto 0);
signal Iclk, Iclr: STD_LOGIC:='0';
signal OSum: STD_LOGIC_VECTOR (nb downto 0);
constant Tclk: time:=10 ns;
begin
circ: Adder port map (IA,IB,Iclk,Iclr,OSum);
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
        IA<=(others=>'1');
        IB<=(others=>'1');
        wait for 10*Tclk;
        IB<=(others=>'0');
        wait for Tclk;
        --Iclr<='1';
    end process;
end Behavioral;