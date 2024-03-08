module SineWaveGenerator_tb;

  // Signals
  logic clk = 0;
  logic rst = 0;
  logic signed [15:0] sine_wave;

  // Instantiate DUT
  SineWaveGenerator dut (
    .clk(clk),
    .rst(rst),
    .sine_wave(sine_wave)
  );

  // Clock generation
  always begin
	#5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst = 1;
    #5;
    rst = 0;
  end

  // Stimulus
  initial begin
    //#1000; // Wait for a while to observe the waveform

  end

endmodule
