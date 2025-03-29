# ========= RELOJ PRINCIPAL =========
# Supón una frecuencia de 100 MHz (10 ns). Puedes ajustar esto si lo necesitas.
create_clock -name tclk -period 193.4 [get_ports tclk]


# ========= RESTRICCIONES DE ENTRADA/SALIDA =========
# Define los retardos para entradas y salidas respecto al reloj
# Puedes ajustarlos si conoces las características del entorno externo
set_input_delay -clock tclk 2.0 [get_ports in_data]
set_output_delay -clock tclk 2.0 [get_ports out_data]

# ========= RUTAS NO CRÍTICAS =========
# Ignoramos la ruta directa entre entrada y salida (no relevante)
set_false_path -from [get_ports in_data] -to [get_ports out_data]

# ========= RESET (opcionalmente ignorado para timing) =========
set_false_path -from [get_ports reset]
