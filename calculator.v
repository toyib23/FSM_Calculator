module calculator(clk,rst,signal_input,data_in,data_out);
	
	input clk,rst;
	input[1:0] signal_input;
	input[7:0] data_in;


	output reg[15:0] data_out;
	wire[15:0] data_komputasi;
	reg[7:0] data_a,data_b;


	reg[1:0] reg_signal_input;
	reg[1:0] current_state,next_state;

	initial
		begin
			current_state = 2'd0;
			reg_signal_input = 2'b00;
			data_a = 16'd0;
			data_b = 16'd0;
			data_out = 16'd0;
		end

	//
	always @(posedge clk or negedge rst) 
		begin
			if (!rst) 
				begin
					current_state <= 2'b00;//Mode Input Angka
				end
			else 
				begin
					current_state <= next_state;
				end
		end

	//State per State Analysis
	always @(signal_input or current_state or data_in)
		begin
			case (current_state)
				2'b00: begin  //State masuk angka pertama kali
							if (signal_input == 2'b00)
								begin
									next_state = 2'b00;
									data_out = data_komputasi;
									data_a <= 8'd0;
									data_b <= 8'd0;
									data_out <= 16'd0;
									reg_signal_input <= 2'd0;
								end
							else 
								begin
									next_state =  2'b01;
									reg_signal_input = signal_input;
									data_out = data_in;
									data_a = data_in;
								end
						 end
				2'b01: begin//State tombol tertekan
							if (signal_input)
								begin
									next_state = 2'b01;
								end
							else 
								begin
									next_state= 2'b10;//Tombol dilepas
								end
						 end
				2'b10: begin //State setelah tombol dilepas. Pemasukan Nilai lagi
							if (signal_input == 2'd0)
								begin
									next_state = 2'b10;
									data_b = data_in;
								end
							else
								begin
									data_out = data_komputasi;
									data_a = data_out;
									next_state = 2'b01;
									reg_signal_input = signal_input;
								end
						 end

			endcase
		end

	Arithmetic_Unit alu1(reg_signal_input,data_a,data_b,data_komputasi);


endmodule