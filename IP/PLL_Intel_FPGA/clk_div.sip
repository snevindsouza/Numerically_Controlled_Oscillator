set_global_assignment -entity "clk_div" -library "lib_clk_div" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk_div" -library "lib_clk_div" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "clk_div" -library "lib_clk_div" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk_div" -name SPD_FILE [file join $::quartus(sip_path) "clk_div.spd"]

set_global_assignment -library "lib_clk_div" -name MISC_FILE [file join $::quartus(sip_path) "clk_div_sim/clk_div.vo"]
