module buffer_slots (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] inputs,
    input  wire        stall,
	input  wire		   push,
    output reg [31:0]  outputs,
	output reg		   valid,
    output wire        to_stall_mgmt
);
    // Stall and Regular Slots 
	
	reg [31:0] stall_slots [7:0];
	reg stalled;

	assign to_stall_mgmt = stalled;

	always @(posedge clk) begin
		if (reset) begin
			stalled <= 0;
		end else begin
			if (stall) stalled <= 1;
			else stalled <= 0;
		end
	end

	reg [4:0] wr_ptr, rd_ptr;
	reg [4:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 'd0;
			wr_ptr <= 'd0;
			rd_ptr <= 'd0;
			outputs <= 'hFFFFFFFF;
			valid <= 0;
		end
		else begin
			if (push) begin
				if (!stall) begin
					outputs <= inputs;
					valid	<= 1;
				end else begin
					valid <= 0;
					stall_slots[wr_ptr] <= inputs;
					wr_ptr 	<= wr_ptr + 'd1;
					count	<= count + 'd1;
				end
			end else begin
				if (count == 'd0) begin
					valid <= 0;
					outputs <= 'hFFFFFFFF;
				end 
				else if (count != 'd0 && !stall) begin
					valid <= 1;
					outputs <= stall_slots[rd_ptr];
					rd_ptr	<= rd_ptr + 'd1;
					count	<= count - 'd1;
				end
			end
		end
	end

endmodule
