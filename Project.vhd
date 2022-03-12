library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
    port (  i_clk : in STD_LOGIC;
            i_rst : in STD_LOGIC;
            i_start : in STD_LOGIC;
            i_data : in STD_LOGIC_VECTOR( 7 downto 0);
            o_address : out STD_LOGIC_VECTOR( 15 downto 0);
            o_done : out STD_LOGIC;
            o_en : out STD_LOGIC;
            o_we : out STD_LOGIC;
            o_data : out STD_LOGIC_VECTOR( 7 downto 0)
            );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is 
component datapath is 
    Port (  i_clk : in STD_LOGIC;
            i_rst : in STD_LOGIC;
            i_start : in STD_LOGIC;
            i_data : in STD_LOGIC_VECTOR( 7 downto 0);
            o_address : out STD_LOGIC_VECTOR( 15 downto 0);
            o_data : out STD_LOGIC_VECTOR(7 downto  0);
            sel_0 : in STD_LOGIC;
            sel_1 : in STD_LOGIC;
            sel_2 : in STD_LOGIC;
            sel_3 : in STD_LOGIC;
            sel_4 : in STD_LOGIC;
            sel_5 : in STD_LOGIC;
            sel_6 : in STD_LOGIC;
            dec_shifting_sel : in STD_LOGIC;
            shifted_sel : in STD_LOGIC;
            addr_load : in STD_LOGIC;
            col_load : in STD_LOGIC;
            CxR_load :in STD_LOGIC;
            count_load : in STD_LOGIC;
            rig_load : in STD_LOGIC;
            decount_load :in STD_LOGIC;
            max_load : in STD_LOGIC;
            min_load : in STD_LOGIC;         
            shifted_load : in STD_LOGIC;
            shifting_load : in STD_LOGIC;
            o_product : out STD_LOGIC;
            o_end : out STD_LOGIC;
            o_col_case0 : out STD_LOGIC;
            o_rig_case0 : out STD_LOGIC;
            o_shifting : out STD_LOGIC;
            o_no_shift : out STD_LOGIC);
end component;

