module consumer_fsm (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] pipeline1_outputs,
    input  wire [31:0] pipeline2_outputs, 
    input  wire [1:0]  valid
);
// Consumer logic placeholder

	reg [31:0] data [1:0];

	always @(posedge clk) begin	
		if (reset) begin
			data[0] <= 'd0;
			data[1] <= 'd0;
		end
		else begin
			//What to do with the output
			data[0] <= valid[0] ? pipeline1_outputs : data[0];
			data[1] <= valid[1] ? pipeline2_outputs : data[1];
		end	
	end


endmodule
