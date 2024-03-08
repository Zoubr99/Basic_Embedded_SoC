module SineWaveGenerator (
    input logic clk,       // Clock input
    input logic rst,       // Reset input
    output logic signed [15:0] sine_wave // Sine wave output
);

// Define parameters
parameter integer N = 1024;  // Number of points in the sine wave
parameter integer WIDTH = 16; // Width of the sine wave output

// Define sine wave lookup table
logic signed [WIDTH-1:0] sine_table [0:N-1];

// Generate sine wave lookup table
initial begin
    integer i;
    for (i = 0; i < N; i = i + 1) begin
        sine_table[i] = $signed($rtoi(32767 * sin(2 * $itor(i) * $real(3.14159) / $itor(N))));
    end
end

// Sine wave generator
logic [31:0] phase_accumulator;
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        phase_accumulator <= 0;
    end else begin
        phase_accumulator <= phase_accumulator + 100; // Adjust frequency here
    end
end

// Output the sine wave
assign sine_wave = sine_table[phase_accumulator[31:20]];

endmodule
