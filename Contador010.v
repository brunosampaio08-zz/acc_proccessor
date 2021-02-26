module Contador010(Habilitador, Saida, clk);
	input Habilitador, clk;
	output reg Saida;
	reg [3:0]Conta;
	
	always@(posedge clk)
	begin
		if(Conta+1 == 4'b1010)
		begin
			Conta <= 4'b0000;
			Saida <= 1;
		end
		else
		begin
			Conta <= Conta+1;
			Saida <= 0;
		end
	end

endmodule
