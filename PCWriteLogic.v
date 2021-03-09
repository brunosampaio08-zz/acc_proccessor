module PCWriteLogic(
	input [31:0] PCMuxOut,
	input [31:0] savedPCInpt,
	output reg [31:0] ProgramCounter,
	output reg [31:0] savedPC,
	input [6:0] BranchLogicSignals, 
	input [3:0] PCWriteSignals,
	input savedPCWriteSignal,
	input clock,
	input reset);
	
	initial
	begin
		ProgramCounter = 32'd0;
	end
	
	always@(posedge clock)
	begin	
		casex(BranchLogicSignals) //Writes PC in case instruction is branch
			7'b0001001: ProgramCounter = PCMuxOut; //PCWrite ON, BPL ON, NegSig OFF, ZeroSig OFF;
			7'b00100x1: ProgramCounter = PCMuxOut; //PCWrite ON, BNE ON, ZeroSig OFF;
			7'b0100x11: ProgramCounter = PCMuxOut; //PCWrite ON, BMI ON, NegSig ON;
			7'b10001x1: ProgramCounter = PCMuxOut; //PCWrite ON, BEQ ON, ZeroSig ON;
			default: ProgramCounter = ProgramCounter;
		endcase
		
		case(PCWriteSignals)
			4'b0011: ProgramCounter = PCMuxOut; //Writes PC during cycle 2
			4'b0101: ProgramCounter = PCMuxOut; //Writes PC if instruction is RTS
			4'b0111: ProgramCounter = PCMuxOut; //Writes also if both signals are ON
			4'b1001: ProgramCounter = PCMuxOut; //Writes savedPC to PC
			default: ProgramCounter = ProgramCounter;
		endcase
		
		case(savedPCWriteSignal)
			1'b1: savedPC = savedPCInpt;
		endcase
			
		
		if(reset == 1)
			ProgramCounter = 32'd0;
	end
		
endmodule