signal sel_0 : STD_LOGIC;
signal sel_1 : STD_LOGIC;
signal sel_2 : STD_LOGIC;
signal sel_3 : STD_LOGIC;
signal sel_4 : STD_LOGIC;
signal sel_5 : STD_LOGIC;
signal sel_6 : STD_LOGIC;
signal dec_shifting_sel : STD_LOGIC;
signal shifted_sel : STD_LOGIC;
signal addr_load : STD_LOGIC;
signal col_load : STD_LOGIC;
signal CxR_load : STD_LOGIC;
signal count_load : STD_LOGIC;
signal rig_load : STD_LOGIC;
signal decount_load : STD_LOGIC;
signal max_load : STD_LOGIC;
signal min_load : STD_LOGIC;
signal min_sel : STD_LOGIC;
signal max_sel : STD_LOGIC;
signal min_sel_2 : STD_LOGIC;
signal shifting_load : STD_LOGIC;
signal shifted_load : STD_LOGIC;
signal o_end : STD_LOGIC;
signal o_col_case0 : STD_LOGIC;
signal o_rig_case0 : STD_LOGIC;
signal o_product : STD_LOGIC;
signal o_shifting : STD_LOGIC;
signal o_no_shift : STD_LOGIC;
type S is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17);
signal curr_state, next_state : S;
begin 
    DATAPATH0: datapath port map(
        i_clk,
        i_rst,
        i_start,
        i_data,
        o_address,
        o_data,
        sel_0,
        sel_1,
        sel_2,
        sel_3,
        sel_4,
        sel_5,
        sel_6,
        dec_shifting_sel,
        shifted_sel,
        addr_load,
        col_load,
        CxR_load,
        count_load,
        rig_load,
        decount_load,
        max_load,
        min_load,
        shifted_load,
        shifting_load,
        o_product,
        o_end,
        o_col_case0,
        o_rig_case0,
        o_shifting,
        o_no_shift);
        
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then 
            curr_state <= S0;
        elsif i_clk'event and i_clk = '1' then 
            curr_state <= next_state;
        end if;
    end process;
        
    process(curr_state, i_start, o_col_case0, o_rig_case0, o_product, o_end, o_shifting, o_no_shift)
    begin
        next_state <= curr_state;
        case curr_state is 
            when S0 => 
                if i_start = '1' then
                    next_state <= S1;
                end if;
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S3;
            when S3 =>
                next_state <= S4;
            when S4 =>
                next_state <= S5;   
            when S5 =>
                if o_col_case0 = '1' then
                    next_state <= S17;
                else
                    next_state <= S6;   
                end if;
            when S6 =>
                if o_rig_case0 = '1' then
                    next_state <= S17;
                elsif o_product = '1' then
                    next_state <= S7;
                else
                    next_state <= S6;
                end if;
            when S7 =>
                next_state <= S8;
            when S8 =>
                next_state <= S9;
            when S9 =>
                if o_end = '1' then
                    next_state <= S10;
                else
                    next_state <= S9;
                end if;
            when S10 =>
                next_state <= S11;
            when S11 =>
                next_state <= S12;
            when S12 =>
                next_state <= S13; 
            when S13 =>
                next_state <= S14;   
            when S14 =>
                if o_no_shift = '1' then
                    next_state <= S16; 
                else 
                    next_state <= S15;
                end if;
            when S15 =>
                if o_shifting = '1' then
                    next_state <= S16;
                else 
                    next_state <= S15;
                end if;
            when S16 =>
                if o_end = '1' then
                    next_state <= S17;
                else
                    next_state <= S12;
                end if; 
            when S17 =>
                if i_start = '1' then
                    next_state <= S17;
                else 
                    next_state <= S0;
                end if;  
            when others =>
        end case;
    end process;
          
    process(curr_state)
    begin
        sel_0 <= '0';
        sel_1 <= '0';
        sel_2 <= '0';
        sel_3 <= '0';
        sel_4 <= '0';
        sel_5 <= '0';
        sel_6 <= '0';
        dec_shifting_sel <= '0';
        shifted_sel <= '0'; 
        addr_load <= '0';
        col_load <= '0';
        CxR_load <= '0';
        count_load <= '0';
        rig_load <= '0';
        decount_load <= '0';
        max_load <= '0';
        min_load <= '0';
        shifting_load <= '0';
        shifted_load <= '0';
        o_en <= '0';
        o_we <= '0';
        o_done <= '0';
        case curr_state is 
            when S0 =>
            when S1 =>
                addr_load <= '1'; 
                max_load <= '1';
                min_load <= '1';
            when S2 =>
                o_en <= '1';
                sel_0 <= '1';
                addr_load <= '1';
                CxR_load <= '1';
            when S3 =>
                o_en <= '1';
                sel_0 <= '1';
                addr_load <= '1';
                col_load <= '1';
                CxR_load <= '1';
            when S4 =>
                sel_0 <= '1';
                CxR_load <= '1';
                rig_load <= '1';
            when S5 =>
                sel_0 <= '1';
                CxR_load <= '1';
                decount_load <= '1';
            when S6 =>
                sel_0 <= '1';
                CxR_load <= '1';
                sel_2 <= '1';
                sel_3 <= '1';
                decount_load <= '1';     
            when S7 =>
                sel_0 <= '1';
                count_load <= '1';
                o_en <= '1';
            when S8 =>
                sel_0 <= '1';
            when S9 =>
                sel_0 <= '1';
                addr_load <= '1';
                o_en <= '1';
                count_load <= '1';
                sel_4 <= '1';
                sel_5 <= '1';
                sel_6 <= '1';
                min_load <= '1';
                max_load <= '1';
            when S10 =>
                addr_load <= '1';
                sel_4 <= '1';
                sel_5 <= '1';
                sel_6 <= '1';
                min_load <= '1';
                max_load <= '1';           
            when S11 =>
                addr_load <= '1';
                sel_0 <= '1';
                count_load <= '1';
            when S12 =>
                addr_load <= '1';
                sel_0 <= '1';
            when S13 =>
                sel_0 <= '1';
                o_en <= '1';                
                shifting_load <= '1';          
            when S14 =>
                sel_0 <= '1';
                shifted_load <= '1'; 
            when S15 =>
                shifted_load <= '1';
                dec_shifting_sel <= '1';
                shifted_sel <= '1';
                shifting_load <= '1';
            when S16 =>
                sel_1 <= '1';
                o_en <= '1';
                o_we <= '1';
                sel_4 <= '1';
                count_load <= '1';
            when S17 =>
                o_done <= '1';      
            when others =>                 
        end case;            
    end process;
    
end Behavioral;

