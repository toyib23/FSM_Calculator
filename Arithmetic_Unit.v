module Arithmetic_Unit(signal,data_in_a,data_in_b,data_out);
	
	input[1:0] signal;
	input[7:0] data_in_a,data_in_b;


	output reg[15:0] data_out;

	initial
		begin
			data_out = 16'd0;
		end

	always @(signal or data_in_a or data_in_b)
		begin
			if (signal == 2'b01)
				data_out = data_in_a + data_in_b;
			else if (signal == 2'b10)
				data_out = data_in_a - data_in_b;
			else if (signal == 2'b11)
				data_out = data_in_a*data_in_b;
		end

endmodule