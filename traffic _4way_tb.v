
`timescale 1ns/1ps

module traffic_4way_tb;

reg clk = 0;
reg reset = 1;

wire ns_red, ns_yellow, ns_green;
wire ew_red, ew_yellow, ew_green;

traffic_4way uut (
    .clk(clk),
    .reset(reset),
    .ns_red(ns_red),
    .ns_yellow(ns_yellow),
    .ns_green(ns_green),
    .ew_red(ew_red),
    .ew_yellow(ew_yellow),
    .ew_green(ew_green)
);

always #5 clk = ~clk;

initial begin
    $monitor(
        "Time=%0t | NS RYG=%b%b%b | EW RYG=%b%b%b",
        $time, ns_red, ns_yellow, ns_green,
        ew_red, ew_yellow, ew_green
    );

    #12 reset = 0;
    #80 $finish;
end

endmodule
