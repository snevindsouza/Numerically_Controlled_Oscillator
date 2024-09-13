`timescale 1ns / 1ps
module Keypad (
	input clk_4MHz,
	input [2:0] state_out,
	input [3:0] row,
	output wire rst,
	output reg signal_select, freq_select,
	output reg [3:0] col,
	output reg [3:0] signal_out,
	output reg [7:0] display_value [0:3]
);

//temporary values                                                                                                                                                                       
integer i;
reg en;  
reg [3:0] val;
reg [3:0] value [0:3];
initial begin
	i<= 0;
	en<= 1;
	rst<= 0;
	col<= 4'b0001;
end

always @(posedge clk_4MHz) begin
/*	Logic to detect Key-press 
	4x4 matrix keypad layout as follows:
	1		2		3		mHz
	4		5		6		Hz
	7		8		9		KHz
	rst	0				MHz
*/
	if (col==4'b0001) begin
		if (row[0]==1 && en) begin val <= 4'h1; en<= 0; end
		else if (row[1]==1 && en) begin val<= 4'h4; en<= 0; end
		else if (row[2]==1 && en) begin val<= 4'h7; en<= 0; end
//		else if (row[3]==1 && en) begin val<= 4'hf; en<= 0; end //assigned to reset 
	end
	else if (col==4'b0010) begin
		if (row[0]==1 && en) begin val<= 4'h2; en<= 0; end
		else if (row[1]==1 && en) begin val<= 4'h5; en<= 0; end
		else if (row[2]==1 && en) begin val<= 4'h8; en<= 0; end
		else if (row[3]==1 && en) begin val<= 4'h0; en<= 0; end
	end
	else if (col==4'b0100) begin
		if (row[0]==1 && en) begin val<= 4'h3; en<= 0; end
		else if (row[1]==1 && en) begin val<= 4'h6; en<= 0; end
		else if (row[2]==1 && en) begin val<= 4'h9; en<= 0; end
		else if (row[3]==1 && en) begin val<= 4'he; en<= 0; end
	end
	else if (col==4'b1000) begin
		if (row[0]==1 && en) begin val<= 4'ha; en<= 0; end
		else if (row[1]==1 && en) begin val<= 4'hb; en<= 0; end
		else if (row[2]==1 && en) begin val<= 4'hc; en<= 0; end
		else if (row[3]==1 && en) begin val<= 4'hd; en<= 0; end
	end
	col <= ({col[2:0],col[3]});
	
	//Debouncer
	if(~en) begin
		i <= i+1;
		if (i == 1000000) begin	//0.25 sec delay
			i <= 0;
			en <= 1; 
		end
	end
	
	case (state_out)
		0: begin
			signal_out <= 4'b0000;
			signal_select <= 0;
			freq_select <= 0;
			value [0] <= 4'hf;
			value [1] <= 4'hf;
			value [2] <= 4'hf;
			value [3] <= 4'hf;
			display_value [0] <= 8'h20;
			display_value [1] <= 8'h20;
			display_value [2] <= 8'h20;
			display_value [3] <= 8'h20;
			en <= 1;
		end
		1: begin
			if (~en) begin
				if (signal_select == 0 && val != 4'hf)begin 
					signal_out <= val;
					val <= 4'hf;
					signal_select <= 1;
				end
			end
		end
		2: begin
			freq_select <= 0;
			en <= 1;
			val <= 4'hf;
			value [0] <= 4'hf;
			value [1] <= 4'hf;
			value [2] <= 4'hf;
			value [3] <= 4'hf;
		end
		3: begin
			if (~en) begin
				if (freq_select == 0 && val != 4'hf)begin 
					if (value[0] == 4'hf)begin 
						value[0] <= val; 
						display_value[0] <= {4'h3,val};
						val <= 4'hf;
					end else if (value[0] !=4'hf && value[1] == 4'hf)begin 
						value[1] <= val; 
						display_value[1] <= {4'h3,val};			
						val <= 4'hf;
					end else if (value[0] !=4'hf && value[1] != 4'hf && value[2] == 4'hf)begin 
						value[2] <= val;
						display_value[2] <= {4'h3,val};			
						val <= 4'hf;
					end else if (value[0] !=4'hf && value[1] != 4'hf && value[2] != 4'hf && value[3] == 4'hf)begin 
						value[3] <= val; 					
						val <= 4'hf;
					end
					if (value[3] == 4'ha) begin display_value[3] <= 8'h6d;freq_select <= 1;end 		//m
					else if (value[3] == 4'hb) begin display_value[3] <= 8'h20;freq_select <= 1;end	//
					else if (value[3] == 4'hc) begin display_value[3] <= 8'h4b;freq_select <= 1;end	//K
					else if (value[3] == 4'hd) begin display_value[3] <= 8'h4d;freq_select <= 1;end	//M
					else begin display_value[3] <= 8'h20; end	//
				end
			end
		end
	endcase
end

assign rst = col[0] && row[3];	//Reset Button

endmodule 