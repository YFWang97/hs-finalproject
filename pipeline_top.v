module pipeline_top (
    input  wire         clk,
    input  wire         reset,
    input  wire [31:0]  inputs,
    input  wire         in_valid,
    input  wire         flush,
    output wire [31:0]  outputs,
    output wire         out_valid,
    output wire         arbiter_req,
    input  wire         arbiter_grant,
    output wire [31:0]  resource_input,
    input  wire [31:0]  resource_output
);

    wire [31:0] pipeline_unit_outputs;
    wire stall_signal;
    wire to_stall_mgmt_signal;
    wire _in_valid, _out_valid;
	
	reg arbiter_req_delayed;

	always @(posedge clk) begin
		if (reset) begin
			arbiter_req_delayed <= 0;
		end else begin
			arbiter_req_delayed <= arbiter_req;
		end
	end

	assign stall_signal = arbiter_req_delayed && ~arbiter_grant;

    // Assign and manage valid signals
    assign _in_valid  = in_valid;  
    //assign out_valid = _out_valid;

    pipeline_unit pipeline_unit_inst (
        .clk      (clk),
        .reset    (reset),
        .inputs   (inputs),
        .in_valid (_in_valid),
        .flush    (flush),
        .outputs  (pipeline_unit_outputs),
        .out_valid(_out_valid)
    );

    buffer_slots buffer_slots_inst (
        .clk           (clk),
        .reset         (reset),
        .inputs        (pipeline_unit_outputs),
		.push		   (_out_valid),
        .stall         (stall_signal),
        .outputs       (outputs),
		.valid		   (out_valid),
        .to_stall_mgmt (to_stall_mgmt_signal)
    );

    stall_mgmt stall_mgmt_inst (
        .clk           (clk),
        .reset         (reset),
        .stall_input   (stall_signal),
        .to_stall_mgmt (to_stall_mgmt_signal),
        .stall_output  (stall_signal)
    );

    flush_mgmt flush_mgmt_inst (
        .clk               (clk),
        .reset             (reset),
        .flush_mgmt_input  (flush),
        .flush_mgmt_output () // Connect as necessary
    );

    // Placeholder signals to demonstrate arbiter interaction
    assign arbiter_req    = out_valid; /* pipeline logic request */
    assign resource_input = pipeline_unit_outputs; /* pipeline logic output for shared resource */
    // Use resource_output as necessary within the pipeline logic

endmodule
