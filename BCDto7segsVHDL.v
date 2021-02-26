module BCDto7SegsVHDL(Entrada, Saida);
	input [3:0]Entrada;
	output reg [6:0]Saida;
	always @(*)
	begin
		case(Entrada)
			4'b0000:Saida = 7'b0000001;
			4'b0001:Saida = 7'b1001111;
			4'b0010:Saida = 7'b0010010;
			4'b0011:Saida = 7'b0000110;
			4'b0100:Saida = 7'b1001100;
			4'b0101:Saida = 7'b0100100;
			4'b0110:Saida = 7'b1100000;
			4'b0111:Saida = 7'b0001111;
			4'b1000:Saida = 7'b0000000;
			4'b1001:Saida = 7'b0001100;
			default:Saida = 7'b1111111;
		endcase
	end	
		
	
endmodule
