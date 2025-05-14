// Placeholder for producer FSM
module producer_fsm (
    input  wire        clk,
    input  wire        reset,
    output wire [31:0] pipeline1_inputs,
    output wire [31:0] pipeline2_inputs,
    output wire [1:0]  in_valid,
    output wire        flush_1,
    output wire        flush_2
);
// Producer logic placeholder
	reg [3:0] addr1;
	reg [3:0] addr2;

	always @(posedge clk) begin
		if (reset) addr1 <= 'd0;
		else addr1 <= addr1 + 'd1;
	end

	always @(posedge clk) begin
		if (reset) addr2 <= 'd0;
		else addr2 <= addr2 + 'd1;
	end

	assign pipeline1_inputs = addr1;
	assign pipeline2_inputs = addr2;

	assign in_valid[0] = (addr1 >= 'd0 && addr1 <= 'd8);
	assign in_valid[1] = (addr2 == 'd2 || addr2 == 'd3);

	assign flush_1 = (addr1 == 'd15);
	assign flush_2 = (addr2 == 'd15);
endmodule
