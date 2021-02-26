module Temporizador(clk, clksaida, Selector);
	input clk, Selector;
	wire Contador010[6:0];
	wire clk_dividido;
	output wire clksaida;
	
	Contador010 X1(1,Contador010[0], clk);
	Contador010 X2(1, Contador010[1], Contador010[0]);
	Contador010 X3(1, Contador010[2], Contador010[1]);
	Contador010 X4(1, Contador010[3], Contador010[2]);
	Contador010 X5(1, Contador010[4], Contador010[3]);
	Contador010 X6(1, Contador010[5], Contador010[4]);
	Contador010 X7(1, Contador010[6], Contador010[5]);
	Contador010 X8(1, clk_dividido, Contador010[6]);
	
	assign clksaida = Selector ? clk_dividido : clk;

endmodule
