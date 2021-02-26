module Contador04(Habilitador, Saida, clk);
input Habilitador, clk;
	output reg Saida;
	reg [2:0]Conta = 4'b000;
	
	always@(posedge clk)
	begin
		if(Conta == 4'b100)
			Saida = 1;
		else
			Saida = 0;
		Conta = Conta+1;
	end
endmodule
