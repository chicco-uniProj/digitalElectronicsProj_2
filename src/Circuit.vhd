library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.costanti.all;

entity Circuit is
generic (nb:integer:=nbit);
Port ( A : in STD_LOGIC_VECTOR (nb-1 downto 0);
        B : in STD_LOGIC_VECTOR (nb-1 downto 0);
        C : in STD_LOGIC_VECTOR (nb-1 downto 0);
        D : in STD_LOGIC_VECTOR (nb-1 downto 0);
        Contr : in STD_LOGIC_VECTOR (1 downto 0);
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        Ris : out STD_LOGIC_VECTOR (nb+1 downto 0));
end Circuit;

architecture Behavioral of Circuit is
component Adder is
    generic (nb:integer);
    Port ( A,B : in STD_LOGIC_VECTOR (nb-1 downto 0);
            clk,clr : in STD_LOGIC;
            Sum : out STD_LOGIC_VECTOR (nb downto 0));
end component;

component Subtracter is
    generic (nb:integer);
    Port ( A,B : in STD_LOGIC_VECTOR (nb-1 downto 0);
            clk,clr : in STD_LOGIC;
            Sub : out STD_LOGIC_VECTOR (nb downto 0));
end component;

signal AB1,CD1,AB2,CD2,AB3,CD3,AB4,CD4: STD_LOGIC_VECTOR (nb downto 0);
signal ORis1,ORis2,ORis3,ORis4: STD_LOGIC_VECTOR (nb+1 downto 0);
signal RegRis: STD_LOGIC_VECTOR(nb+1 downto 0); 
begin

Add1: Adder generic map(nb) port map(A,B,clk,clr,AB1);
Add2: Adder generic map(nb) port map(C,D,clk,clr,CD1);
Add3: Adder generic map(nb+1) port map(AB1,CD1,clk,clr,ORis1);

Sub1: Subtracter generic map(nb) port map(A,B,clk,clr,AB2);
Sub2: Subtracter generic map(nb) port map(C,D,clk,clr,CD2);
Add4: Adder generic map(nb+1) port map(AB2,CD2,clk,clr,ORis2);

Add5: Adder generic map(nb) port map(A,B,clk,clr,AB3);
Sub3: Subtracter generic map(nb) port map(C,D,clk,clr,CD3);
Sub4: Subtracter generic map(nb+1) port map(AB3,CD3,clk,clr,ORis3);

Sub5: Subtracter generic map(nb) port map(A,B,clk,clr,AB4);
Add6: Adder generic map(nb) port map(C,D,clk,clr,CD4);
Sub6: Subtracter generic map(nb+1) port map(AB4,CD4,clk,clr,ORis4);
    
     RegRis<=ORis1 when Contr="00" else
             ORis2 when Contr="01" else
             ORis3 when Contr="10" else
             ORis4 when Contr="11" else
             (others=>'X');
    process(clk,clr)
    begin
    if(clr='1') then
        Ris<=(others=>'0');
    elsif(falling_edge(clk))then
        Ris<=RegRis;
    end if;
    end process;

end Behavioral;