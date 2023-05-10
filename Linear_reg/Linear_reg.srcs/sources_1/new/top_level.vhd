----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 14:56:26
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( clk : in STD_LOGIC;
           testval_i : in STD_LOGIC_VECTOR (15 downto 0);
           testval_o : out STD_LOGIC_VECTOR (15 downto 0));
end top_level;

architecture Behavioral of top_level is

component Trainer is
    port (
        clk : in STD_LOGIC;
        done_o : out STD_LOGIC;
        w_o : out STD_LOGIC_VECTOR (15 downto 0);
        b_o : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    component Tester is
        Port ( 
            clk : in STD_LOGIC;
            w_i : in STD_LOGIC_VECTOR (15 downto 0);
            b_i : in STD_LOGIC_VECTOR (15 downto 0);
            ready_i : in STD_LOGIC;
            TestVal_i : in STD_LOGIC_VECTOR (15 downto 0);
            TestVal_o : out STD_LOGIC_VECTOR (15 downto 0);
            ready_o : out STD_LOGIC
            );
    end component;

    signal trainer_done : STD_LOGIC;
    signal tester_ready : STD_LOGIC;
    signal w : STD_LOGIC_vector(15 downto 0);
    signal b : STD_LOGIC_vector(15 downto 0);

begin

    LinRegTrain1: Trainer
    port map (
        clk => clk,
        done_o => trainer_done,
        w_o => w,
        b_o => b
    );

    LinRegTest1: Tester
        Port map ( 
            clk => clk,
            w_i => w,
            b_i => b,
            ready_i => trainer_done,
            TestVal_i => testval_i,
            TestVal_o => testval_o,
            ready_o => tester_ready
            );   

end Behavioral;
