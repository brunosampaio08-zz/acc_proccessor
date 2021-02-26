module BitExtensor(Inpt, Outp);
	parameter InputSize;
	input [InputSize-1:0] Inpt;
	output reg [31:0] Outp;
	
	always@(*)
	begin
		Outp = {{(32-InputSize){1'b0}}, Inpt};
	end


endmodule

