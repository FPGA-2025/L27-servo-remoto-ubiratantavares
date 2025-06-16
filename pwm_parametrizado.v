module PWM_Parametrizado # (
	parameter WIDTH = 16  // parâmetro para definir a largura em bits
) (
	input wire clk,
	input wire rst_n,
	input wire [WIDTH-1:0] duty_cycle // duty_cycle = period * duty_porcent, 0 <= duty_porcent <= 1
	input wire [WIDTH-1:0] period, // period = clk_freq / pwm_freq
	output reg pwm_out
);

    reg [WIDTH-1:0] pwm_counter; // Contador agora é de largura variável

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin // reset assíncrono, ativo em nível baixo
            pwm_counter <= {WIDTH{1'b0}}; // reset para todos os bits
            pwm_out <= 1'b0;
        end else begin
            // Incrementa o contador, reinicia se atingir o período
            pwm_counter <= (pwm_counter >= (period - 1)) ? {WIDTH{1'b0}} : pwm_counter + 1;
            // Gera o sinal PWM
            pwm_out <= (pwm_counter < duty_cycle) ? 1'b1 : 1'b0;
        end
    end
 endmodule
