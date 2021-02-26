module IOLogic(
	input [1:0] IOSignal,
	input [31:0] OutputRegister,
	input clock, 
	input button_clock,
	input [31:0] Input,
	output reg [31:0] InputRegister,
	output reg subiu,
	output reg desceu,
	output reg [31:0] Output,
	input reset,
	input BRKSig,
	output reg Negative);
	
	reg [31:0] InputCheck;
	
	always@(posedge button_clock)
	begin
		if(IOSignal[0] == 1)
			InputRegister = Input;
	end
	
	always@(posedge button_clock)
	begin
		if(IOSignal[0] == 1 | BRKSig == 1)
		begin
			if(subiu == 0)
				subiu = 1;
			else
				subiu = 0;
		end
	end
	
	always@(negedge button_clock)
	begin
		if((IOSignal[0] == 1 & subiu != desceu) | (BRKSig == 1 & subiu != desceu))
		begin
			if(desceu == 0)
				desceu = 1;
			else
				desceu = 0;
		end
	end
			
	always@(posedge clock)
	begin
	
		case(IOSignal[1]) //Output logic
			1'b1:
			begin
				if(OutputRegister[31] == 1)
				begin
					Output = ~(OutputRegister - 32'd1);
					Negative = 1;
				end
				else
				begin
					Output = OutputRegister;
					Negative = 0;
				end
			end
			default:;
		endcase
		
		if(reset == 1)
			Output = 32'd0;
	end

endmodule
