transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/Board_Manager.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/Player1_Input.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/Win_Checker.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/Turn_Timer.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/SevenSeg_Controller.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/VGA_Controller.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/Status_Register.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/Player2_Input.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/FSM_Game_Controller.sv}
vlog -sv -work work +incdir+C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio\ #3/Game {C:/Users/joseb/Documents/GitHub/Laboratorios-CE3201/Laboratorio #3/Game/Topmodule.sv}

