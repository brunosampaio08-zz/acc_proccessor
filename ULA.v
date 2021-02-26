
module ULA(
	input [31:0] InputA, 
	input [31:0] InputB, 
	input [3:0] ULAOPCode, 
	output reg [31:0] Outp, 
	output wire [2:0] SRFlags, 
	input [3:0] SRSignals);
	
	reg ZeroSignal, NegSignal, OVFlowSignal;
	
	always@(*) 
	begin
	
		//ALU Operations block
		case(ULAOPCode)
			4'b0000: {OVFlowSignal, Outp} = {1'b0, $signed(InputA)} + {1'b0, $signed(InputB)}; //SUM
			4'b0001: Outp = InputA & InputB; //AND
			4'b0010: Outp = InputA <<< InputB; //ASL
			4'b0011: Outp = $signed(InputA) - $signed(InputB); //SUB
			4'b0100: Outp = InputA ^ InputB; //XOR
			4'b0101: Outp = InputA >> InputB; //LSR
			4'b0110: Outp = InputA | InputB; //OR
			4'b0111: Outp = 0; //?
			4'b1000: Outp = $signed(InputA) * $signed(InputB); //MUL
			4'b1001: //DIV
			if(InputB == 0)
			begin	
				Outp = 0;
			end
			else
			begin
				Outp = $signed(InputA) / $signed(InputB);
			end
			default: Outp = 0;
		endcase
		
		//SR flags clear or set block
		if(SRSignals[0] == 1)
			OVFlowSignal = 0;
		if(SRSignals[1] == 1)
			NegSignal = 0;
		if(SRSignals[2] == 1)
			ZeroSignal = 0;
		
		if($signed(Outp) == 32'd0)
			ZeroSignal = 1;
		else
			ZeroSignal = 0;
		
		if(Outp[31] == 1)
			NegSignal = 1;
		else
			NegSignal = 0;
	
	end
	
	assign SRFlags = {OVFlowSignal, ZeroSignal, NegSignal};
	
endmodule
