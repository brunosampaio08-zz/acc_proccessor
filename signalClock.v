module signalClock(
	input wire clock,
	input wire startCountSignal,
	output wire preemptSignal
	);
	
	//If count == max -> pass to IR reset instruction (probably add mux);

	reg [5:0] counter;
	reg count;
	
	initial
	begin
		counter = 6'd0;
		count = 1'd0;
	end
	
	always@(posedge clock)
	begin
		
		//Received from Control Unit
		if(startCountSignal)
		begin
			//If receives signal, start counting clock cycles
			count = 1'b1;
		end
		
		
		else if(count)
		begin
			//If reached max clock signals
			if(counter == 6'b111111)
			begin
				//Preempt (reset PC to 0 by changing instruction register to reset)
				preemptSignal = 1;
				counter = 6'd0;
			end
			else
			begin
				//Else, increase clock counter
				preemptSignal = 0;
				counter = counter+1;
			end
		end
		
	end

	
	

endmodule
