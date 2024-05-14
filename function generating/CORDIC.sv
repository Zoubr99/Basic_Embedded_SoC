module cordic_sine_generator(
    input logic clk,
    input logic signed [15:0] angle_in,
    output logic signed [15:0] sine_out
);

// Parameters for CORDIC
parameter N = 16; // Number of iterations
parameter ANGLE_WIDTH = 16; // Width of the angle input
parameter COORD_WIDTH = 32; // Width of coordinate variables
parameter ANGLE_PRECISION = 16'b0110_0000_0000_0000; // Precision up to 45 degrees

// Internal variables
logic signed [COORD_WIDTH-1:0] x;
logic signed [COORD_WIDTH-1:0] y;
logic signed [ANGLE_WIDTH-1:0] z;

always_ff @(posedge clk) begin
    // Initialize the variables
    x <= 0;
    y <= 0;
    z <= angle_in;

    // CORDIC iterations
    for (int i = 0; i < N; i++) begin
        logic signed [COORD_WIDTH-1:0] x_temp;
        logic signed [ANGLE_WIDTH-1:0] z_temp;

        if (z[ANGLE_WIDTH-1] == 1'b0) begin
            x_temp = x + (y >> i);
            y = y - (x >> i);
            z_temp = z + (1 << (i + 1));
        end
        else begin
            x_temp = x - (y >> i);
            y = y + (x >> i);
            z_temp = z - (1 << (i + 1));
        end

        x = x_temp;
        z = z_temp;
    end

    // Output sine value
    sine_out = y >> (COORD_WIDTH - ANGLE_PRECISION);
end

endmodule

