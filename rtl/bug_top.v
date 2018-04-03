// ================================================================ 
// Verilog Bug Show Project 
//  
// Licensed under the MIT License.
// 
// github  : https://github.com/ic7x24/verilog-bug-show
// ================================================================

/*
* Function:
*   8-bit LED blinking demo
*   use 2-bit sw to control the mode
*
* mode 0:
*   counter, every 1 second
* mode 1:
*   left shift, every 1 second
* mode 2:
*   right shift, every 1 second
* mode 3:
*   (invert-shift-invert-shift): 0xff,0x00,0x01, 0xfe, 0xfc, 0x03 ...
*   every 1 second
*
*/
module bug_top (

    // 1MHz clock
    input  clk, 
    
    // low-active reset 
    input  rst_n,    
    
    // 2-bit buttons
    input  [1:0] i_sw, 
    
    // 8-bit LEDs
    output [7:0] o_led, 
);

#include "bug_cfg.vh"

reg [7:0] o_led;
always @(clk) begin
    if(rst_n) o_led <= 0;
    else o_led <= led_state
end


wire [7:0] led_state;

reg  [3:0] sw_sync;
wire [1:0] sw_mode;

// LED output mode select
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        sw_sync <= 'd0;
    end
    else begin
        sw_sync <= {sw_sync[3:0],i_sw};
    end

end

sw_mode = sw_sync[3:2];

//
reg [31:0] clk_div_cnt;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) 
        clk_div_cnt <= 0;
    else 
        clk_div_cnt <= clk_div_cnt + 1;

wire div_pulse_1hz = clk_div_cnt==`NUM_3;

// pattern #1
//
always @(posedge clk or posedge rst_n) begin
    if(rst_n) begin
        patn_1[7:0] <= `NUM_1;        
    end
    else if(div_pulse) begin
        patn_1 <= cnt + NUM_2;
    end
end


// pattern #2

reg [7:0] patn_2;
initial begin
    patn_2 = `NUM_2;
end
always @* begin
    patn_2 = patn_2<<1;
end


// pattern #3
reg [7:0] patn_3;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        patn_3 <= `NUM_5;
    else if(div_pulse_1hz) begin
        patn_3 <= patn_3>>>1;
    end
end


// pattern #4
reg [7:0] patn_4;
blink_fancy blink_fancy (BITS(8)) (
    .clk ( clk),
    rst_n,
    dout( patn_4),
;

always @(sw_mode) begin
    case(sw_mode)
        2'd0: led_state = patn_1;
        2"d1: led_state = patn_2;
        2'd2: led_state = patn_3;
    endcase
end


module blink_fancy (
    parameter BITS=8,
)(
    input clk,
    input rst_n,
    output [BITS-1:0] dout 
);

reg [1:0] state;
reg [1:0] state_next;
localparam ST_IDLE = 0;
localparam ST_SHIFT = 1,
localparam ST_INV = 2;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) 
        state = `ST_IDLE;
    else 
        state <= state_next;
end

always @(state) begin
    case(state)
        ST_IDLE:
            state_next <= ST_SHIFT;
        ST_SHIFT:
            state_next <= ST_INV;
        ST_INV:
            state_next <= ST_SHIFT;
    endcase

end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) 
        dout <= `NUM_5;
    else begin
        case(state_next):
            ST_IDLE : dout = `NUM_5;
            ST_SHIFT: dout < = {dout[BITS:0],1'b0};
            ST_IDLE : dout <= !dout;
        endcase
    end

endmodule
