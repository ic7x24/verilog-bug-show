// ================================================================ 
// Verilog Bug Show Project 
//  
// Licensed under the MIT License.
// 
// github  : https://github.com/ic7x24/verilog-bug-show
// ================================================================
`timescale 1ns/10ps 

//--------------------------------------------------------------------------- 
// TestBench parameters
//  
//  options to use:
//  - `define 
//  - parameter
//  - localparam
//  - `include tb_parameter.vh
//  
//--------------------------------------------------------------------------- 

`define CLOCK_CYCLE   1000    // clock period (1/freq)
`define RESET_PERIOD  100*CLOCK_CYCLE   // reset period
`define MAX_RUN_TIME  10000*CLOCK_CYCLE // maximum simulation time 


//--------------------------------------------------------------------------- 
// TestBench Top Module
//  - no input/output/inout ports list required  
//--------------------------------------------------------------------------- 
module tb;

//--------------------------------------------------------------------------- 
// Clock & reset generation
//  - simple
//  - or make it more programmable
//
//--------------------------------------------------------------------------- 
reg clk;
reg rst_n;

initial begin
    clk = 0;
end

// Be careful if CLOCK_CYCLE%2 !=0
always #(`CLOCK_CYCLE/2) clk=~clk;

//--------------------------------------------------------------------------- 
// simple reset() task
//
//--------------------------------------------------------------------------- 
task reset;
    begin
    rst_n = 0;
    #`RESET_PERIOD rst_n = 1;
    end
endtask

//--------------------------------------------------------------------------- 
// stimulus generator
//
//--------------------------------------------------------------------------- 
reg [1:0] sw;

initial begin
    sw = 0;
    reset;
    #500*CLOCK_CYCLE sw = 1;
    #500*CLOCK_CYCLE sw = 2;
    #500*CLOCK_CYCLE sw = 3;
    #500*CLOCK_CYCLE sw = 2;
    #500*CLOCK_CYCLE sw = 1;
    #500*CLOCK_CYCLE sw = 0;
    #500*CLOCK_CYCLE sw = 3;
    #500*CLOCK_CYCLE sw = 1;
    #500*CLOCK_CYCLE sw = 2;
    #500*CLOCK_CYCLE sw = 0;
end

mini_top u_DUT (
    .clk       ( clk    ) ,
    .rst_n     ( rst_n  ) ,
    .i_sw      ( sw     ) ,
    .o_led     (        ) 
);


// use +define+DUMP_FSDB in vsim command
// to enable fsdb file dump
//
`ifdef DUMP_FSDB 
initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0,tb);
    #`MAX_RUN_TIME
    $finish(2);
end
`endif

endmodule
