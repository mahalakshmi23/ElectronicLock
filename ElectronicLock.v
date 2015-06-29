`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University at Buffalo
// Engineer: Mahalakshmi Venkataraman
// 
// Create Date:   12:34:32 06/20/2015 
// Design Name: 	CSE 590 Proj 2
// Module Name:   project2 
// Project Name:  project 2
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module project2(
input [5:0] switches,
input [3:0] pushbtns,
input clk,
output [3:0] anodes,
output [6:0] cathodes,
output [7:0] led
);

reg [7:0] temp_led=8'b00000000; 
reg [3:0] temp_anode = 4'b1111;
reg [6:0] temp_cathode=7'b1111111;

reg [6:0] ssd_1=7'b1111111;
reg [6:0] ssd_2=7'b1111111;
reg [6:0] ssd_3=7'b1111111;
reg [6:0] ssd_4=7'b1111111;

reg [6:0] final_ssd=7'b1111111;

integer firsttry=0;
integer secondtry=0;
integer counter=0;
integer ledcount=0;
integer temp,temp1;
integer pause_timer = 0;
integer clk_count = 0;
integer status = 0; 
integer timer=0;
integer firstpress=0;

reg slow_clk;

always @ (posedge clk) 
begin	
	if(clk_count> 100000) //slowing down 50MHz to 500Hz
	begin 
		clk_count = 0; 
		slow_clk = ~slow_clk; 
	end
	clk_count = clk_count + 1;
end
 
always @ (posedge slow_clk) begin

	counter=(counter+1)%4;	
		
	if(switches[3:0]==4'b0000) begin temp_led = 8'b00000000; temp_cathode = 7'b1000000; end
	else if(switches[3:0]==4'b0001) begin temp_led = 8'b00000001; temp_cathode = 7'b1111001; end
	else if(switches[3:0]==4'b0010) begin temp_led = 8'b00000010; temp_cathode = 7'b0100100; end
	else if(switches[3:0]==4'b0011) begin temp_led = 8'b00000011; temp_cathode = 7'b0110000; end
	else if(switches[3:0]==4'b0100) begin temp_led = 8'b00000100; temp_cathode = 7'b0011001; end
	else if(switches[3:0]==4'b0101) begin temp_led = 8'b00000101; temp_cathode = 7'b0010010; end
	else if(switches[3:0]==4'b0110) begin temp_led = 8'b00000110; temp_cathode = 7'b0000010; end
	else if(switches[3:0]== 4'b0111) begin temp_led = 8'b00000111; temp_cathode = 7'b1111000; end
	else if(switches[3:0]== 4'b1000) begin temp_led = 8'b00001000; temp_cathode = 7'b0000000; end
	else if(switches[3:0]== 4'b1001) begin temp_led = 8'b00001001; temp_cathode = 7'b0010000; end
	else if(switches[3:0]== 4'b1010) begin temp_led = 8'b00001010; temp_cathode = 7'b0001000; end
	else if(switches[3:0]== 4'b1011) begin temp_led = 8'b00001011; temp_cathode = 7'b0000011; end
	else if(switches[3:0]== 4'b1100) begin temp_led = 8'b00001100; temp_cathode = 7'b1000110; end
	else if(switches[3:0]== 4'b1101) begin temp_led = 8'b00001101; temp_cathode = 7'b0100001; end
	else if(switches[3:0]== 4'b1110) begin temp_led = 8'b00001110; temp_cathode = 7'b0000110; end
	else if(switches[3:0]== 4'b1111) begin temp_led = 8'b00001111; temp_cathode = 7'b0001110; end	
	else begin temp_led = 8'b00000000; temp_cathode = 7'b1111111; end
	
	case(pushbtns)
		4'b0001: begin ssd_1 = temp_cathode; firstpress=1; end
		4'b0010: begin ssd_2 = temp_cathode; firstpress=1; end
		4'b0100: begin ssd_3 = temp_cathode; firstpress=1; end
		4'b1000: begin ssd_4 = temp_cathode; firstpress=1; end
	endcase
	
	if(firstpress==1) 
		timer=timer+1;
	else
		timer=0;
	
	case(counter)   
		0: begin temp_anode = 4'b0111; final_ssd = ssd_1; end   
		1: begin temp_anode = 4'b1011; final_ssd = ssd_2; end    
		2: begin temp_anode = 4'b1101; final_ssd = ssd_3; end   
		3: begin temp_anode = 4'b1110; final_ssd = ssd_4; end 
	endcase
	
	if(status == 0)
	begin		
		if(timer < 7500)
		begin
			if(switches[4] == 1)
				temp=1;
	
			if(switches[4]==0 && temp==1)
				temp=2;
				
			if(temp==2)
			begin				
				if(ssd_1 == 7'b0010010 && ssd_2 == 7'b0000000 && ssd_3 == 7'b0100100 && ssd_4 == 7'b0010010) //Unlock Code 5285
				begin
					temp_led=8'b11111111;
					status = 1;
					ledcount=0;
					pause_timer=0;
					firstpress=0;
					timer=0;
					temp=0;
					temp1=0;
					firsttry=0;
					secondtry=0;					
					temp_anode = 4'b1111;
					temp_cathode=7'b1111111;
					ssd_1=7'b1111111;
					ssd_2=7'b1111111;
					ssd_3=7'b1111111;
					ssd_4=7'b1111111;
					final_ssd=7'b1111111;
					
				end
				else
				begin
					firstpress=0;
					temp=0;
					temp1=0;
					status=0;
					pause_timer=0;
					timer=0;
					temp_anode = 4'b1111;
					temp_cathode=7'b1111111;
					ssd_1=7'b1111111;
					ssd_2=7'b1111111;
					ssd_3=7'b1111111;
					ssd_4=7'b1111111;
					final_ssd=7'b1111111;
					
					if(firsttry==0)
					begin
						firsttry=1;
						secondtry=0;						
					end
					else if(firsttry==1)
					begin
						secondtry=1;
						firsttry=2;						
					end
						
					if(secondtry==1)
					begin
						status = 2;
						firstpress=0;
						pause_timer=0;
						timer=0;
						temp=0; 
						temp1=0;
						firsttry=0;
						secondtry=0;
						temp_anode = 4'b1111;
						temp_cathode=7'b1111111;
						ssd_1=7'b1111111;
						ssd_2=7'b1111111;
						ssd_3=7'b1111111;
						ssd_4=7'b1111111;
						final_ssd=7'b1111111;
					end					
					else
					begin
						ssd_1=7'b1111111;
						ssd_2=7'b1111111;
						ssd_3=7'b1111111;
						ssd_4=7'b1111111;
						case(counter)
						3: begin temp_anode = 4'b0111; final_ssd = 7'b1111111; end
						2: begin temp_anode = 4'b1011; final_ssd = 7'b1000110; end
						1: begin temp_anode = 4'b1101; final_ssd = 7'b1000000; end
						0: begin temp_anode = 4'b1110; final_ssd = 7'b1000111; end
					endcase
					end
					
				end								
			end
			else
			begin
				if(firstpress==0)
				begin
					ssd_1=7'b1111111;
					ssd_2=7'b1111111;
					ssd_3=7'b1111111;
					ssd_4=7'b1111111;
					case(counter)
					3: begin temp_anode = 4'b0111; final_ssd = 7'b1111111; end
					2: begin temp_anode = 4'b1011; final_ssd = 7'b1000110; end
					1: begin temp_anode = 4'b1101; final_ssd = 7'b1000000; end
					0: begin temp_anode = 4'b1110; final_ssd = 7'b1000111; end
					endcase
				end								
			end			
		end		
		else
		begin
			status = 2; 
			firstpress=0;
			timer=0;
			temp=0;
			temp1=0;
			pause_timer=0;
			firsttry=0;
			secondtry=0;
			temp_anode = 4'b1111;
			temp_cathode=7'b1111111;
			ssd_1=7'b1111111;
			ssd_2=7'b1111111;
			ssd_3=7'b1111111;
			ssd_4=7'b1111111;
			final_ssd=7'b1111111;
		end
	end
	
	else if(status == 1) //UnLC
	begin
		if(switches[5]==1)
				temp1=1;
		if(switches[5]==0 && temp1==1)
				temp1=2;
						
		if(temp1==2) 		 
		begin
			timer=0;
			pause_timer=0;
			status = 0; 
			firstpress=0;
			temp=0;
			temp1=0;
			firsttry=0;
			secondtry=0;
			firstpress=0;
			temp_anode = 4'b1111;
			temp_cathode=7'b1111111;
			ssd_1=7'b1111111;
			ssd_2=7'b1111111;
			ssd_3=7'b1111111;
			ssd_4=7'b1111111;
			final_ssd=7'b1111111;
		end
		else
		begin
			ssd_1=7'b1111111;
			ssd_2=7'b1111111;
			ssd_3=7'b1111111;
			ssd_4=7'b1111111;
			case(counter)
				3: begin temp_anode = 4'b0111; final_ssd = 7'b1000110; end //C
				2: begin temp_anode = 4'b1011; final_ssd = 7'b1000111; end //L
				1: begin temp_anode = 4'b1101; final_ssd = 7'b0101011; end //n
				0: begin temp_anode = 4'b1110; final_ssd = 7'b1000001; end //U
			endcase
		end
	end
	
	else if(status == 2)
	begin		
		if(pause_timer >5000)
		begin 
			timer=0;
			pause_timer = 0;
			status = 0;
			temp=0;
			temp1=0;
			firstpress=0;
			firsttry=0;
			secondtry=0;
			temp_anode = 4'b1111;
			temp_cathode=7'b1111111;
			ssd_1=7'b1111111;
			ssd_2=7'b1111111;
			ssd_3=7'b1111111;
			ssd_4=7'b1111111;
			final_ssd=7'b1111111;
		end
		else 
			pause_timer = pause_timer + 1;
			ssd_1=7'b1111111;
			ssd_2=7'b1111111;
			ssd_3=7'b1111111;
			ssd_4=7'b1111111;
		case(counter)
			3: begin temp_anode = 4'b0111; final_ssd = 7'b0010010;end //S
			2: begin temp_anode = 4'b1011; final_ssd = 7'b1000001;end //U
			1: begin temp_anode = 4'b1101; final_ssd = 7'b0001000;end //A
			0: begin temp_anode = 4'b1110; final_ssd = 7'b0001100;end //P
		endcase
	end

	if(ledcount>50)
	begin
		ledcount=0;		
	end
	ledcount = ledcount+1;
	
	if(status==1)
		temp_led=8'b11111111;
	
end


assign led=temp_led;
assign cathodes= final_ssd;
assign anodes = temp_anode;



endmodule
