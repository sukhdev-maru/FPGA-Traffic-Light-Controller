`timescale 1ns/1ps

module traffic_light_ctrl (
    input clk,
    input rst,
    input sensor,
    output reg [1:0] hwy_light,
    output reg [1:0] cntry_light
);

// Light encoding
localparam RED    = 2'd0;
localparam YELLOW = 2'd1;
localparam GREEN  = 2'd2;

// FSM states
typedef enum reg [2:0] {
    HWY_GREEN  = 3'd0,
    HWY_YELLOW = 3'd1,
    ALL_RED    = 3'd2,
    CNTRY_GREEN= 3'd3,
    CNTRY_YELLOW=3'd4
} state_t;

state_t current_state, next_state;

reg [3:0] timer;

// State register
always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= HWY_GREEN;
        timer <= 0;
    end else begin
        current_state <= next_state;
        if (timer > 0)
            timer <= timer - 1;
    end
end

// Next-state logic
always @(*) begin
    next_state = current_state;

    case (current_state)
        HWY_GREEN:
            if (sensor) next_state = HWY_YELLOW;

        HWY_YELLOW:
            if (timer == 0) next_state = ALL_RED;

        ALL_RED:
            if (timer == 0) next_state = CNTRY_GREEN;

        CNTRY_GREEN:
            if (!sensor && timer == 0)
                next_state = CNTRY_YELLOW;

        CNTRY_YELLOW:
            if (timer == 0) next_state = HWY_GREEN;
    endcase
end

// Output logic
always @(*) begin
    hwy_light = GREEN;
    cntry_light = RED;

    case (current_state)
        HWY_YELLOW: hwy_light = YELLOW;
        ALL_RED:    hwy_light = RED;
        CNTRY_GREEN: begin
            hwy_light = RED;
            cntry_light = GREEN;
        end
        CNTRY_YELLOW: begin
            hwy_light = RED;
            cntry_light = YELLOW;
        end
    endcase
end

// Timer load logic
always @(posedge clk or posedge rst) begin
    if (rst)
        timer <= 0;
    else begin
        case (next_state)
            HWY_YELLOW:  timer <= 3;
            ALL_RED:     timer <= 2;
            CNTRY_YELLOW:timer <= 3;
        endcase
    end
end

endmodule