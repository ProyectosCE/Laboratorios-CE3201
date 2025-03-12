-- Copyright (C) 2024  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 23.1std.1 Build 993 05/14/2024 SC Lite Edition"

-- DATE "03/11/2025 23:41:40"

-- 
-- Device: Altera 5CSXFC6D6F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for QuestaSim (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	RippleCarryAdder4b IS
    PORT (
	A : IN std_logic_vector(3 DOWNTO 0);
	B : IN std_logic_vector(3 DOWNTO 0);
	Cin : IN std_logic;
	S : OUT std_logic_vector(3 DOWNTO 0);
	Cout : OUT std_logic;
	SSD : OUT std_logic_vector(6 DOWNTO 0)
	);
END RippleCarryAdder4b;

-- Design Ports Information
-- S[0]	=>  Location: PIN_AA24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[1]	=>  Location: PIN_AB23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[2]	=>  Location: PIN_AC23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[3]	=>  Location: PIN_AD24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Cout	=>  Location: PIN_AG25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SSD[0]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SSD[1]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SSD[2]	=>  Location: PIN_AG17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SSD[3]	=>  Location: PIN_AG16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SSD[4]	=>  Location: PIN_AH17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SSD[5]	=>  Location: PIN_AG18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SSD[6]	=>  Location: PIN_AH18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[0]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Cin	=>  Location: PIN_AB30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_AD30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_AC30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_AC29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_AA30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF RippleCarryAdder4b IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_A : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Cin : std_logic;
SIGNAL ww_S : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Cout : std_logic;
SIGNAL ww_SSD : std_logic_vector(6 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \Cin~input_o\ : std_logic;
SIGNAL \B[0]~input_o\ : std_logic;
SIGNAL \RCA1|S~combout\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \B[1]~input_o\ : std_logic;
SIGNAL \RCA2|S~combout\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \RCA2|Cout~0_combout\ : std_logic;
SIGNAL \B[2]~input_o\ : std_logic;
SIGNAL \RCA3|S~combout\ : std_logic;
SIGNAL \B[3]~input_o\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \RCA4|S~combout\ : std_logic;
SIGNAL \RCA4|Cout~0_combout\ : std_logic;
SIGNAL \DECODER|Mux6~0_combout\ : std_logic;
SIGNAL \DECODER|Mux5~0_combout\ : std_logic;
SIGNAL \DECODER|Mux4~0_combout\ : std_logic;
SIGNAL \DECODER|Mux3~0_combout\ : std_logic;
SIGNAL \DECODER|Mux2~0_combout\ : std_logic;
SIGNAL \DECODER|Mux1~0_combout\ : std_logic;
SIGNAL \DECODER|Mux0~0_combout\ : std_logic;
SIGNAL \ALT_INV_A[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_Cin~input_o\ : std_logic;
SIGNAL \ALT_INV_B[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[0]~input_o\ : std_logic;
SIGNAL \DECODER|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \RCA4|ALT_INV_S~combout\ : std_logic;
SIGNAL \RCA3|ALT_INV_S~combout\ : std_logic;
SIGNAL \RCA2|ALT_INV_Cout~0_combout\ : std_logic;
SIGNAL \RCA2|ALT_INV_S~combout\ : std_logic;
SIGNAL \RCA1|ALT_INV_S~combout\ : std_logic;

BEGIN

ww_A <= A;
ww_B <= B;
ww_Cin <= Cin;
S <= ww_S;
Cout <= ww_Cout;
SSD <= ww_SSD;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_A[2]~input_o\ <= NOT \A[2]~input_o\;
\ALT_INV_B[2]~input_o\ <= NOT \B[2]~input_o\;
\ALT_INV_A[3]~input_o\ <= NOT \A[3]~input_o\;
\ALT_INV_B[3]~input_o\ <= NOT \B[3]~input_o\;
\ALT_INV_B[1]~input_o\ <= NOT \B[1]~input_o\;
\ALT_INV_A[1]~input_o\ <= NOT \A[1]~input_o\;
\ALT_INV_Cin~input_o\ <= NOT \Cin~input_o\;
\ALT_INV_B[0]~input_o\ <= NOT \B[0]~input_o\;
\ALT_INV_A[0]~input_o\ <= NOT \A[0]~input_o\;
\DECODER|ALT_INV_Mux0~0_combout\ <= NOT \DECODER|Mux0~0_combout\;
\RCA4|ALT_INV_S~combout\ <= NOT \RCA4|S~combout\;
\RCA3|ALT_INV_S~combout\ <= NOT \RCA3|S~combout\;
\RCA2|ALT_INV_Cout~0_combout\ <= NOT \RCA2|Cout~0_combout\;
\RCA2|ALT_INV_S~combout\ <= NOT \RCA2|S~combout\;
\RCA1|ALT_INV_S~combout\ <= NOT \RCA1|S~combout\;

-- Location: IOOBUF_X89_Y11_N45
\S[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RCA1|S~combout\,
	devoe => ww_devoe,
	o => ww_S(0));

-- Location: IOOBUF_X89_Y9_N22
\S[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RCA2|S~combout\,
	devoe => ww_devoe,
	o => ww_S(1));

-- Location: IOOBUF_X86_Y0_N19
\S[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RCA3|S~combout\,
	devoe => ww_devoe,
	o => ww_S(2));

-- Location: IOOBUF_X88_Y0_N37
\S[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RCA4|S~combout\,
	devoe => ww_devoe,
	o => ww_S(3));

-- Location: IOOBUF_X78_Y0_N36
\Cout~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RCA4|Cout~0_combout\,
	devoe => ww_devoe,
	o => ww_Cout);

-- Location: IOOBUF_X60_Y0_N19
\SSD[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DECODER|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_SSD(0));

-- Location: IOOBUF_X80_Y0_N2
\SSD[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DECODER|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_SSD(1));

-- Location: IOOBUF_X50_Y0_N93
\SSD[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DECODER|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_SSD(2));

-- Location: IOOBUF_X50_Y0_N76
\SSD[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DECODER|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_SSD(3));

-- Location: IOOBUF_X56_Y0_N36
\SSD[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DECODER|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_SSD(4));

-- Location: IOOBUF_X58_Y0_N76
\SSD[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DECODER|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_SSD(5));

-- Location: IOOBUF_X56_Y0_N53
\SSD[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DECODER|ALT_INV_Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_SSD(6));

-- Location: IOIBUF_X89_Y20_N78
\A[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: IOIBUF_X89_Y21_N4
\Cin~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Cin,
	o => \Cin~input_o\);

-- Location: IOIBUF_X89_Y21_N38
\B[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(0),
	o => \B[0]~input_o\);

-- Location: LABCELL_X88_Y21_N0
\RCA1|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \RCA1|S~combout\ = ( \B[0]~input_o\ & ( !\A[0]~input_o\ $ (\Cin~input_o\) ) ) # ( !\B[0]~input_o\ & ( !\A[0]~input_o\ $ (!\Cin~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100110000111100001100111100001111001100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_A[0]~input_o\,
	datac => \ALT_INV_Cin~input_o\,
	datae => \ALT_INV_B[0]~input_o\,
	combout => \RCA1|S~combout\);

-- Location: IOIBUF_X89_Y25_N38
\A[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: IOIBUF_X89_Y25_N55
\B[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(1),
	o => \B[1]~input_o\);

-- Location: LABCELL_X88_Y21_N9
\RCA2|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \RCA2|S~combout\ = ( \B[0]~input_o\ & ( !\A[1]~input_o\ $ (!\B[1]~input_o\ $ (((\A[0]~input_o\) # (\Cin~input_o\)))) ) ) # ( !\B[0]~input_o\ & ( !\A[1]~input_o\ $ (!\B[1]~input_o\ $ (((\Cin~input_o\ & \A[0]~input_o\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011011011001001011011001001001100110110110010010110110010010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Cin~input_o\,
	datab => \ALT_INV_A[1]~input_o\,
	datac => \ALT_INV_A[0]~input_o\,
	datad => \ALT_INV_B[1]~input_o\,
	datae => \ALT_INV_B[0]~input_o\,
	combout => \RCA2|S~combout\);

-- Location: IOIBUF_X89_Y20_N95
\A[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: LABCELL_X88_Y21_N42
\RCA2|Cout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \RCA2|Cout~0_combout\ = ( \B[0]~input_o\ & ( (!\B[1]~input_o\ & (\A[1]~input_o\ & ((\Cin~input_o\) # (\A[0]~input_o\)))) # (\B[1]~input_o\ & (((\A[1]~input_o\) # (\Cin~input_o\)) # (\A[0]~input_o\))) ) ) # ( !\B[0]~input_o\ & ( (!\B[1]~input_o\ & 
-- (\A[0]~input_o\ & (\Cin~input_o\ & \A[1]~input_o\))) # (\B[1]~input_o\ & (((\A[0]~input_o\ & \Cin~input_o\)) # (\A[1]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000101010111000101010111111100000001010101110001010101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_B[1]~input_o\,
	datab => \ALT_INV_A[0]~input_o\,
	datac => \ALT_INV_Cin~input_o\,
	datad => \ALT_INV_A[1]~input_o\,
	datae => \ALT_INV_B[0]~input_o\,
	combout => \RCA2|Cout~0_combout\);

-- Location: IOIBUF_X89_Y20_N44
\B[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(2),
	o => \B[2]~input_o\);

-- Location: LABCELL_X88_Y21_N21
\RCA3|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \RCA3|S~combout\ = ( \B[2]~input_o\ & ( !\A[2]~input_o\ $ (\RCA2|Cout~0_combout\) ) ) # ( !\B[2]~input_o\ & ( !\A[2]~input_o\ $ (!\RCA2|Cout~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100110000111100001100111100001111001100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_A[2]~input_o\,
	datac => \RCA2|ALT_INV_Cout~0_combout\,
	datae => \ALT_INV_B[2]~input_o\,
	combout => \RCA3|S~combout\);

-- Location: IOIBUF_X89_Y20_N61
\B[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(3),
	o => \B[3]~input_o\);

-- Location: IOIBUF_X89_Y21_N21
\A[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: LABCELL_X88_Y21_N24
\RCA4|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \RCA4|S~combout\ = ( \B[2]~input_o\ & ( \A[3]~input_o\ & ( !\B[3]~input_o\ $ (((\A[2]~input_o\) # (\RCA2|Cout~0_combout\))) ) ) ) # ( !\B[2]~input_o\ & ( \A[3]~input_o\ & ( !\B[3]~input_o\ $ (((\RCA2|Cout~0_combout\ & \A[2]~input_o\))) ) ) ) # ( 
-- \B[2]~input_o\ & ( !\A[3]~input_o\ & ( !\B[3]~input_o\ $ (((!\RCA2|Cout~0_combout\ & !\A[2]~input_o\))) ) ) ) # ( !\B[2]~input_o\ & ( !\A[3]~input_o\ & ( !\B[3]~input_o\ $ (((!\RCA2|Cout~0_combout\) # (!\A[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100111100001111001111000011110000110000111100001100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \RCA2|ALT_INV_Cout~0_combout\,
	datac => \ALT_INV_B[3]~input_o\,
	datad => \ALT_INV_A[2]~input_o\,
	datae => \ALT_INV_B[2]~input_o\,
	dataf => \ALT_INV_A[3]~input_o\,
	combout => \RCA4|S~combout\);

-- Location: LABCELL_X88_Y21_N33
\RCA4|Cout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \RCA4|Cout~0_combout\ = ( \B[2]~input_o\ & ( \A[3]~input_o\ & ( ((\RCA2|Cout~0_combout\) # (\A[2]~input_o\)) # (\B[3]~input_o\) ) ) ) # ( !\B[2]~input_o\ & ( \A[3]~input_o\ & ( ((\A[2]~input_o\ & \RCA2|Cout~0_combout\)) # (\B[3]~input_o\) ) ) ) # ( 
-- \B[2]~input_o\ & ( !\A[3]~input_o\ & ( (\B[3]~input_o\ & ((\RCA2|Cout~0_combout\) # (\A[2]~input_o\))) ) ) ) # ( !\B[2]~input_o\ & ( !\A[3]~input_o\ & ( (\B[3]~input_o\ & (\A[2]~input_o\ & \RCA2|Cout~0_combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000101010001010101010111010101110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_B[3]~input_o\,
	datab => \ALT_INV_A[2]~input_o\,
	datac => \RCA2|ALT_INV_Cout~0_combout\,
	datae => \ALT_INV_B[2]~input_o\,
	dataf => \ALT_INV_A[3]~input_o\,
	combout => \RCA4|Cout~0_combout\);

-- Location: LABCELL_X64_Y2_N33
\DECODER|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DECODER|Mux6~0_combout\ = ( \RCA3|S~combout\ & ( \RCA1|S~combout\ & ( (\RCA4|S~combout\ & !\RCA2|S~combout\) ) ) ) # ( !\RCA3|S~combout\ & ( \RCA1|S~combout\ & ( !\RCA4|S~combout\ $ (\RCA2|S~combout\) ) ) ) # ( \RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( 
-- (!\RCA4|S~combout\ & !\RCA2|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010100000000010101010010101010101010100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RCA4|ALT_INV_S~combout\,
	datad => \RCA2|ALT_INV_S~combout\,
	datae => \RCA3|ALT_INV_S~combout\,
	dataf => \RCA1|ALT_INV_S~combout\,
	combout => \DECODER|Mux6~0_combout\);

-- Location: LABCELL_X64_Y2_N6
\DECODER|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DECODER|Mux5~0_combout\ = ( \RCA3|S~combout\ & ( \RCA1|S~combout\ & ( !\RCA2|S~combout\ $ (\RCA4|S~combout\) ) ) ) # ( !\RCA3|S~combout\ & ( \RCA1|S~combout\ & ( (\RCA2|S~combout\ & \RCA4|S~combout\) ) ) ) # ( \RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( 
-- (\RCA4|S~combout\) # (\RCA2|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110101111100000101000001011010010110100101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RCA2|ALT_INV_S~combout\,
	datac => \RCA4|ALT_INV_S~combout\,
	datae => \RCA3|ALT_INV_S~combout\,
	dataf => \RCA1|ALT_INV_S~combout\,
	combout => \DECODER|Mux5~0_combout\);

-- Location: LABCELL_X64_Y2_N12
\DECODER|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DECODER|Mux4~0_combout\ = ( \RCA3|S~combout\ & ( \RCA1|S~combout\ & ( (\RCA2|S~combout\ & \RCA4|S~combout\) ) ) ) # ( \RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( \RCA4|S~combout\ ) ) ) # ( !\RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( (\RCA2|S~combout\ & 
-- !\RCA4|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000001010000000011110000111100000000000000000000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RCA2|ALT_INV_S~combout\,
	datac => \RCA4|ALT_INV_S~combout\,
	datae => \RCA3|ALT_INV_S~combout\,
	dataf => \RCA1|ALT_INV_S~combout\,
	combout => \DECODER|Mux4~0_combout\);

-- Location: LABCELL_X64_Y2_N21
\DECODER|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DECODER|Mux3~0_combout\ = ( \RCA3|S~combout\ & ( \RCA1|S~combout\ & ( \RCA2|S~combout\ ) ) ) # ( !\RCA3|S~combout\ & ( \RCA1|S~combout\ & ( !\RCA2|S~combout\ ) ) ) # ( \RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( (!\RCA4|S~combout\ & !\RCA2|S~combout\) ) ) 
-- ) # ( !\RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( (\RCA4|S~combout\ & \RCA2|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001010101101010100000000011111111000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RCA4|ALT_INV_S~combout\,
	datad => \RCA2|ALT_INV_S~combout\,
	datae => \RCA3|ALT_INV_S~combout\,
	dataf => \RCA1|ALT_INV_S~combout\,
	combout => \DECODER|Mux3~0_combout\);

-- Location: LABCELL_X64_Y2_N54
\DECODER|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DECODER|Mux2~0_combout\ = ( \RCA3|S~combout\ & ( \RCA1|S~combout\ & ( !\RCA4|S~combout\ ) ) ) # ( !\RCA3|S~combout\ & ( \RCA1|S~combout\ & ( (!\RCA2|S~combout\) # (!\RCA4|S~combout\) ) ) ) # ( \RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( (!\RCA2|S~combout\ 
-- & !\RCA4|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101000001010000011111010111110101111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RCA2|ALT_INV_S~combout\,
	datac => \RCA4|ALT_INV_S~combout\,
	datae => \RCA3|ALT_INV_S~combout\,
	dataf => \RCA1|ALT_INV_S~combout\,
	combout => \DECODER|Mux2~0_combout\);

-- Location: LABCELL_X64_Y2_N3
\DECODER|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DECODER|Mux1~0_combout\ = ( \RCA3|S~combout\ & ( \RCA1|S~combout\ & ( !\RCA4|S~combout\ $ (!\RCA2|S~combout\) ) ) ) # ( !\RCA3|S~combout\ & ( \RCA1|S~combout\ & ( !\RCA4|S~combout\ ) ) ) # ( !\RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( (!\RCA4|S~combout\ 
-- & \RCA2|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010101010000000000000000010101010101010100101010110101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RCA4|ALT_INV_S~combout\,
	datad => \RCA2|ALT_INV_S~combout\,
	datae => \RCA3|ALT_INV_S~combout\,
	dataf => \RCA1|ALT_INV_S~combout\,
	combout => \DECODER|Mux1~0_combout\);

-- Location: LABCELL_X64_Y2_N36
\DECODER|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DECODER|Mux0~0_combout\ = ( \RCA3|S~combout\ & ( \RCA1|S~combout\ & ( (!\RCA2|S~combout\) # (\RCA4|S~combout\) ) ) ) # ( !\RCA3|S~combout\ & ( \RCA1|S~combout\ & ( (\RCA4|S~combout\) # (\RCA2|S~combout\) ) ) ) # ( \RCA3|S~combout\ & ( !\RCA1|S~combout\ & 
-- ( (!\RCA4|S~combout\) # (\RCA2|S~combout\) ) ) ) # ( !\RCA3|S~combout\ & ( !\RCA1|S~combout\ & ( (\RCA4|S~combout\) # (\RCA2|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111111101011111010101011111010111111010111110101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RCA2|ALT_INV_S~combout\,
	datac => \RCA4|ALT_INV_S~combout\,
	datae => \RCA3|ALT_INV_S~combout\,
	dataf => \RCA1|ALT_INV_S~combout\,
	combout => \DECODER|Mux0~0_combout\);

-- Location: LABCELL_X10_Y44_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


