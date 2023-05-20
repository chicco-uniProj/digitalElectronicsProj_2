library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.costanti.all;
entity Subtracter is
generic (nb:integer:=nbit);
Port ( A,B : in STD_LOGIC_VECTOR (nb-1 downto 0);
        clk,clr : in STD_LOGIC;
        Sub : out STD_LOGIC_VECTOR (nb downto 0));
end Subtracter;
architecture Behavioral of Subtracter is
signal RA, RB: STD_LOGIC_VECTOR (nb-1 downto 0);
signal p,g: STD_LOGIC_VECTOR (nb downto 0);
signal c: STD_LOGIC_VECTOR (nb+1 downto 0);
begin
    process(clk,clr)
    begin
    if(clr='1')then
    RA<=(others=>'0'); RB<=(others=>'0');
    elsif(falling_edge(clk)) then
    RA<=A; RB<=B; 
    end if;
    end process;
c(0)<='1';
p<=(RA(nb-1)xor not RB(nb-1))& (RA xor not RB);
g<=(RA(nb-1)and not RB(nb-1))& (RA and not RB);
c(nb+1 downto 1)<= g or (p and c(nb downto 0));
Sub<=p xor c(nb downto 0);
end Behavioral;