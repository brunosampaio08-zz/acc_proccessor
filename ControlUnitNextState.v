module ControlUnitNextState(
	output reg [2:0] NextState, 
	input [2:0] CurrentState, 
	input clk, 
	input [5:0] OPCode,
	input subiu,
	input desceu);

	always@(*)
	begin
		case(CurrentState)
			3'b000: NextState = 3'b001; //First cycle
			3'b001: NextState = 3'b010; //Second cycle
			3'b010: NextState = 3'b011; //Third cycle
			3'b011: //Fourth cycle
				case(OPCode)
					6'b011011: NextState = 3'b100;
					6'b011100: NextState = 3'b100;
					6'b011101: NextState = 3'b100;
					6'b011110: NextState = 3'b100;
					6'b011111: NextState = 3'b100;
					6'b100001: NextState = 3'b100;
					6'b100010: NextState = 3'b100;
					6'b101000: NextState = 3'b100;
					6'b100000: NextState = 3'b100;
					6'b111100:
					begin
						if(subiu == desceu)
							NextState = 3'b011;
						else
							NextState = 3'b100;
					end
					6'b111111:
					begin
						if(subiu == desceu)
							NextState = 3'b011;
						else
							NextState = 3'b100;
					end
					
					default NextState = 3'b000;
				endcase
			3'b100: //Fifth cycle
				case(OPCode)
					6'b100010: NextState = 3'b101;
					6'b111100:
					begin
						if(subiu != desceu)
							NextState = 3'b100;
						else
							NextState = 3'b000;
					end
					6'b111111:
					begin
						if(subiu != desceu)
							NextState = 3'b100;
						else
							NextState = 3'b000;
					end
					default NextState = 3'b000;
				endcase
			default: NextState = 3'b000;
		endcase
	end
	
	
endmodule
