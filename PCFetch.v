module PCFetch(
	input [31:0] MemInp, 
	output reg [31:0] InstructionRegister,
	input MemDataRead, 
	input IRWrite, 
	input clock,
	input reset);
	
	always@(posedge clock)
	begin
		
		if({MemDataRead, IRWrite} == 2'b11) //IR receives RAM[PC] on cycle 2
			InstructionRegister = MemInp;
		if(reset == 1)
			InstructionRegister = 32'd0;
		
	end
	
endmodule
