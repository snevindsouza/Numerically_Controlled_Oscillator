module FunctionGenerator(
 	input clk_50MHz,
	input [3:0] row,
	output wire [3:0] col,
	output wire [7:0] data,
	output wire lcd_e, lcd_rs, lcd_rw
);

wire clk_1MHz, clk_4MHz, rst, freq_select, signal_select ;
wire [2:0] state_out;
wire [3:0] signal_out;
wire [7:0] display_value [0:3];

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
	.rst(rst), 
	.signal_select(signal_select),
	.freq_select(freq_select),
	.col(col),
	.signal_out(signal_out),
	.display_value(display_value)
);

//PLL for frequency divider
clk_div_0002 clk_div_inst(
	.refclk   (clk_50MHz),  // refclk.clk
	.rst      (rst),      	// reset.reset
	.outclk_0 (clk_4MHz), 	// outclk0.clk
	.outclk_1 (clk_1MHz), 	// outclk1.clk
	.locked   (locked)    	// locked.export
);

endmodule 