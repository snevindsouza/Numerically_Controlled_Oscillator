module FunctionGenerator(
 	input clk_50MHz, rst,
	input [3:0] row,
	output wire [3:0] col,
	output wire [7:0] data,
	output wire [7:0] wave_out,
	output wire lcd_e, lcd_rs, lcd_rw, clk_dac
);

wire clk_1MHz, clk_4MHz, clk_100MHz,clk_32MHz,  clk_out, freq_select, signal_select ;
wire [2:0] state_out;
wire [3:0] signal_out;
wire [3:0] value [0:3];
wire [7:0] display_value [0:3];
wire [29:0] frequency;

StateMachine StateMachine_inst(
	.clk_1MHz(clk_1MHz), 
	.rst(rst),
	.signal_select(signal_select),
	.freq_select(freq_select),
	.state_out(state_out)
); 

LcdInterface LcdInterface_inst(
	.clk_1MHz(clk_1MHz), 
	.state_out(state_out),
	.signal_out(signal_out),
	.data(data),
	.lcd_e(lcd_e), 
	.lcd_rs(lcd_rs), 
	.lcd_rw(lcd_rw),
	.display_value(display_value)
);

Keypad Keypad_inst(
	.clk_4MHz(clk_4MHz), 
	.state_out(state_out),
	.row(row),
	.signal_select(signal_select),
	.freq_select(freq_select),
	.Msel(Msel),
	.col(col),
	.signal_out(signal_out),
	.value(value),
	.display_value(display_value)
);

FrequencyDivider FrequencyDivider_inst(
   .clk_32MHz(clk_32MHz),  
	.clk_100MHz(clk_100MHz), 
	.Msel(Msel),
	.rst(rst),
	.state_out(state_out),
	.value(value),      
   .clk_out(clk_out)
);

WaveGen WaveGen_inst(
	.clk_50MHz(clk_50MHz),
	.clk_out(clk_out),
	.state_out(state_out),
	.signal_out(signal_out),
	.wave_out(wave_out)
);

//PLL for frequency divider (MAX 10)
PLL PLL_inst (
	.areset ( rst ),
	.inclk0 ( clk_50MHz ),
	.c0 ( clk_1MHz ),
	.c1 ( clk_4MHz ),
	.c3 ( clk_100MHz ),
	.c4 ( clk_32MHz ),
	.locked ( locked_sig )
);

//PLL for frequency divider (Cyclone V)
//clk_div_0002 clk_div_inst(
//	.refclk   (clk_50MHz),  // refclk.clk
//	.rst      (rst),      	// reset.reset
//	.outclk_0 (clk_4MHz), 	// outclk0.clk
//	.outclk_1 (clk_1MHz), 	// outclk1.clk
//	.outclk_2 (clk_320MHz), // outclk2.clk
//	.locked   (locked)    	// locked.export
//);

assign clk_dac = clk_100MHz;

endmodule 