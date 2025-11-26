module LcdInterface(
	input clk_1MHz,
	input [2:0] state_out,
	input [3:0] signal_out,
	input [7:0] display_value [0:3],
	output reg [7:0] data,
	output reg lcd_e, lcd_rs, lcd_rw
);

integer i = 0;
integer j = 1;

reg flag, sflag;

initial begin lcd_rw <= 0; flag <= 1; sflag<=0; end 
reg [7:0] Datas [1:40];

//logic to display data
always @(posedge clk_1MHz) begin
	case(state_out)
		0: begin
			flag<= 0;
			Datas[1]  <=  8'h38;		//-- control instruction : configure - 2 lines, 5x7 matrix --		 
			Datas[2]  <=  8'h0C;    //-- control instruction : Display on, cursor off --		 
			Datas[3]  <=  8'h06;    //-- control instruction : Increment cursor : shift cursor to right --	
			Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --	
			// FIRST LINE
			Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
			Datas[6]  <=  8'h20;    // 		 
			Datas[7]  <=  8'h20;    // 	
			Datas[8]  <=  8'h20;    // 			 
			Datas[9]  <=  8'h20;    // 			 
			Datas[10] <=  8'h57;    // W 			 
			Datas[11] <=  8'h61;    // a			 
			Datas[12] <=  8'h76;    // v			 
			Datas[13] <=  8'h65;    // e
			Datas[14] <=  8'h66;    // f
			Datas[15] <=  8'h6f;    // o			 
			Datas[16] <=  8'h72;    // r			 
			Datas[17] <=  8'h6d;    // m			 
			Datas[18] <=  8'h20;    // 			 
			Datas[19] <=  8'h20;    // 			 
			Datas[20] <=  8'h20;    // 			 
			Datas[21] <=  8'h20;    //
			// SECOND LINE
			Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --		 
			Datas[23] <=  8'h20;    // 
			Datas[24] <=  8'h20;    //
			Datas[25] <=  8'h20;    // 			 
			Datas[26] <=  8'h47;    // G			 
			Datas[27] <=  8'h65;    // e			 
			Datas[28] <=  8'h6e;    // n			 
			Datas[29] <=  8'h65;    // e			 
			Datas[30] <=  8'h72;    // r
			Datas[31] <=  8'h61;    // a	
			Datas[32] <=  8'h74;    // t	
			Datas[33] <=  8'h6f;    // o	
			Datas[34] <=  8'h72;    // r	
			Datas[35] <=  8'h21;    // !	
			Datas[36] <=  8'h20;    // 	
			Datas[37] <=  8'h20;    // 	
			Datas[38] <=  8'h20;    // 
		end
		1: begin 
			sflag<= 1;
			#10000;
			sflag<= 0;
			Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
			// FIRST LINE
			Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
			Datas[6]  <=  8'h53;    // S			 
			Datas[7]  <=  8'h65;    // e	
			Datas[8]  <=  8'h6c;    // l			 
			Datas[9]  <=  8'h65;    // e			 
			Datas[10] <=  8'h63;    // c			 
			Datas[11] <=  8'h74;    // t			 
			Datas[12] <=  8'h20;    // 			 
			Datas[13] <=  8'h53;    // S
			Datas[14] <=  8'h69;    // i
			Datas[15] <=  8'h67;    // g			 
			Datas[16] <=  8'h6e;    // n			 
			Datas[17] <=  8'h61;    // a			 
			Datas[18] <=  8'h6c;    // l			 
			Datas[19] <=  8'h20;    // 			 
			Datas[20] <=  8'h20;    // 			 
			Datas[21] <=  8'h20;    //
			// SECOND LINE
			Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --	
			Datas[23] <=  8'h20;    // 
			Datas[24] <=  8'h20;    // 
			Datas[25] <=  8'h20;    // 			 
			Datas[26] <=  8'h20;    // 		 
			Datas[27] <=  8'h20;    // 			 
			Datas[28] <=  8'h20;    // 			 
			Datas[29] <=  8'h20;    // 			 
			Datas[30] <=  8'h20;    // 
			Datas[31] <=  8'h20;    // 	
			Datas[32] <=  8'h20;    // 	
			Datas[33] <=  8'h20;    // 	
			Datas[34] <=  8'h20;    // 	
			Datas[35] <=  8'h20;    // 	
			Datas[36] <=  8'h20;    // 	
			Datas[37] <=  8'h20;    // 	
			Datas[38] <=  8'h20;    // 
		end
		2: begin
			if (signal_out==1) begin
				sflag<= 1;
				#10000;
				sflag<= 0;
				Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
				// FIRST LINE
				Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
				Datas[6]  <=  8'h53;    // S			 
				Datas[7]  <=  8'h65;    // e	
				Datas[8]  <=  8'h6c;    // l			 
				Datas[9]  <=  8'h65;    // e			 
				Datas[10] <=  8'h63;    // c			 
				Datas[11] <=  8'h74;    // t			 
				Datas[12] <=  8'h65;    // e			 
				Datas[13] <=  8'h64;    // d
				Datas[14] <=  8'h20;    // 
				Datas[15] <=  8'h53;    // s			 
				Datas[16] <=  8'h69;    // i			 
				Datas[17] <=  8'h67;    // g			 
				Datas[18] <=  8'h6e;    // n			 
				Datas[19] <=  8'h61;    // a			 
				Datas[20] <=  8'h6c;    // l			 
				Datas[21] <=  8'h20;    // 
				// SECOND LINE
				Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
				Datas[23] <=  8'h53;    // S
				Datas[24] <=  8'h69;    // i
				Datas[25] <=  8'h6e;    // n			 
				Datas[26] <=  8'h65;    // e			 
				Datas[27] <=  8'h20;    // 			 
				Datas[28] <=  8'h20;    // 			 
				Datas[29] <=  8'h20;    // 			 
				Datas[30] <=  8'h20;    // 
				Datas[31] <=  8'h20;    // 	
				Datas[32] <=  8'h20;    // 	
				Datas[33] <=  8'h20;    // 	
				Datas[34] <=  8'h20;    // 	
				Datas[35] <=  8'h20;    // 	
				Datas[36] <=  8'h20;    // 	
				Datas[37] <=  8'h20;    // 	
				Datas[38] <=  8'h20;    // 
			end else if (signal_out==2) begin
				sflag<= 1;
				#10000;
				sflag<= 0;
				Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
				// FIRST LINE
				Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
				Datas[6]  <=  8'h53;    // S			 
				Datas[7]  <=  8'h65;    // e	
				Datas[8]  <=  8'h6c;    // l			 
				Datas[9]  <=  8'h65;    // e			 
				Datas[10] <=  8'h63;    // c			 
				Datas[11] <=  8'h74;    // t			 
				Datas[12] <=  8'h65;    // e			 
				Datas[13] <=  8'h64;    // d
				Datas[14] <=  8'h20;    // 
				Datas[15] <=  8'h53;    // s			 
				Datas[16] <=  8'h69;    // i			 
				Datas[17] <=  8'h67;    // g			 
				Datas[18] <=  8'h6e;    // n			 
				Datas[19] <=  8'h61;    // a			 
				Datas[20] <=  8'h6c;    // l			 
				Datas[21] <=  8'h20;    // 
				// SECOND LINE
				Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
				Datas[23] <=  8'h43;    // C
				Datas[24] <=  8'h6f;    // o
				Datas[25] <=  8'h73;    // s			 
				Datas[26] <=  8'h69;    // i			 
				Datas[27] <=  8'h6e;    // n			 
				Datas[28] <=  8'h65;    // e			 
				Datas[29] <=  8'h20;    // 			 
				Datas[30] <=  8'h20;    // 
				Datas[31] <=  8'h20;    // 	
				Datas[32] <=  8'h20;    // 	
				Datas[33] <=  8'h20;    // 	
				Datas[34] <=  8'h20;    // 	
				Datas[35] <=  8'h20;    // 	
				Datas[36] <=  8'h20;    // 	
				Datas[37] <=  8'h20;    // 	
				Datas[38] <=  8'h20;    // 
			end else if (signal_out==3) begin
				sflag<= 1;
				#10000;
				sflag<= 0;
				Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
				// FIRST LINE
				Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
				Datas[6]  <=  8'h53;    // S			 
				Datas[7]  <=  8'h65;    // e	
				Datas[8]  <=  8'h6c;    // l			 
				Datas[9]  <=  8'h65;    // e			 
				Datas[10] <=  8'h63;    // c			 
				Datas[11] <=  8'h74;    // t			 
				Datas[12] <=  8'h65;    // e			 
				Datas[13] <=  8'h64;    // d
				Datas[14] <=  8'h20;    // 
				Datas[15] <=  8'h53;    // s			 
				Datas[16] <=  8'h69;    // i			 
				Datas[17] <=  8'h67;    // g			 
				Datas[18] <=  8'h6e;    // n			 
				Datas[19] <=  8'h61;    // a			 
				Datas[20] <=  8'h6c;    // l			 
				Datas[21] <=  8'h20;    // 
				// SECOND LINE
				Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
				Datas[23] <=  8'h54;    // T
				Datas[24] <=  8'h72;    // r
				Datas[25] <=  8'h69;    // i			 
				Datas[26] <=  8'h61;    // a			 
				Datas[27] <=  8'h6e;    // n			 
				Datas[28] <=  8'h67;    // g			 
				Datas[29] <=  8'h75;    // u			 
				Datas[30] <=  8'h6c;    // l
				Datas[31] <=  8'h61;    // a	
				Datas[32] <=  8'h72;    // r	
				Datas[33] <=  8'h20;    // 	
				Datas[34] <=  8'h20;    // 	
				Datas[35] <=  8'h20;    // 	
				Datas[36] <=  8'h20;    // 	
				Datas[37] <=  8'h20;    // 	
				Datas[38] <=  8'h20;    // 
			end else if (signal_out==4) begin
				sflag<= 1;
				#10000;
				sflag<= 0;
				Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
				// FIRST LINE
				Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
				Datas[6]  <=  8'h53;    // S			 
				Datas[7]  <=  8'h65;    // e	
				Datas[8]  <=  8'h6c;    // l			 
				Datas[9]  <=  8'h65;    // e			 
				Datas[10] <=  8'h63;    // c			 
				Datas[11] <=  8'h74;    // t			 
				Datas[12] <=  8'h65;    // e			 
				Datas[13] <=  8'h64;    // d
				Datas[14] <=  8'h20;    // 
				Datas[15] <=  8'h53;    // s			 
				Datas[16] <=  8'h69;    // i			 
				Datas[17] <=  8'h67;    // g			 
				Datas[18] <=  8'h6e;    // n			 
				Datas[19] <=  8'h61;    // a			 
				Datas[20] <=  8'h6c;    // l			 
				Datas[21] <=  8'h20;    // 
				// SECOND LINE
				Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
				Datas[23] <=  8'h53;    // S
				Datas[24] <=  8'h69;    // i
				Datas[25] <=  8'h6e;    // n			 
				Datas[26] <=  8'h63;    // c				 
				Datas[27] <=  8'h20;    // 			 
				Datas[28] <=  8'h20;    // 			 
				Datas[29] <=  8'h20;    // 			 
				Datas[30] <=  8'h20;    // 
				Datas[31] <=  8'h20;    // 	
				Datas[32] <=  8'h20;    // 	
				Datas[33] <=  8'h20;    // 	
				Datas[34] <=  8'h20;    // 	
				Datas[35] <=  8'h20;    // 	
				Datas[36] <=  8'h20;    // 	
				Datas[37] <=  8'h20;    // 	
				Datas[38] <=  8'h20;    // 
			end else if (signal_out==5) begin
				sflag<= 1;
				#10000;
				sflag<= 0;
				Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
				// FIRST LINE
				Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
				Datas[6]  <=  8'h53;    // S			 
				Datas[7]  <=  8'h65;    // e	
				Datas[8]  <=  8'h6c;    // l			 
				Datas[9]  <=  8'h65;    // e			 
				Datas[10] <=  8'h63;    // c			 
				Datas[11] <=  8'h74;    // t			 
				Datas[12] <=  8'h65;    // e			 
				Datas[13] <=  8'h64;    // d
				Datas[14] <=  8'h20;    // 
				Datas[15] <=  8'h53;    // s			 
				Datas[16] <=  8'h69;    // i			 
				Datas[17] <=  8'h67;    // g			 
				Datas[18] <=  8'h6e;    // n			 
				Datas[19] <=  8'h61;    // a			 
				Datas[20] <=  8'h6c;    // l			 
				Datas[21] <=  8'h20;    // 
				// SECOND LINE
				Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
				Datas[23] <=  8'h53;    // S
				Datas[24] <=  8'h61;    // a
				Datas[25] <=  8'h77;    // w			 
				Datas[26] <=  8'h74;    // t			 
				Datas[27] <=  8'h6f;    // o			 
				Datas[28] <=  8'h6f;    // o			 
				Datas[29] <=  8'h74;    // t			 
				Datas[30] <=  8'h68;    // h
				Datas[31] <=  8'h20;    // 	
				Datas[32] <=  8'h20;    // 	
				Datas[33] <=  8'h20;    // 	
				Datas[34] <=  8'h20;    // 	
				Datas[35] <=  8'h20;    // 	
				Datas[36] <=  8'h20;    // 	
				Datas[37] <=  8'h20;    // 	
				Datas[38] <=  8'h20;    // 
			end else if (signal_out==6) begin
				sflag<= 1;
				#10000;
				sflag<= 0;
				Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
				// FIRST LINE
				Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
				Datas[6]  <=  8'h53;    // S			 
				Datas[7]  <=  8'h65;    // e	
				Datas[8]  <=  8'h6c;    // l			 
				Datas[9]  <=  8'h65;    // e			 
				Datas[10] <=  8'h63;    // c			 
				Datas[11] <=  8'h74;    // t			 
				Datas[12] <=  8'h65;    // e			 
				Datas[13] <=  8'h64;    // d
				Datas[14] <=  8'h20;    // 
				Datas[15] <=  8'h53;    // s			 
				Datas[16] <=  8'h69;    // i			 
				Datas[17] <=  8'h67;    // g			 
				Datas[18] <=  8'h6e;    // n			 
				Datas[19] <=  8'h61;    // a			 
				Datas[20] <=  8'h6c;    // l			 
				Datas[21] <=  8'h20;    // 
				// SECOND LINE
				Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
				Datas[23] <=  8'h53;    // S
				Datas[24] <=  8'h71;    // q
				Datas[25] <=  8'h75;    // u			 
				Datas[26] <=  8'h61;    // a			 
				Datas[27] <=  8'h72;    // r			 
				Datas[28] <=  8'h65;    // e			 
				Datas[29] <=  8'h20;    // 			 
				Datas[30] <=  8'h20;    // 
				Datas[31] <=  8'h20;    // 	
				Datas[32] <=  8'h20;    // 	
				Datas[33] <=  8'h20;    // 	
				Datas[34] <=  8'h20;    // 	
				Datas[35] <=  8'h20;    // 	
				Datas[36] <=  8'h20;    // 	
				Datas[37] <=  8'h20;    // 	
				Datas[38] <=  8'h20;    // 
			end
		end
		3: begin
			sflag<= 1;
			#10000;
			sflag<= 0;
			Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
			// FIRST LINE
			Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
			Datas[6]  <=  8'h53;    // S			 
			Datas[7]  <=  8'h65;    // e	
			Datas[8]  <=  8'h6c;    // l			 
			Datas[9]  <=  8'h65;    // e			 
			Datas[10] <=  8'h63;    // c			 
			Datas[11] <=  8'h74;    // t			 
			Datas[12] <=  8'h20;    // 			 
			Datas[13] <=  8'h46;    // F
			Datas[14] <=  8'h72;    // r
			Datas[15] <=  8'h65;    // e			 
			Datas[16] <=  8'h71;    // q			 
			Datas[17] <=  8'h75;    // u			 
			Datas[18] <=  8'h65;    // e			 
			Datas[19] <=  8'h6e;    // n			 
			Datas[20] <=  8'h63;    // c			 
			Datas[21] <=  8'h79;    // y
			// SECOND LINE
			Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --	
			Datas[23] <=  display_value[0];    // digit
			Datas[24] <=  display_value[1];    // digit
			Datas[25] <=  display_value[2];    // digit	 
			Datas[26] <=  8'h20;		//
			Datas[27] <=  display_value[3];    // Multiplier (m, K, M)				 
			Datas[28] <=  8'h20;    // 			 
			Datas[29] <=  8'h20;    // 			 
			Datas[30] <=  8'h20;    // 
			Datas[31] <=  8'h20;    // 	
			Datas[32] <=  8'h20;    // 	
			Datas[33] <=  8'h20;    // 	
			Datas[34] <=  8'h20;    // 	
			Datas[35] <=  8'h20;    // 	
			Datas[36] <=  8'h20;    // 	
			Datas[37] <=  8'h20;    // 	
			Datas[38] <=  8'h20;    // 
		end
		4: begin
			sflag<= 1;
			#10000;
			sflag<= 0;
			Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
			// FIRST LINE
			Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
			Datas[6]  <=  8'h53;    // S			 
			Datas[7]  <=  8'h65;    // e	
			Datas[8]  <=  8'h6c;    // l			 
			Datas[9]  <=  8'h65;    // e			 
			Datas[10] <=  8'h63;    // c			 
			Datas[11] <=  8'h74;    // t			 
			Datas[12] <=  8'h65;    // e			 
			Datas[13] <=  8'h64;    // d
			Datas[14] <=  8'h20;    // 
			Datas[15] <=  8'h46;    // F			 
			Datas[16] <=  8'h72;    // r			 
			Datas[17] <=  8'h65;    // e			 
			Datas[18] <=  8'h71;    // q			 
			Datas[19] <=  8'h2e;    // .			 
			Datas[20] <=  8'h2e;    // .			 
			Datas[21] <=  8'h2e;    // .
			// SECOND LINE
			Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
			Datas[23] <=  display_value[0];    // digit
			Datas[24] <=  display_value[1];    // digit
			Datas[25] <=  display_value[2];    // digit	 
			Datas[26] <=  8'h20;		//
			Datas[27] <=  display_value[3];    // Multiplier (m, K, M)				 
			Datas[28] <=  8'h48;    // H			 
			Datas[29] <=  8'h7a;    // z			 
			Datas[30] <=  8'h20;    // 
			Datas[31] <=  8'h20;    // 	
			Datas[32] <=  8'h20;    // 	
			Datas[33] <=  8'h20;    // 	
			Datas[34] <=  8'h20;    // 	
			Datas[35] <=  8'h20;    // 	
			Datas[36] <=  8'h20;    // 	
			Datas[37] <=  8'h20;    // 	
			Datas[38] <=  8'h20;    // 
		end
		5: begin
			sflag<= 1;
			#10000;
			sflag<= 0;
			Datas[4]  <=  8'h01;    //-- control instruction : clear display screen --			
			// FIRST LINE
			Datas[5]  <=  8'h80;    //-- control instruction : force cursor to begin at first line --			 
			Datas[6]  <=  8'h47;    // G			 
			Datas[7]  <=  8'h65;    // e	
			Datas[8]  <=  8'h6e;    // n			 
			Datas[9]  <=  8'h65;    // e			 
			Datas[10] <=  8'h72;    // r			 
			Datas[11] <=  8'h61;    // a			 
			Datas[12] <=  8'h74;    // t			 
			Datas[13] <=  8'h69;    // i
			Datas[14] <=  8'h6e;    // n
			Datas[15] <=  8'h67;    // g			 
			Datas[16] <=  8'h2e;    // .			 
			Datas[17] <=  8'h2e;    // .			 
			Datas[18] <=  8'h2e;    // .			 
			Datas[19] <=  8'h20;    // .			 
			Datas[20] <=  8'h20;    // .			 
			Datas[21] <=  8'h20;    // .
			// SECOND LINE
			Datas[22] <=  8'hc0;		//-- control instruction : force cursor to begin at second line --
			Datas[23] <=  display_value[0];    // digit
			Datas[24] <=  display_value[1];    // digit
			Datas[25] <=  display_value[2];    // digit	 
			Datas[26] <=  8'h20;		//
			Datas[27] <=  display_value[3];    // Multiplier (m, K, M)				 
			Datas[28] <=  8'h48;    // H			 
			Datas[29] <=  8'h7a;    // z			 
			Datas[30] <=  8'h20;    // 
			Datas[31] <=  8'h20;    // 	
			Datas[32] <=  8'h20;    // 	
			Datas[33] <=  8'h20;    // 	
			Datas[34] <=  8'h20;    // 	
			Datas[35] <=  8'h20;    // 	
			Datas[36] <=  8'h20;    // 	
			Datas[37] <=  8'h20;    // 	
			Datas[38] <=  8'h20;    // 
		end
	endcase
end


always @(posedge clk_1MHz) begin
if (flag) begin i <= 0; j <= 1; end
	else if (sflag) begin i <= 0; j <= 4; end 
	else begin
		//-- Delay for writing data
		if (i < 200) begin // Assuming 1 clock cycle is 0.1us
			i<= i + 1;
			lcd_e <= 1;
			data <= Datas[j];
		end else if (i >= 200 & i < 400) begin // Adjust according to clock cycle
			i <= i + 1;
			lcd_e <= 0;
		end else if (i == 400) begin // Adjust according to clock cycle
			j <= j + 1;
			i <= 0;
		end
		// LCD_RS should be set to 0 for writing commands and to 1 for writing data
		if (j <= 5 ) lcd_rs<= 0;  
		else if (j > 5 & j< 22) lcd_rs<= 1;   
		else if (j == 22) lcd_rs<= 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
		else if (j > 22 & j < 39 ) lcd_rs<= 1;
		else if(j == 39) j<= 5;
	end
end
endmodule 