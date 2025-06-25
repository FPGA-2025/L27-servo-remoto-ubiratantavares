module servo #(
    parameter CLK_FREQ = 25_000_000, // 25 MHz
    parameter PERIOD = 500_000 // 50 Hz (1/50s = 20ms, 25MHz / 50Hz = 500000 cycles)
) (
    input wire clk,
    input wire rst_n,
    output wire servo_out
);

	// definindo parâmetros e constantes
	localparam PWM_FREQ_HZ = 50; // frequencia do sinal PWM para o servo motor
	localparam PWM_PERIOD_MS = 20; // duração total do período PWM (1/50 Hz = 0,2.10⁻¹ = 20.10².10⁻¹ = 20 ms)
	localparam MIN_PULSE_MS = 1; // largura do pulso para excursão mínima (1 ms)
	localparam MAX_PULSE_MS = 2; // largura do pulso para excursão máxima (2 ms)

	// calculando os valores duty_cycle em ciclos de clock
	// (período em ciclos / período em ms) * largura do pulso em ms
	localparam MIN_DUTY_CYCLE_VAL = (PERIOD / PWM_PERIOD_MS) * MIN_PULSE_MS;
	localparam MAX_DUTY_CYCLE_VAL = (PERIOD / PWM_PERIOD_MS) * MAX_PULSE_MS;

	// duração de cada excursão (mínima ou máxima) em segundos (5 s)
	localparam EXCURSION_DURATION_SEC = 5;

	// número de ciclos de clock para o contador de 5 segundos 
	// 5 seg * 25 MHz = 125_000_000 ciclos: subtrair 1 se contador for de 0 a N - 1
	localparam FIVE_SEC_COUNTER_LIMIT = EXCURSION_DURATION_SEC * CLK_FREQ;

	// declarando os sinais
	// contador para os intervalos de 5 segundos
	reg [31:0] five_sec_counter;

	// registrador para armazenar o valor atual do duty cycle a ser enviado ao PWM
	reg[31:0] current_duty_cycle;

	// registrador para controlar o estado da excursão
	reg current_excursion_state; // 0 para mínima e 1 para máxima

	// saida intermediária do submódulo PWM
	wire pwm_output_from_submodule;

	// instanciação do submódulo PWM
	// utiliza o módulo PWM de 32 bits
	PWM u_pwm_generator (
        .clk        (clk),
        .rst_n      (rst_n),
        .duty_cycle (current_duty_cycle), // conecta o duty cycle selecionado internamente
        .period     (PERIOD),             // período fixo do PWM
        .pwm_out    (pwm_output_from_submodule)
		
	);

	// conecta a saída do PWM gerado para a saída principal do módulo servo
	assign servo_out = pwm_output_from_submodule;

	

	// lógica de controle da excursão do servo
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			five_sec_counter <= 32'h0; // zera o contador
			current_excursion_state <= 1'b0; // inicia na excursão mínima
			current_duty_cycle <= MIN_DUTY_CYCLE_VAL; // define o duty cycle inicial
		end else begin
			// lógica para o contador de 5 segundos e troca de estado
			if (five_sec_counter == (FIVE_SEC_COUNTER_LIMIT - 1)) begin
				five_sec_counter <= 32'h0;   // reinicializa o contador em 0
				current_excursion_state <= ~current_excursion_state; // inverte o estado
			end else begin
				five_sec_counter <= five_sec_counter + 1; // incrementa o contador
			end

			// lógica para atualizar o duty cycle com base no estado da excursão
			if (current_excursion_state == 1'b0) begin // excursão mínima
				current_duty_cycle <= MIN_DUTY_CYCLE_VAL;
			end else begin
				current_duty_cycle <= MAX_DUTY_CYCLE_VAL;
			end
		end
	end
endmodule
