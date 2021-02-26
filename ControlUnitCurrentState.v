module ControlUnitCurrentState(
	input [2:0] NextState, 
	output reg [2:0] CurrentState, 
	input clk, 
	input reset);

	always@(posedge clk)
	begin
		if(reset == 1)
			CurrentState = 3'd0;
		else
			CurrentState = NextState;
	end

endmodule
