module arbiter (
    input  wire clk,
    input  wire reset,
    input  wire req_1,
    input  wire req_2,
    output wire grant_1,
    output wire grant_2
);
// Arbitration logic placeholder
	
	reg grant_1_reg;
	reg grant_2_reg;

	assign grant_1 = grant_1_reg;
	assign grant_2 = grant_2_reg;

	reg [3:0] grant_1_cnt;

	always @(posedge clk) begin
		if (reset) grant_1_cnt <= 'd0;
		else if (grant_1_reg) grant_1_cnt <= (grant_1_cnt == 'd5) ? 'd5 : (grant_1_cnt + 'd1);
		else if (grant_2_reg) grant_1_cnt <= 'd0;
	end

	always @(posedge clk) begin	
		if (reset) begin	
			grant_1_reg <= 0;
			grant_2_reg <= 0;
		end
		else begin
			case ({req_2, req_1})
				2'b01: begin
						grant_1_reg <= 1;
						grant_2_reg <= 0;
				end
				2'b10: begin
					grant_1_reg <= 0;
					grant_2_reg <= 1;
				end
				2'b11: begin
					if (grant_1_cnt != 'd5) begin
						grant_1_reg <= 1;
						grant_2_reg <= 0;
					end else begin
						grant_1_reg <= 0;
						grant_2_reg <= 1;
					end
				end
				2'b00: begin
					grant_1_reg <= 0;
					grant_2_reg <= 0;
				end
			endcase
		end
	end
endmodule