--datapath--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is 
    Port (  i_clk : in STD_LOGIC;
            i_rst : in STD_LOGIC;
            i_start : in STD_LOGIC;
            i_data : in STD_LOGIC_VECTOR( 7 downto 0);
            o_address : out STD_LOGIC_VECTOR (15 downto 0);
            o_data : out STD_LOGIC_VECTOR(7 downto  0); 
            sel_0 : in STD_LOGIC;
            sel_1 : in STD_LOGIC;
            sel_2 : in STD_LOGIC;
            sel_3 : in STD_LOGIC;
            sel_4 : in STD_LOGIC;
            sel_5 : in STD_LOGIC;
            sel_6 : in STD_LOGIC;
            dec_shifting_sel : in STD_LOGIC;
            shifted_sel : in STD_LOGIC;
            addr_load : in STD_LOGIC;
            col_load : in STD_LOGIC;
            CxR_load :in STD_LOGIC;
            count_load : in STD_LOGIC;
            rig_load : in STD_LOGIC;
            decount_load :in STD_LOGIC;
            max_load : in STD_LOGIC;
            min_load : in STD_LOGIC;
            shifting_load : in STD_LOGIC;
            shifted_load : in STD_LOGIC;
            o_product : out STD_LOGIC;
            o_end : out STD_LOGIC;
            o_col_case0 : out STD_LOGIC;
            o_rig_case0 : out STD_LOGIC;
            o_shifting : out STD_LOGIC;
            o_no_shift : out STD_LOGIC);
            
end datapath;            
            
architecture Behavioral of datapath is 
signal o_addr_reg : STD_LOGIC_VECTOR (15 downto 0);      
signal o_col_reg : STD_LOGIC_VECTOR (7 downto 0);            
signal o_CxR_reg : STD_LOGIC_VECTOR (15 downto 0); 
signal o_rig_reg : STD_LOGIC_VECTOR (7 downto 0);           
signal o_count_reg : STD_LOGIC_VECTOR (15 downto 0);
signal o_decount_reg : STD_LOGIC_VECTOR (7 downto 0); 
signal o_max_reg : STD_LOGIC_VECTOR (7 downto 0);
signal o_min_reg : STD_LOGIC_VECTOR (7 downto 0);
signal o_shifting_reg : STD_LOGIC_VECTOR (7 downto 0); 
signal o_shifted_reg : STD_LOGIC_VECTOR (15 downto 0);          
signal o_floor :STD_LOGIC_VECTOR (7 downto 0);
signal addr_sum : STD_LOGIC_VECTOR (15 downto 0);
signal write_addr_sum : STD_LOGIC_VECTOR (15 downto 0);
signal prod_sum : STD_LOGIC_VECTOR (15 downto 0);
signal d_value_sum : STD_LOGIC_VECTOR (15 downto 0);
signal max_min_sub : STD_LOGIC_VECTOR (7 downto 0);
signal sub_count : STD_LOGIC_VECTOR (15 downto 0);
signal sub_decount : STD_LOGIC_VECTOR (7 downto 0);
signal temp_sub : STD_LOGIC_VECTOR (15 downto 0);
signal floor_sub : STD_LOGIC_VECTOR (7 downto 0); 
signal shifting_sub : STD_LOGIC_VECTOR (7 downto 0); 
signal mux_addr_reg : STD_LOGIC_VECTOR (15 downto 0);
signal mux_o_addr : STD_LOGIC_VECTOR (15 downto 0);
signal mux_CxR_reg : STD_LOGIC_VECTOR (15 downto 0);
signal mux_count_reg : STD_LOGIC_VECTOR (15 downto 0);
signal mux_decount_reg : STD_LOGIC_VECTOR (7 downto 0);
signal mux_dec_shifting : STD_LOGIC_VECTOR (7 downto 0);
signal mux_shifted : STD_LOGIC_VECTOR (15 downto 0);
signal mux_min : STD_LOGIC_VECTOR (7 downto 0);
signal mux_max : STD_LOGIC_VECTOR (7 downto 0);
signal mux_max_reg : STD_LOGIC_VECTOR (7 downto 0);
signal mux_min_reg : STD_LOGIC_VECTOR (7 downto 0);
signal shifted : STD_LOGIC_VECTOR (15 downto 0);
signal min_sel : STD_LOGIC;
signal max_sel : STD_LOGIC;
signal min_sel_2 : STD_LOGIC;   

