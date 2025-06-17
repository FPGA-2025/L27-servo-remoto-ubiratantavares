#! /usr/local/bin/vvp
:ivl_version "13.0 (devel)" "(s20250103-26-gb0c57ab17)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "/usr/local/lib/ivl/system.vpi";
:vpi_module "/usr/local/lib/ivl/vhdl_sys.vpi";
:vpi_module "/usr/local/lib/ivl/vhdl_textio.vpi";
:vpi_module "/usr/local/lib/ivl/v2005_math.vpi";
:vpi_module "/usr/local/lib/ivl/va_math.vpi";
S_0x624168ce4210 .scope module, "PWM_Parametrizado" "PWM_Parametrizado" 2 1;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 1 "rst_n";
    .port_info 2 /INPUT 16 "duty_cycle";
    .port_info 3 /INPUT 16 "period";
    .port_info 4 /OUTPUT 1 "pwm_out";
P_0x624168ce43a0 .param/l "WIDTH" 0 2 2, +C4<00000000000000000000000000010000>;
o0x7ea0937cf018 .functor BUFZ 1, c4<z>; HiZ drive
v0x624168ce4540_0 .net "clk", 0 0, o0x7ea0937cf018;  0 drivers
o0x7ea0937cf048 .functor BUFZ 16, c4<zzzzzzzzzzzzzzzz>; HiZ drive
v0x624168d2e250_0 .net "duty_cycle", 15 0, o0x7ea0937cf048;  0 drivers
o0x7ea0937cf078 .functor BUFZ 16, c4<zzzzzzzzzzzzzzzz>; HiZ drive
v0x624168d2e350_0 .net "period", 15 0, o0x7ea0937cf078;  0 drivers
v0x624168d2e410_0 .var "pwm_counter", 15 0;
v0x624168d2e4f0_0 .var "pwm_out", 0 0;
o0x7ea0937cf108 .functor BUFZ 1, c4<z>; HiZ drive
v0x624168d2e600_0 .net "rst_n", 0 0, o0x7ea0937cf108;  0 drivers
E_0x624168d1dc60/0 .event negedge, v0x624168d2e600_0;
E_0x624168d1dc60/1 .event posedge, v0x624168ce4540_0;
E_0x624168d1dc60 .event/or E_0x624168d1dc60/0, E_0x624168d1dc60/1;
    .scope S_0x624168ce4210;
T_0 ;
    %wait E_0x624168d1dc60;
    %load/vec4 v0x624168d2e600_0;
    %nor/r;
    %flag_set/vec4 8;
    %jmp/0xz  T_0.0, 8;
    %pushi/vec4 0, 0, 16;
    %assign/vec4 v0x624168d2e410_0, 0;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v0x624168d2e4f0_0, 0;
    %jmp T_0.1;
T_0.0 ;
    %load/vec4 v0x624168d2e350_0;
    %pad/u 32;
    %subi 1, 0, 32;
    %load/vec4 v0x624168d2e410_0;
    %pad/u 32;
    %cmp/u;
    %flag_or 5, 4;
    %flag_mov 8, 5;
    %jmp/0 T_0.2, 8;
    %pushi/vec4 0, 0, 16;
    %jmp/1 T_0.3, 8;
T_0.2 ; End of true expr.
    %load/vec4 v0x624168d2e410_0;
    %addi 1, 0, 16;
    %jmp/0 T_0.3, 8;
 ; End of false expr.
    %blend;
T_0.3;
    %assign/vec4 v0x624168d2e410_0, 0;
    %load/vec4 v0x624168d2e410_0;
    %load/vec4 v0x624168d2e250_0;
    %cmp/u;
    %flag_mov 8, 5;
    %jmp/0 T_0.4, 8;
    %pushi/vec4 1, 0, 1;
    %jmp/1 T_0.5, 8;
T_0.4 ; End of true expr.
    %pushi/vec4 0, 0, 1;
    %jmp/0 T_0.5, 8;
 ; End of false expr.
    %blend;
T_0.5;
    %assign/vec4 v0x624168d2e4f0_0, 0;
T_0.1 ;
    %jmp T_0;
    .thread T_0;
# The file index is used to find the file name in the following table.
:file_names 3;
    "N/A";
    "<interactive>";
    "pwm_parametrizado.v";
