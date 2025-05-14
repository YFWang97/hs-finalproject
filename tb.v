`timescale 1ns/1ps
module tb();

	reg clk;
	reg reset;

	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		reset = 1;
		#10;
		reset = 0;
		#200;
		$stop();
	end

	top_system top_inst (
		.clk(clk),
		.reset(reset)
	);
endmodule
