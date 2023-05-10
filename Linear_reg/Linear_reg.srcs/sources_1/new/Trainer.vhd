----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 14:56:26
-- Design Name: 
-- Module Name: Trainer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Trainer is
    Port ( clk : in STD_LOGIC;
           done_o : out STD_LOGIC;
           w_o : out STD_LOGIC_VECTOR (15 downto 0);
           b_o : out STD_LOGIC_VECTOR (15 downto 0));
end Trainer;

architecture Behavioral of Trainer is

    type StateType is (init, getCost, compareCost, done);
    signal current_state : StateType:= init;

    type ram_type is array (0 to 31) of signed(15 downto 0);
    signal RAM : ram_type :=
    (
        X"FC18", X"1C20", X"5C28", X"9C30", X"DC38", X"1C40", 
        X"5C48", X"9C50", X"DC58", X"1C60", X"5C68", X"9C70", 
        X"DC78", X"1C80", X"5C88", X"9C90", X"DC98", X"1CA0", 
        X"5CA8", X"9CB0", X"DCB8", X"1CC0", X"5CC8", X"9CD0", 
        X"DCD8", X"1CE0", X"5CE8", X"9CF0", X"DCF8", X"1D00", 
        X"5D08", X"9D10"
    );

    signal initVal : signed(15 downto 0) := X"00FF";
    signal alpha : signed(16 downto 0) := X"000F";
    signal w_temp : signed(16 downto 0);
    signal b_temp : signed(16 downto 0);
    signal b_grad : signed(16 downto 0);
    signal w_grad : signed(16 downto 0);
    signal cost : signed(32 downto 0):=(others=>'1');
    signal prev_cost : signed(32 downto 0):=(others=>'1');
    signal iters : signed(15 downto 0):=X"0764";

begin

    process(clk) begin
        if rising_edge(clk) then

            case current_state is
                when init =>
                    w_temp <= initVal;
                    b_temp <= initVal;
                    current_state <= getCost;
                when getCost =>
                    --Get total cost
                    for i in 0 to 31 loop
                        cost <=  cost + ((w_temp*i + b_temp - RAM(i))*(w_temp*i + b_temp - RAM(i)));
                    end loop;
                    current_state <= compareCost;  

                    for i in 0 to 31 loop
                        w_grad <= w_grad + ((w_temp*i + b_temp - RAM(i))*i);
                    end loop;

                    for i in 0 to 31 loop
                        b_grad <= b_grad + ((w_temp*i + b_temp)-RAM(i));
                    end loop;           

                when compareCost =>
                    if (cost < prev_cost) then
                        w_o <= std_logic_vector(w_temp);
                        b_o <= std_logic_vector(w_temp);                        
                    end if;

                    w_temp <= w_temp -alpha*w_grad(15 downto 4);
                    b_temp <= b_temp -alpha*b_grad(15 downto 4);
                    
                    iters <= iters - 1;
                    if (iters < 0) then
                        current_state <= getCost;
                    else
                        current_state <= done;
                    end if;
                
                when done =>
                    done_o <= '1';
            end case;

        end if;
    end process;    

end Behavioral;
