module SineWaveGenerator (
    input logic clk,       // Clock input
    input logic rst,       // Reset input
    output logic signed [15:0] sine_wave // Sine wave output
);

// Define parameters
parameter integer N = 256;  // Number of points in the sine wave
parameter integer WIDTH = 16; // Width of the sine wave output

// Pre-built sine wave lookup table
    reg [7:0] sine_table[0:255] = 
    '{
8'd0, 8'd0, 8'd2, 8'd3, 8'd4,
8'd5, 8'd7, 8'd9, 8'd10, 8'd11, 8'd12, 8'd13, 8'd14, 8'd15, 
8'd16, 8'd17, 8'd18, 8'd19, 8'd20, 8'd21, 8'd22, 8'd23, 
8'd24, 8'd25, 8'd26, 8'd27, 8'd28, 8'd29, 8'd30, 8'd31, 
8'd32, 8'd33, 8'd34, 8'd35, 8'd36, 8'd37, 8'd38, 8'd39, 
8'd40, 8'd41, 8'd42, 8'd43, 8'd44, 8'd45, 8'd46, 8'd47, 
8'd48, 8'd49, 8'd50, 8'd51, 8'd52, 8'd53, 8'd54, 8'd55, 
8'd56, 8'd57, 8'd58, 8'd59, 8'd60, 8'd61, 8'd62, 8'd63, 
8'd64, 8'd65, 8'd66, 8'd67, 8'd68, 8'd69, 8'd70, 8'd71, 
8'd72, 8'd73, 8'd74, 8'd75, 8'd76, 8'd77, 8'd78, 8'd79, 
8'd80, 8'd81, 8'd82, 8'd83, 8'd84, 8'd85, 8'd86, 8'd87, 
8'd88, 8'd89, 8'd90, 8'd91, 8'd92, 8'd93, 8'd94, 8'd95, 
8'd96, 8'd97, 8'd98, 8'd99, 8'd100, 8'd101, 8'd102, 8'd103, 
8'd104, 8'd105, 8'd106, 8'd107, 8'd108, 8'd109, 8'd110, 8'd111, 
8'd112, 8'd113, 8'd114, 8'd115, 8'd116, 8'd117, 8'd118, 8'd119, 
8'd120, 8'd121, 8'd122, 8'd123, 8'd124, 8'd125, 8'd126, 8'd126, 8'd127, 8'd127, 8'd127, 8'd127, 8'd126,
8'd126, 8'd125, 8'd124, 8'd123, 8'd122, 8'd121, 8'd120, 8'd119, 
8'd118, 8'd117, 8'd116, 8'd115, 8'd114, 8'd113, 8'd112, 8'd111, 
8'd110, 8'd109, 8'd108, 8'd107, 8'd106, 8'd105, 8'd104, 8'd103, 
8'd102, 8'd101, 8'd100, 8'd99, 8'd98, 8'd97, 8'd96, 8'd95, 
8'd94, 8'd93, 8'd92, 8'd91, 8'd90, 8'd89, 8'd88, 8'd87, 
8'd86, 8'd85, 8'd84, 8'd83, 8'd82, 8'd81, 8'd80, 8'd79, 
8'd78, 8'd77, 8'd76, 8'd75, 8'd74, 8'd73, 8'd72, 8'd71, 
8'd70, 8'd69, 8'd68, 8'd67, 8'd66, 8'd65, 8'd64, 8'd63, 
8'd62, 8'd61, 8'd60, 8'd59, 8'd58, 8'd57, 8'd56, 8'd55, 
8'd54, 8'd53, 8'd52, 8'd51, 8'd50, 8'd49, 8'd48, 8'd47, 
8'd46, 8'd45, 8'd44, 8'd43, 8'd42, 8'd41, 8'd40, 8'd39, 
8'd38, 8'd37, 8'd36, 8'd35, 8'd34, 8'd33, 8'd32, 8'd31, 
8'd30, 8'd29, 8'd28, 8'd27, 8'd26, 8'd25, 8'd24, 8'd23, 
8'd22, 8'd21, 8'd20, 8'd19, 8'd18, 8'd17, 8'd16, 8'd15, 
8'd14, 8'd13, 8'd12, 8'd11, 8'd10, 8'd8, 8'd7, 8'd6, 8'd5, 
8'd3, 8'd1, 8'd0, 8'd0
    };


// Sine wave generator
logic [7:0] phase_counter;
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        phase_counter <= 0;
    end else begin
        phase_counter <= phase_counter + 1; // Increment phase counter
    end
end

// Output the sine wave
assign sine_wave = sine_table[phase_counter];

endmodule
