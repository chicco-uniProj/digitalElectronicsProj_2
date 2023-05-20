library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
library work;
use work.costanti.all;

entity SimCircuit is
generic (nb:integer:=nbit);
end SimCircuit;
architecture Behavioral of SimCircuit is
component Circuit is
Port ( A : in STD_LOGIC_VECTOR (nb-1 downto 0);
        B : in STD_LOGIC_VECTOR (nb-1 downto 0);
        C : in STD_LOGIC_VECTOR (nb-1 downto 0);
        D : in STD_LOGIC_VECTOR (nb-1 downto 0);
        Contr : in STD_LOGIC_VECTOR (1 downto 0);
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        Ris : out STD_LOGIC_VECTOR (nb+1 downto 0));
        
end component;
signal IA, IB,IC,ID: STD_LOGIC_VECTOR (nb-1 downto 0);
signal Iclk: STD_LOGIC:='1';
signal Iclr: STD_LOGIC:='0';
signal IContr: STD_LOGIC_VECTOR (1 downto 0);
signal ORis: STD_LOGIC_VECTOR (nb+1 downto 0);
constant Tclk: time:=10 ns;
begin
    circ: Circuit port map (IA,IB,IC,ID,IContr,Iclk,Iclr,ORis);
    process
    begin
        wait for Tclk/2;
        Iclk<=not Iclk;
    end process;
    process
    begin
        wait for 100ns; -- attesa per il global reset
        wait until falling_edge(Iclk);
        wait for Tclk;
        IContr<="00";
        for va in -(2**(4)) to (2**(4)-1) loop
            IA<=conv_std_logic_vector(va,nb);
            IB<=conv_std_logic_vector(va,nb);
         --   Iclr<=not Iclr;
            for vb in -(2**(4)) to (2**(4)-1) loop
                IC<=conv_std_logic_vector(vb,nb);
                ID<=conv_std_logic_vector(vb,nb);
                wait for Tclk;
            end loop;
            IContr<="10";
        end loop;
    end process;
end Behavioral;

