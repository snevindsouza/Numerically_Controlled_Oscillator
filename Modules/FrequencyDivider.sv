module FrequencyDivider(
	input clk_50MHz,
	output reg clk_1MHz,
	output reg clk_4MHz
);

reg [5:0] count = 6'd0;
reg [3:0] count1 = 4'd0;


always @(posedge clk_50MHz) begin
	count<=count + 5'd1;
	if(count>=50) count <= 5'd0;
	clk_1MHz <= (count<25)? 1'b1:1'b0;
end

always @(posedge clk_50MHz) begin
	count1<=count1 + 4'd1;
	if(count1>=12) count1 <= 4'd0;
	clk_4MHz <= (count1<6)? 1'b1:1'b0;
end

endmodule 