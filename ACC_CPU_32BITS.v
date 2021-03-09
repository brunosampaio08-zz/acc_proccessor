module ACC_CPU_32BITS(
	input button_clock_in, 
	input [16:0] Input,
	output wire [0:27] Output7Segments, 
	input clock, 
	output wire WaitingInput, 
	input reset_in,
	output wire Negative,
	output wire [0:20] OutputPC
	//output wire [31:0] InputAOut,
	//output wire [31:0] InputBOut,
	//output wire [31:0] ULAOut,
	//output wire [31:0] IROut,
	//output wire [31:0] SROut,
	//output wire [6:0] BranchOut,
	//output wire [31:0] PCOut,
	//output wire [31:0] OutAcc,
	//output wire [31:0] OutX,
	//output wire [31:0] OutY,
	//output wire [31:0] OutPS,
	//output wire [31:0] OutSP,
	//output wire [31:0] OutAux
	//output wire [3:0] PCWriteOut,
	//output wire [2:0] SRSigOut,
	//output wire preemptSigOut,
	//output wire [31:0] savedPCOut,
	//output wire [31:0] BROut
	//output wire countSigOut
	);
	
	//assign InputAOut = MUX3Out;
	//assign InputBOut = MUX1Out;
	//assign ULAOut = ALUOut;
	//assign IROut = InstructionRegister;
	//assign SROut = ProcessorStatus;
	//assign BranchOut = {BranchSignals, ProcessorStatus[1:0], PCWrite};
	//assign PCOut = ProgramCounter;
	//assign PCWriteOut = {savedPCRead, MemDataRead, ALURead, PCWrite};
	//assign SRSigOut = SRFlags;
	//assign preemptSigOut = preemptSignal;
	//assign savedPCOut = savedPC;
	//assign BROut = BaseRegister;
	//assign countSigOut = CountSignal;
	//assign OutAcc = Accumulator;
	//assign OutX = IndexedX;
	//assign OutY = IndexedY;
	//assign OutPS = ProcessorStatus;
	//assign OutSP = StackPointer;
	//assign OutAux = AuxRegister;

	//Wire and reg block
	wire [31:0] Accumulator, IndexedX, IndexedY, ProcessorStatus, StackPointer, ProgramCounter, BaseRegister;
	wire [31:0] OutputBinary, OutputBCD, OutputPCBCD, AuxRegister;
	wire [31:0] InstructionRegister, Input_Wire, savedPC;
	wire [31:0] ExtIR, MUX1Out, MUX2Out, MUX3Out, MUX4Out, MUX5Out, ALUOut, AddressMUXOut, MUX6Out;
	wire [31:0] MemWriteMUXOut, MemWriteMUX2Out, PCMuxOut, MemInp, BRMUXOut, IRMUXOut, InptPC;
	wire PCRead, IRWrite, MUXPCInpSelect, AddressRead, MemDataRead, PCWrite, IRRead;
	wire AccRead, AccWrite, SPRead, SPWrite, XRead, XWrite, YRead, YWrite;
	wire MemDataWrite, SRRead, SRWrite, ALURead, MUXPCInp2Select, ZeroSig, NegSig;
	wire [1:0] MUXULAInp1Select, MUXULAInp2Select, MUXULAInp3Select, AddressMUXSelect;
	wire [1:0] MemWriteSelect1, MemWriteSelect2, IOSignals, AuxSignals;
	wire [2:0] ALUControl, MemReadSignals, SRFlags;
	wire [3:0] BranchSignals;
	wire [54:0] ControlSignals;
	wire [31:0] Quatro, Um, Zero, OSPC;
	wire [5:0] ALUWriteSignals;
	wire [8:0] TransferSignals;
	wire [5:0] OPCode;
	wire [2:0] MemRegReadSignals, ClearSR;
	wire AccMUXSelect, reset_out, BRKSig, button_clock_out;
	wire [31:0] AccMUXOut, AccMUX2Out, AccMUX3Out;
	wire ALUExtra, BRWriteSignal, preemptSignal, CountSignal, CFFSignal, procFinishSignal, savedPCWriteSignal;
	wire savedPCWrite, savedPCRead;
	
	//Output block
	
	BitExtensor #26 Extend26to32(InstructionRegister[25:0], ExtIR);
	
	//BCD and 7 segments display
	
//	bin2bcd BCDConvert (OutputBinary[7:0], OutputBCD[11:0]);
//	bin2bcd BCDConvert2 (OutputBinary[15:8], OutputBCD[23:12]);
//	bin2bcd BCDConvert3 (ProgramCounter[7:0], OutputPCBCD[11:0]);
	
