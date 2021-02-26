module ControlUnit(
	input [5:0] OPCode, 
	output wire [46:0] ControlSignals, 
	input subiu,
	input desceu,
	input clk,
	input reset);
	
	//Wires and regs block
	wire [2:0] CurrentState, NextState;
	
	ControlUnitCurrentState CTRCURR(NextState, CurrentState, clk, reset);
	ControlUnitNextState CTRNXT(NextState, CurrentState, clk, OPCode, subiu, desceu);
	ControlUnitOutput CTRLOUT(OPCode, CurrentState, ControlSignals);
	
endmodule
