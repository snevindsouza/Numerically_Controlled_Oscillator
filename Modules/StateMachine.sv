typedef enum {
	S0,	//Reset State
	S1,	//Select Signal
	S2,	//Display Selected Signal
	S3,	//Select Frequency
	S4,	//Display Selected Frequency
	S5		//Final State
} State;

module StateMachine (
	input logic clk_1MHz, rst, signal_select, freq_select,
	output logic [2:0] state_out
);

State state, stateNext;

reg [27:0] count = 28'd0;	//delay

always_ff @(posedge clk_1MHz) begin

	if (rst) begin
		state <= State.first; 
		stateNext <= State.first; 
	end else begin
	
		state <= stateNext;
		
		case (state)
			S0: begin	//Initial reset state 
				count <= rst ? 0 : count+1;
				if (count == 5000000) begin 	//3 sec delay
					count <= 0; 
					stateNext <= S1; 
				end
			end
			S1: begin	//Select Signal state
				if (signal_select) stateNext <= S2;
			end
			S2: begin	//Display Selected Signal state
				count = rst ? 0 : count+1;
				if (count == 5000000) begin 	//5 sec delay
					count=0; 
					stateNext <= S3;
				end
			end
			S3: begin	//Frequency Select state	
				if (freq_select) stateNext <= S4;
			end
			S4: begin	//Display Selected Frequency state and compute actual frequency
				count = rst ? 0 : count+1;
				if (count == 5000000) begin 	//5 sec delay
					count=0; 
					stateNext <= S5;	//Final State
				end
			end
			S5: begin	//Generate Waveforms
				stateNext <= S5;
			end
			default: begin
				stateNext <= State.first; 
			end
		endcase
	end
end

assign state_out = state;

endmodule 