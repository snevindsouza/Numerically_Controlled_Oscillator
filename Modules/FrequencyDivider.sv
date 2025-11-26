module FrequencyDivider(
   input clk_32MHz, clk_100MHz, rst, Msel,
	input [2:0] state_out, 
	input [3:0] value [0:3],
   output clk_out
);
reg en =0;
reg low_out = 0; 
reg high_out = 0;
reg [29:0] frequency = 0;
reg [28:0] low_counter = 0;	// 29-bit counter for low frequencies (<1MHz)
reg [5:0] high_counter = 0;	// 5-bit counter for high frequencies (>1MHz)

always_ff @(posedge clk_32MHz) begin
	if (state_out == 4 && ~en) begin
		frequency = ((value[0]<<6) + (value[0]<<5) + (value[0]<<2)) + ((value[1]<<3) + (value[1]<<1)) + value[2];	//value[0]*100 + value[1]*10 + value[2]			
		case (value[3])
			4'ha: begin: mHz frequency = frequency; end 			
			4'hb: begin: Hz  frequency = (frequency<<9) + (frequency<<8) + (frequency<<7) + (frequency<<6) + (frequency<<5) + (frequency<<3); end	//frequency*1000
			4'hc: begin: KHz frequency = (frequency<<19) + (frequency<<18) + (frequency<<17) + (frequency<<16) + (frequency<<14) + (frequency<<9) + (frequency<<6); end	//frequency*1000000
			4'hd: begin: MHz frequency = frequency; end	
		endcase
		en =1;
	end
end

always_ff @(posedge clk_32MHz) begin : low_block
	low_counter <= (state_out == 5 && ~Msel) ? (low_counter + frequency) : 28'd0;
	if (low_counter >= 500000000) begin
		low_out <= ~low_out;
		low_counter <= 0;
	end
end

always_ff @(posedge clk_100MHz) begin : high_block
	high_counter <= (state_out == 5 && Msel) ? (high_counter + frequency) : 5'd0;
	if (high_counter >= 50) begin
		high_out <= ~high_out;
		high_counter <= 0;
	end
end

assign clk_out = Msel ? high_out : low_out; //This clock is used to generate waveforms

endmodule
