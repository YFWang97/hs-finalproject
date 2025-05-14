module pipeline_unit #
(
	parameter TRANS = 'd10
)
(
    input  wire         clk,
    input  wire         reset,
    input  wire [31:0]  inputs,
    input  wire         in_valid,
    input  wire         flush,
    output wire [31:0]  outputs, 
    output wire         out_valid
);

// actual pipeline stages here

// stage 1

// stage 2

// stage ...

	reg [31:0] 	data 	[2:0];
	reg			valid 	[2:0];

	integer cnt_data;
	integer cnt_valid;

	always @(posedge clk) begin	
		if (reset) begin
			for (cnt_data = 0 ; cnt_data < 3; cnt_data = cnt_data + 1) begin
				data[cnt_data] <= 'hFFFFFFFF;
			end
		end
		else if (flush) begin
			for (cnt_data = 0 ; cnt_data < 3; cnt_data = cnt_data + 1) begin
				data[cnt_data] <= 'hFFFFFFFF;
			end
		end
		else begin
			if (in_valid) begin
				data[0] <= inputs;
			end

			data[1] 	<= data[0] + TRANS;
			data[2]		<= data[1] + ^TRANS;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			for (cnt_valid = 0; cnt_valid < 3; cnt_valid = cnt_valid + 1) begin
				valid[cnt_valid] <= 0;
			end
		end
		else if (flush) begin
			for (cnt_valid = 0; cnt_valid < 3; cnt_valid = cnt_valid + 1) begin
				valid[cnt_valid] <= 0;
			end
		end
		else begin
			valid[0] <= in_valid;

			valid[2] <= valid[1];
			valid[1] <= valid[0];
		end
	end

	assign outputs = flush ? 'hFFFFFFFF : data[2];
	assign out_valid = flush ? 0 : valid[2];

endmodule