begin

    --registri--
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_addr_reg <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(addr_load = '1') then
                o_addr_reg <= mux_addr_reg;
            end if;
        end if;
    end process;
    
     process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_col_reg <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(col_load = '1') then 
                o_col_reg <= i_data;
            end if;
        end if;
    end process;
        
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_rig_reg <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(rig_load = '1') then
                o_rig_reg <= i_data;
            end if;
        end if;
    end process; 
    
     process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_CxR_reg <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(CxR_load = '1') then 
                o_CxR_reg <= mux_CxR_reg;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_decount_reg <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(decount_load = '1') then
                o_decount_reg <= mux_decount_reg;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_count_reg <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(count_load = '1') then
                o_count_reg <= mux_count_reg;
            end if;
        end if;
    end process;  
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_max_reg <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if( max_load = '1') then
                o_max_reg <= mux_max_reg;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_min_reg <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(min_load = '1') then
                o_min_reg <= mux_min_reg;
            end if;
        end if;
    end process; 
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_shifting_reg <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(shifting_load = '1') then
                 o_shifting_reg <= mux_dec_shifting;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_shifted_reg <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(shifted_load = '1') then
                 o_shifted_reg <= mux_shifted;
            end if;
        end if;
    end process;
    
    --mux--
    
    with sel_0 select
        mux_addr_reg <= "0000000000000000" when '0',
                        addr_sum when '1',
                        "XXXXXXXXXXXXXXXX" when others;
                          
    with sel_1 select
        mux_o_addr <= o_addr_reg when '0',
                      write_addr_sum when '1',
                      "XXXXXXXXXXXXXXXX" when others;
                      
    with sel_2 select
        mux_CxR_reg <= "0000000000000000" when '0',
                      prod_sum when '1',
                      "XXXXXXXXXXXXXXXX" when others;                                      
                      
    with sel_3 select
        mux_decount_reg <= o_rig_reg when '0',
                         sub_decount when '1',
                         "XXXXXXXX" when others;
                      
    with sel_4 select
        mux_count_reg <= o_CxR_reg when '0',
                         sub_count when '1',
                         "XXXXXXXXXXXXXXXX" when others;                 
                      
    with sel_5 select
        mux_max_reg <= "00000000" when '0',
                       mux_max when '1',
                       "XXXXXXXX" when others;                  
    
    with sel_6 select
        mux_min_reg <= "11111111" when '0',
                       mux_min when '1',
                       "XXXXXXXX" when others;
                         
    with max_sel select
        mux_max <= o_max_reg when '0',
                   i_data when '1',
                   "XXXXXXXX" when others;
    
    with min_sel select
        mux_min <= o_min_reg when '0',
                   i_data when '1',
                   "XXXXXXXX" when others;                    
    
    with min_sel_2 select
        o_data <= "11111111" when '0',
                   o_shifted_reg(7 downto 0) when '1',
                   "XXXXXXXX" when others;
                   
    with dec_shifting_sel select
        mux_dec_shifting <= floor_sub when '0',
                            shifting_sub when '1',
                            "XXXXXXXX" when others;
                    
    with shifted_sel select
        mux_shifted <= temp_sub when '0',
                       (o_shifted_reg(14 downto 0) & '0') when '1',
                       "XXXXXXXXXXXXXXXX" when others;
     
    --sommatori-- 
         
    addr_sum <= "0000000000000001" + o_addr_reg;        
    write_addr_sum <=  o_addr_reg + o_CxR_reg;   
    prod_sum <= ("00000000" & o_col_reg) + o_CxR_reg;   
    d_value_sum <= "0000000000000001" + max_min_sub;
    
    --sottrattori--
    
    sub_count <= o_count_reg - "0000000000000001";   
    sub_decount <= o_decount_reg - "00000001";   
    max_min_sub <= o_max_reg - o_min_reg;   
    floor_sub <= "00001000" - o_floor;  
    shifting_sub <= o_shifting_reg - "00000001" ;
    temp_sub <= "00000000" & (i_data - o_min_reg);
    
    --segnali--
    
    max_sel <= '1' when i_data > o_max_reg else '0'; 
    min_sel <= '1' when i_data < o_min_reg else '0';    
    min_sel_2 <= '1' when o_shifted_reg < "0000000011111111" else '0'; 
    o_col_case0 <= '1' when o_col_reg = "00000000" else '0'; 
    o_rig_case0 <= '1' when o_rig_reg = "00000000" else '0';
    o_end <= '1' when o_count_reg = "00000001" else '0';
    o_product <= '1' when o_decount_reg = "00000001" else '0';
    o_address <= mux_o_addr;
    o_shifting <= '1' when o_shifting_reg = "00000001" else '0'; 
    o_no_shift <= '1' when floor_sub = "00000000" else '0';
    
    --floor_log2--
    
    o_floor <= "00000000" when d_value_sum = "0000000000000001" else
               "00000001" when d_value_sum < "0000000000000100" else
               "00000010" when d_value_sum < "0000000000001000" else
               "00000011" when d_value_sum < "0000000000010000" else
               "00000100" when d_value_sum < "0000000000100000" else
               "00000101" when d_value_sum < "0000000001000000" else
               "00000110" when d_value_sum < "0000000010000000" else
               "00000111" when d_value_sum < "0000000100000000" else
               "00001000";
                    
end Behavioral;                    