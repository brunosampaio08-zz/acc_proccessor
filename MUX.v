module MUX(Selector, Input, MUXOut);
	parameter SelectorSize;
	
	input [SelectorSize-1:0] Selector;
	input [((2**SelectorSize)*32)-1:0] Input;
	wire [((2**SelectorSize))*32-1:0] ShiftedInput;
	output wire [31:0] MUXOut;
	
	assign ShiftedInput = Input >> (Selector*32);
	
	assign MUXOut = ShiftedInput[31:0];
	

endmodule
