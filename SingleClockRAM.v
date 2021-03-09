// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module SingleClockRAM 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=15)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	//All instructions
	parameter
		CPY = 6'd0,
		CPX = 6'd1,
		CMP = 6'd2,
		ASL = 6'd3,
		ANDI = 6'd4,
		AND = 6'd5,
		ADCI = 6'd6,
		ADC = 6'd7,
		SBCI = 6'd9,
		SBC = 6'd10,
		ORAI = 6'd11,
		ORA = 6'd12,
		LSR = 6'd13,
		EORI = 6'd14,
		EOR = 6'd15,
		STX = 6'd16,
		STA = 6'd17,
		LDYI = 6'd18,
		LDY = 6'd19,
		LDXI = 6'd20,
		LDX = 6'd21,
		LDAI = 6'd22,
		LDA = 6'd23,
		TXS = 6'd25,
		TSX = 6'd26,
		PLP = 6'd27,
		PLA = 6'd28,
		PHP = 6'd29,
		PHA = 6'd30,
		STY = 6'd31,
		RTS = 6'd33,
		JSR = 6'd34,
		JMP = 6'd35,
		BPL = 6'd36,
		BNE = 6'd37,
		BMI = 6'd38,
		BEQ = 6'd39,
		CLV = 6'd45,
		CLN = 6'd46,
		CLZ = 6'd47,
		TYA = 6'd48,
		TXA = 6'd49,
		TAY = 6'd50,
		TAX = 6'd51,
		INY = 6'd52,
		INX = 6'd53,
		DEY = 6'd54,
		DEX = 6'd55,
		OUP = 6'd59,
		INT = 6'd60,
		NOP = 6'd62,
		BRK = 6'd63;
	//End of instructions block
	
	initial
	begin
		$readmemb("memstart.txt", ram, 0);
	end
	
	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;

		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg];

endmodule
