module PWM (
    input wire clk,
    input wire rst_n,
    input wire [31:0] duty_cycle, // duty cycle final = duty_cycle / period
    input wire [31:0] period,     // pwm_freq = clk_freq / period
    output wire pwm_out
);

    // Instancia o módulo PWM parametrizado com WIDTH = 32
    PWM_Parametrizado #( .WIDTH(32) ) u_pwm_32bit (
        .clk        (clk),
        .rst_n      (rst_n),
        .duty_cycle (duty_cycle),
        .period     (period),
        .pwm_out    (pwm_out)
    );

endmodule
