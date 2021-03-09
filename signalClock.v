module signalClock(
	input wire clock,
	input wire countSignal,
	output reg preemptSignal
	);
	
	//If count == max -> pass to IR reset instruction (probably add mux);

	reg [5:0] counter;
	
	initial
	begin
		counter = 6'd0;
	end
	
	always@(posedge clock)
	begin
		
		//Received from Control Unit
		if(countSignal)
		begin
			if(counter == 6'b111111)
			begin
				preemptSignal = 1;
				counter = 6'd0;
			end
			else
			begin
				counter = counter+1;
				preemptSignal = 0;
			end
		end
		else
		begin
			preemptSignal = 0;
		end
		
	end

	
	

endmodule