//	BCDto7SegsVHDL SevenSegs1(OutputBCD[3:0], Output7Segments[6:0]);
//	BCDto7SegsVHDL SevenSegs2(OutputBCD[7:4], Output7Segments[13:7]);
//	BCDto7SegsVHDL SevenSegs3(OutputBCD[11:8], Output7Segments[20:14]);
//	BCDto7SegsVHDL SevenSegs4(OutputBCD[15:12], Output7Segments[27:21]);
	
//	BCDto7SegsVHDL SevenSegs5(OutputPCBCD[3:0], OutputPC[6:0]);
//	BCDto7SegsVHDL SevenSegs6(OutputPCBCD[7:4], OutputPC[13:7]);
//	BCDto7SegsVHDL SevenSegs7(OutputPCBCD[11:8], OutputPC[20:14]);

	seven_seg_hex sevenSegs1(OutputBinary[3:0], Output7Segments[0:6]);
	seven_seg_hex sevenSegs2(OutputBinary[7:4], Output7Segments[7:13]);
	seven_seg_hex sevenSegs3(OutputBinary[11:8], Output7Segments[14:20]);
	seven_seg_hex sevenSegs4(OutputBinary[15:12], Output7Segments[21:27]);
	
	seven_seg_hex sevenSegs5(ProgramCounter[3:0], OutputPC[0:6]);
	seven_seg_hex sevenSegs6(ProgramCounter[7:4], OutputPC[7:13]);
	seven_seg_hex sevenSegs7(ProgramCounter[11:8], OutputPC[14:20]);
	
	//Button debounce
		
	//DeBounce DB1(clock, 1, button_clock_in, button_clock_out);
	//DeBounce DB2(clock, 1, reset_in, reset_out);
	
	assign button_clock_out = button_clock_in;
	assign reset_out = reset_in;
	
	//Assigns block
	
	assign Quatro = 32'd4;
	assign Um = 32'd1;
	assign Zero = 32'd0;
	assign OSPC = 32'd198;
	assign ALUWriteSignals = {ALURead, SPWrite, YWrite, XWrite, AccWrite};
	assign TransferSignals = {(BRWriteSignal || preemptSignal),
		SPWrite, SPRead, YWrite, YRead, XWrite, XRead, AccWrite, AccRead};
	assign MemReadSignals = {MemDataRead, IRWrite, PCWrite};
	assign OPCode = InstructionRegister[31:26];
	assign MemRegReadSignals = {MemDataRead, SRWrite, AccWrite};
	assign AccMUXSelect = MemDataRead;
	
	//Next block contains all the processors multiplexers
	
	MUX #2 MUXULAInp1(MUXULAInp1Select, {ExtIR, Quatro, Um, MemInp}, MUX1Out);
	MUX #2 MUXULAInp2(MUXULAInp2Select, {IndexedX, IndexedY, StackPointer, 
		ProgramCounter}, MUX2Out);
	MUX #2 MUXULAInp3(MUXULAInp3Select, {32'd0, Zero, Accumulator, MUX2Out}, MUX3Out);
	MUX #1 MUXPCInp(MUXPCInpSelect, {ExtIR, ALUOut}, MUX4Out);
	MUX #1 MUXPCInp2(MUXPCInp2Select, {MemInp, MUX4Out}, MUX5Out);
	MUX #1 MUXPCInp3(preemptSignal, {OSPC, MUX5Out}, MUX6Out);
	MUX #1 MUXPCInp4(savedPCRead, {savedPC, MUX6Out}, PCMuxOut);
	MUX #2 MUXAddressInp(AddressMUXSelect, {32'd0, ExtIR+IndexedX, ProgramCounter, 
		StackPointer}, AddressMUXOut);
	MUX #2 MUXMemWrite1(MemWriteSelect1, {savedPC, Accumulator, IndexedX,
		IndexedY}, MemWriteMUXOut);
	MUX #2 MUXMemWrite2(MemWriteSelect2, {32'd0, ProgramCounter, ProcessorStatus,
		MemWriteMUXOut}, MemWriteMUX2Out);
	MUX #1 AccMUXWrite1(MemDataRead, {MemInp, ALUOut}, AccMUXOut);
	MUX #1 AccMUXWrite2(XRead, {IndexedX, AccMUXOut}, AccMUX2Out);
	MUX #1 AccMUXWrite3(YRead, {IndexedY, AccMUXOut}, AccMUX3Out);
	MUX #1 BRMUX(preemptSignal, {32'd0, AuxRegister}, BRMUXOut);
	MUX #1 IRMUX(preemptSignal, {{6'b111110, 26'd0}, MemInp}, IRMUXOut);
	MUX #1 savedPCMUX(preemptSignal, {ProgramCounter, MemInp}, InptPC);
	
	//End of the multiplexer block
	
	//ALU instantiation block
	ULA ALU(MUX3Out, MUX1Out, {ALUExtra, ALUControl}, ALUOut, SRFlags, ClearSR); //ALU instance
	
	//PC fetching (IR writing) instantiation block
	PCFetch PCF(IRMUXOut, InstructionRegister, MemDataRead, IRWrite, clock, ~reset_out);
	
	//Branch logic instantiation block
	PCWriteLogic PCWL(PCMuxOut, InptPC, ProgramCounter, savedPC,
		{BranchSignals, ProcessorStatus[1:0], PCWrite}, 
			{savedPCRead, MemDataRead, ALURead, PCWrite}, (preemptSignal || savedPCWriteSignal),
				clock, ~reset_out);
		
	//Register write logic instantiation block
	RegWriteLogic RWL(Accumulator, IndexedX, IndexedY, StackPointer, AuxRegister, BRMUXOut,
		Accumulator, IndexedX, IndexedY, StackPointer, ProcessorStatus, BaseRegister, AuxRegister,
			SRFlags, ALUOut, MemInp, ALUWriteSignals, TransferSignals, SRWrite, 
				MemDataRead, AccMUX3Out, Input_Wire, IOSignals[0], BRWriteSignal, CFFSignal,
					procFinishSignal, AuxSignals, clock, ~reset_out);
	
	//Control unit instantiation block
	ControlUnit CTRUNIT(OPCode, ControlSignals, subiu, desceu, clock, ~reset_out);
	
	//Control signals assign block
	
	assign PCRead = ControlSignals[0];
	assign IRWrite = ControlSignals[1];
	assign MUXULAInp1Select = ControlSignals[3:2];
	assign MUXULAInp2Select = ControlSignals[5:4];
	assign MUXULAInp3Select = ControlSignals[7:6];
	assign MUXPCInpSelect = ControlSignals[8];
	assign AddressMUXSelect = ControlSignals[10:9];
	assign AddressRead = ControlSignals[11];
	assign MemDataRead = ControlSignals[12];
	assign PCWrite = ControlSignals[13];
	assign IRRead = ControlSignals[14];
	assign AccRead = ControlSignals[15];
	assign AccWrite = ControlSignals[16];
	assign SPRead = ControlSignals[17];
	assign SPWrite = ControlSignals[18];
	assign XRead = ControlSignals[19];
	assign XWrite = ControlSignals[20];
	assign YRead = ControlSignals[21];
	assign YWrite = ControlSignals[22];
	assign ALUControl = ControlSignals[25:23];
	assign MemWriteSelect1 = ControlSignals[27:26];
	assign MemWriteSelect2 = ControlSignals[29:28];
	assign MemDataWrite = ControlSignals[30];
	assign SRRead = ControlSignals[31];
	assign SRWrite = ControlSignals[32];
	assign ALURead = ControlSignals[33];
	assign MUXPCInp2Select = ControlSignals[34];
	assign BranchSignals = ControlSignals[38:35];
	assign IOSignals = ControlSignals[40:39];
	assign WaitingInput = ControlSignals[41];
	assign ClearSR = ControlSignals[44:42];
	assign BRKSig = ControlSignals[45];
	assign ALUExtra = ControlSignals[46];
	assign BRWriteSignal = ControlSignals[47];
	assign CountSignal = ControlSignals[48];
	assign CFFSignal = ControlSignals[49];
	assign procFinishSignal = ControlSignals[50];
	assign AuxSignals = ControlSignals[52:51];
	assign savedPCWriteSignal = ControlSignals[53];
	assign savedPCRead = ControlSignals[54];
	
	//Memory instantiation
	
	SingleClockRAM RAM(MemWriteMUX2Out, BaseRegister[14:0]+AddressMUXOut[14:0], MemDataWrite, 
		clock, MemInp);
	
	//IO logic instantiation
	
	IOLogic IOL(IOSignals, IndexedY, clock, ~button_clock_out, 
		{Input[16], {15{1'b0}}, Input[15:0]}, Input_Wire, subiu, desceu, OutputBinary,
			~reset_out, BRKSig, Negative);
			
	//Preemption clock instantiation
	
	signalClock SClock(clock, (BaseRegister ? (CountSignal ? 1 : 0) : 0) , preemptSignal);

endmodule
