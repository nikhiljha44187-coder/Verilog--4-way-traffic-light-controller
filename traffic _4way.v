
module traffic_4way (
    input clk,
    input reset,
    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,
    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green
);

reg [2:0] state;

localparam NS_GREEN  = 3'd0;
localparam NS_YELLOW = 3'd1;
localparam ALL_RED_1 = 3'd2;
localparam EW_GREEN  = 3'd3;
localparam EW_YELLOW = 3'd4;
localparam ALL_RED_2 = 3'd5;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= NS_GREEN;
    else begin
        case (state)
            NS_GREEN:  state <= NS_YELLOW;
            NS_YELLOW: state <= ALL_RED_1;
            ALL_RED_1: state <= EW_GREEN;
            EW_GREEN:  state <= EW_YELLOW;
            EW_YELLOW: state <= ALL_RED_2;
            ALL_RED_2: state <= NS_GREEN;
            default:   state <= NS_GREEN;
        endcase
    end
end

always @(*) begin
    ns_red = 0;
    ns_yellow = 0;
    ns_green = 0;
    ew_red = 0;
    ew_yellow = 0;
    ew_green = 0;

    case (state)
        NS_GREEN: begin
            ns_green = 1;
            ew_red = 1;
        end
        NS_YELLOW: begin
            ns_yellow = 1;
            ew_red = 1;
        end
        ALL_RED_1, ALL_RED_2: begin
            ns_red = 1;
            ew_red = 1;
        end
        EW_GREEN: begin
            ns_red = 1;
            ew_green = 1;
        end
        EW_YELLOW: begin
            ns_red = 1;
            ew_yellow = 1;
        end
        default: begin
            ns_red = 1;
            ew_red = 1;
        end
    endcase
end

endmodule
