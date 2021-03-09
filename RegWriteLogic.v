module RegWriteLogic(
	input [31:0] InptAccumulator, 
	input [31:0] InptIndexedX, 
	input [31:0] InptIndexedY, 
	input [31:0] InptStackPointer,
	input [31:0] InptAux,
	input [31:0] BRMUXOut,
	output reg [31:0] Accumulator, 
	output reg [31:0] IndexedX, 
	output reg [31:0] IndexedY, 
	output reg [31:0] StackPointer, 
	output reg [31:0] StatusRegister, 
	output reg [31:0] BaseRegister,
	output reg [31:0] AuxRegister,
	input [2:0] SRFlags, 
	input [31:0] ALUOut, 
	input [31:0] MemInp,
	input[5:0] ALUWriteSignals, 
	input [8:0] TransferSignals, 
	input SRWrite, 
	input MemDataRead,
	input [31:0] AccMUXOut,
	input [31:0] Input_Wire,
	input InputSignal,
	input BRWriteSignal,
	input CFFSignal,
	input procFinishSignal,
	input [1:0] AuxSignals,
	input clock,
	input reset);
	
	initial
	begin
		StackPointer = 32'd9497;
		BaseRegister = 32'd0;
	end
	
	always@(posedge clock)
	begin
	
		case({CFFSignal, InputSignal, ALUWriteSignals[4:1]}) //Writes on destiny register if ALURead is ON
			6'b001001: IndexedX = ALUOut; //ALURead ON,XWrite ON
			6'b001010: IndexedY = ALUOut; //ALURead ON,YWrite ON
			6'b001100: StackPointer = ALUOut; //ALURead ON, SPWrite ON
			6'b010010: IndexedY = Input_Wire; //InputInstruction, YWrite ON
			6'b100010: //CFFSignal (CPFInstruction) ON, YWrite ON
			begin
				case(StatusRegister[3]) //If PFF (ProcessFinishFlag == SR[3]) is ON -> Set Y = 1 ; Else Y = 0;
					1'b1: IndexedY = 32'd1;
					1'b0: IndexedY = 32'd0;
				endcase
			end
		endcase
		
		casex({TransferSignals[2], TransferSignals[4], ALUWriteSignals[4], MemDataRead, ALUWriteSignals[0]})
			5'b001x1: Accumulator = AccMUXOut; //Write if AccWrite ON and ALURead ON
			5'b00x11: Accumulator = AccMUXOut; //Write if AccWrite ON and MemRead ON
			5'b10001: Accumulator = AccMUXOut; //XRead ON, AccWrite ON
			5'b01001: Accumulator = AccMUXOut; //YRead ON, AccWrite ON
		endcase

		case({AuxSignals, TransferSignals})//Transfers REG1 to REG2 if signals are ON
			11'b00010000100: StackPointer = InptIndexedX; //XRead ON, SPWrite ON (TXS)
			11'b00001001000: IndexedX = InptStackPointer; //SPRead ON, XWrite ON (TSX)
			11'b00000100001: IndexedY = InptAccumulator; //AccRead ON, Ywrite ON (TAY)
			11'b00000010010: Accumulator = InptIndexedY; //YRead ON, AccWrite ON (TYA)
			11'b00000001001: IndexedX = InptAccumulator; //AccRead ON, XWrite ON (TAX)
			11'b00000000110: Accumulator = InptIndexedX; //XRead ON, AccWrite ON (TXA)
			11'b01000000100: AuxRegister = InptIndexedX; //AuxWrite ON, XRead ON
			11'b10000001000: IndexedX = InptAux; //XWrite ON, AuxRead ON
		endcase
		
		case({AuxSignals[1], TransferSignals[8]})
			2'b11: BaseRegister = AuxRegister; //BRWrite ON, AuxRead ON (TAXBR)
			2'b01: BaseRegister = 32'd0;
		endcase
		
		case({procFinishSignal, MemDataRead, SRWrite})
			3'b011: StatusRegister = AccMUXOut;
			3'b001: StatusRegister[2:0] = SRFlags;
			3'b101: StatusRegister[3] = 1;
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
