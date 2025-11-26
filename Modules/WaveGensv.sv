module WaveGen(
	input clk_50MHz, clk_out,
	input [2:0] state_out, 
	input [3:0] signal_out,
	output reg [7:0] wave_out
);
reg [4:0] addr;				// Address for the LUT (5-bit, 0-31)
reg [7:0] wave_lut [0:31];	// Lookup tables for different waveforms

always_ff @(posedge clk_50MHz) begin
	case (signal_out) 
		1: begin: Sine
			wave_lut[0]  = 128;
			wave_lut[1]  = 152;
			wave_lut[2]  = 176;
			wave_lut[3]  = 198;
			wave_lut[4]  = 218;
			wave_lut[5]  = 234;
			wave_lut[6]  = 245;
			wave_lut[7]  = 253;
			wave_lut[8]  = 255;
			wave_lut[9]  = 253;
			wave_lut[10] = 245;
			wave_lut[11] = 234;
			wave_lut[12] = 218;
			wave_lut[13] = 198;
			wave_lut[14] = 176;
			wave_lut[15] = 152;
			wave_lut[16] = 128;
			wave_lut[17] = 103;
			wave_lut[18] = 79;
			wave_lut[19] = 57;
			wave_lut[20] = 37;
			wave_lut[21] = 21;
			wave_lut[22] = 10;
			wave_lut[23] = 2;
			wave_lut[24] = 0;
			wave_lut[25] = 2;
			wave_lut[26] = 10;
			wave_lut[27] = 21;
			wave_lut[28] = 37;
			wave_lut[29] = 57;
			wave_lut[30] = 79;
			wave_lut[31] = 103;
		end
		2: begin: Cosine
			wave_lut[0]  = 255;
			wave_lut[1]  = 253;
			wave_lut[2]  = 245;
			wave_lut[3]  = 234;
			wave_lut[4]  = 218;
			wave_lut[5]  = 198;
			wave_lut[6]  = 176;
			wave_lut[7]  = 152;
			wave_lut[8]  = 128;
			wave_lut[9]  = 103;
			wave_lut[10] = 79;
			wave_lut[11] = 57;
			wave_lut[12] = 37;
			wave_lut[13] = 21;
			wave_lut[14] = 10;
			wave_lut[15] = 2;
			wave_lut[16] = 0;
			wave_lut[17] = 2;
			wave_lut[18] = 10;
			wave_lut[19] = 21;
			wave_lut[20] = 37;
			wave_lut[21] = 57;
			wave_lut[22] = 79;
			wave_lut[23] = 103;
			wave_lut[24] = 127;
			wave_lut[25] = 152;
			wave_lut[26] = 176;
			wave_lut[27] = 198;
			wave_lut[28] = 218;
			wave_lut[29] = 234;
			wave_lut[30] = 245;
			wave_lut[31] = 253;
		end
		3: begin: Triangular
			wave_lut[0]  = 0;
			wave_lut[1]  = 16;
			wave_lut[2]  = 32;
			wave_lut[3]  = 48;
			wave_lut[4]  = 64;
			wave_lut[5]  = 80;
			wave_lut[6]  = 96;
			wave_lut[7]  = 112;
			wave_lut[8]  = 128;
			wave_lut[9]  = 143;
			wave_lut[10] = 159;
			wave_lut[11] = 175;
			wave_lut[12] = 191;
			wave_lut[13] = 207;
			wave_lut[14] = 223;
			wave_lut[15] = 239;
			wave_lut[16] = 255;
			wave_lut[17] = 239;
			wave_lut[18] = 223;
			wave_lut[19] = 207;
			wave_lut[20] = 191;
			wave_lut[21] = 175;
			wave_lut[22] = 159;
			wave_lut[23] = 143;
			wave_lut[24] = 128;
			wave_lut[25] = 112;
			wave_lut[26] = 96;
			wave_lut[27] = 80;
			wave_lut[28] = 64;
			wave_lut[29] = 48;
			wave_lut[30] = 32;
			wave_lut[31] = 16;
		end
		4: begin: Sinc
			wave_lut[0]   = 122;
			wave_lut[1]   = 130;
			wave_lut[2]   = 138;
			wave_lut[3]   = 143;
			wave_lut[4]   = 143;
			wave_lut[5]   = 137;
			wave_lut[6]   = 125;
			wave_lut[7]   = 112;
			wave_lut[8]   = 102;
			wave_lut[9]   = 100;
			wave_lut[10]  = 109;
			wave_lut[11]  = 130;
			wave_lut[12]  = 160;
			wave_lut[13]  = 194;
			wave_lut[14]  = 225;
			wave_lut[15]  = 247;
			wave_lut[16]  = 255;
			wave_lut[17]  = 247;
			wave_lut[18]  = 225;
			wave_lut[19]  = 194;
			wave_lut[20]  = 160;
			wave_lut[21]  = 130;
			wave_lut[22]  = 109;
			wave_lut[23]  = 100;
			wave_lut[24]  = 102;
			wave_lut[25]  = 112;
			wave_lut[26]  = 125;
			wave_lut[27]  = 137;
			wave_lut[28]  = 143;
			wave_lut[29]  = 143;
			wave_lut[30]  = 138;
			wave_lut[31]  = 130;
		end
		5: begin: Sawtooth
			wave_lut[0]   = 0;
			wave_lut[1]   = 8;
			wave_lut[2]   = 16;
			wave_lut[3]   = 24;
			wave_lut[4]   = 32;
			wave_lut[5]   = 40;
			wave_lut[6]   = 48;
			wave_lut[7]   = 56;
			wave_lut[8]   = 64;
			wave_lut[9]   = 72;
			wave_lut[10]  = 80;
			wave_lut[11]  = 88;
			wave_lut[12]  = 96;
			wave_lut[13]  = 104;
			wave_lut[14]  = 112;
			wave_lut[15]  = 120;
			wave_lut[16]  = 128;
			wave_lut[17]  = 135;
			wave_lut[18]  = 143;
			wave_lut[19]  = 151;
			wave_lut[20]  = 159;
			wave_lut[21]  = 167;
			wave_lut[22]  = 175;
			wave_lut[23]  = 183;
			wave_lut[24]  = 191;
			wave_lut[25]  = 199;
			wave_lut[26]  = 207;
			wave_lut[27]  = 215;
			wave_lut[28]  = 223;
			wave_lut[29]  = 231;
			wave_lut[30]  = 239;
			wave_lut[31]  = 247;
		end
		6: begin: Square
			wave_lut[0]   = 255;
			wave_lut[1]   = 255;
			wave_lut[2]   = 255;
			wave_lut[3]   = 255;
			wave_lut[4]   = 255;
			wave_lut[5]   = 255;
			wave_lut[6]   = 255;
			wave_lut[7]   = 255;
			wave_lut[8]   = 255;
			wave_lut[9]   = 255;
			wave_lut[10]  = 255;
			wave_lut[11]  = 255;
			wave_lut[12]  = 255;
			wave_lut[13]  = 255;
			wave_lut[14]  = 255;
			wave_lut[15]  = 255;
			wave_lut[16]  = 0;
			wave_lut[17]  = 0;
			wave_lut[18]  = 0;
			wave_lut[19]  = 0;
			wave_lut[20]  = 0;
			wave_lut[21]  = 0;
			wave_lut[22]  = 0;
			wave_lut[23]  = 0;
			wave_lut[24]  = 0;
			wave_lut[25]  = 0;
			wave_lut[26]  = 0;
			wave_lut[27]  = 0;
			wave_lut[28]  = 0;
			wave_lut[29]  = 0;
			wave_lut[30]  = 0;
			wave_lut[31]  = 0;
		end
	endcase
end

always_ff @(posedge clk_out) begin
	if(state_out==5)begin
		addr <= addr + 5'd1;
		wave_out <= wave_lut[addr];
	end
end

endmodule 