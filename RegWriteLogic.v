module RegWriteLogic(
	input [31:0] InptAccumulator, 
	input [31:0] InptIndexedX, 
	input [31:0] InptIndexedY, 
	input [31:0] InptStackPointer,
	output reg [31:0] Accumulator, 
	output reg [31:0] IndexedX, 
	output reg [31:0] IndexedY, 
	output reg [31:0] StackPointer, 
	output reg [31:0] StatusRegister, 
	input [2:0] SRFlags, 
	input [31:0] ALUOut, 
	input [31:0] MemInp,
	input[5:0] ALUWriteSignals, 
	input [7:0] TransferSignals, 
	input SRWrite, 
	input MemDataRead,
	input [31:0] AccMUXOut,
	input [31:0] Input_Wire,
	input InputSignal,
	input clock,
	input reset);
	
	initial
	begin
		StackPointer = 32'd9497;
	end
	
	always@(posedge clock)
	begin
	
		case({InputSignal, ALUWriteSignals[4:1]}) //Writes on destiny register if ALURead is ON
			5'b01001: IndexedX = ALUOut; //ALURead ON,XWrite ON
			5'b01010: IndexedY = ALUOut; //ALURead ON,YWrite ON
			5'b01100: StackPointer = ALUOut; //ALURead ON, SPWrite ON
			5'b10010: IndexedY = Input_Wire; //InputInstructio, YWrite ON
		endcase
		
		casex({TransferSignals[2], TransferSignals[4], ALUWriteSignals[4], MemDataRead, ALUWriteSignals[0]})
			5'b001x1: Accumulator = AccMUXOut; //Write if AccWrite ON and ALURead ON
			5'b00x11: Accumulator = AccMUXOut; //Write if AccWrite ON and MemRead ON
			5'b10001: Accumulator = AccMUXOut; //XRead ON, AccWrite ON
			5'b01001: Accumulator = AccMUXOut; //YRead ON, AccWrite ON
		endcase

		case(TransferSignals)//Transfers REG1 to REG2 if signals are ON
			8'b10000100: StackPointer = InptIndexedX; //XRead, SPWrite ON
			8'b01001000: IndexedX = InptStackPointer; //SPRead ON, XWrite ON
			8'b00100001: IndexedY = InptAccumulator; //AccRead ON, Ywrite ON
			8'b00010010: Accumulator = InptIndexedY; //YRead ON, AccWrite ON
			8'b00001001: IndexedX = InptAccumulator; //AccRead ON, XWrite ON
			8'b00000110: Accumulator = InptIndexedX; //XRead ON, AccWrite ON
		endcase
		
		case({MemDataRead, SRWrite})
			2'b11: StatusRegister = AccMUXOut;
			2'b01: StatusRegister[2:0] = SRFlags;
		endcase
		
		if(reset == 1)
		begin
			Accumulator = 32'd0;
			StackPointer = 32'd9497;
			IndexedX = 32'd0;
			IndexedY = 32'd0;
			StatusRegister = 32'd0;
		end
		
	end
	
endmodule
