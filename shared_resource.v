module shared_resource (
	input 	wire	clk,
	input 	wire	reset,
	input 	wire [31:0] resource_input,
	output 	wire [31:0] resource_output
);

	reg [31:0] mem_out;

	assign resource_output = mem_out;

	always @(posedge clk) begin
		if (reset) begin
			mem_out <= 'd0;
		end
		else begin	
			case (resource_input)
				'd1  : mem_out <= 'd92;
				'd2  : mem_out <= 'd48;
				'd3  : mem_out <= 'd41;
				'd4  : mem_out <= 'd33;
				'd5  : mem_out <= 'd28;
				'd6  : mem_out <= 'd35;
				'd7  : mem_out <= 'd86;
				'd8  : mem_out <= 'd41;
				'd9  : mem_out <= 'd57;
				'd10 : mem_out <= 'd67;
				'd11 : mem_out <= 'd12;
				'd12 : mem_out <= 'd27;
				'd13 : mem_out <= 'd6;
				'd14 : mem_out <= 'd77;
				'd15 : mem_out <= 'd89;
				'd16 : mem_out <= 'd14;
				'd17 : mem_out <= 'd67;
				'd18 : mem_out <= 'd85;
				'd19 : mem_out <= 'd64;
				'd20 : mem_out <= 'd86;
				'd21 : mem_out <= 'd7;
				'd22 : mem_out <= 'd7;
				'd23 : mem_out <= 'd91;
				'd24 : mem_out <= 'd69;
				'd25 : mem_out <= 'd86;
				'd26 : mem_out <= 'd46;
				'd27 : mem_out <= 'd34;
				'd28 : mem_out <= 'd5;
				'd29 : mem_out <= 'd92;
				'd30 : mem_out <= 'd25;
				'd31 : mem_out <= 'd97;
				'd32 : mem_out <= 'd25;
				'hFFFFFFFF : 	mem_out <= 'hFFFFFFFF;
				default:		mem_out <= 'hFFFFFFFF;
			endcase
		end
	end
endmodule
