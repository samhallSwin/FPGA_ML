----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 14:56:26
-- Design Name: 
-- Module Name: Tester - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Tester is
    Port ( clk : in STD_LOGIC;
           w_i : in STD_LOGIC_VECTOR (15 downto 0);
           b_i : in STD_LOGIC_VECTOR (15 downto 0);
           ready_i : in STD_LOGIC;
           TestVal_i : in STD_LOGIC_VECTOR (15 downto 0);
           TestVal_o : out STD_LOGIC_VECTOR (15 downto 0);
           ready_o : out STD_LOGIC);
end Tester;

architecture Behavioral of Tester is

begin


end Behavioral;
