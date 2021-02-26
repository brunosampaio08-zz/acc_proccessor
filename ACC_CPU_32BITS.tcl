# Copyright (C) 2020  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details, at
# https://fpgasoftware.intel.com/eula.

# Quartus Prime: Generate Tcl File for Project
# File: ACC_CPU_32BITS.tcl
# Generated on: Fri Feb 26 20:22:13 2021

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "ACC_CPU_32BITS"]} {
		puts "Project ACC_CPU_32BITS is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists ACC_CPU_32BITS]} {
		project_open -revision ACC_CPU_32BITS ACC_CPU_32BITS
	} else {
		project_new -revision ACC_CPU_32BITS ACC_CPU_32BITS
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone IV E"
	set_global_assignment -name DEVICE EP4CE115F29C7
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 18.0.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "22:07:58  APRIL 16, 2019"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.1 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
	set_global_assignment -name NOMINAL_CORE_SUPPLY_VOLTAGE 1.2V
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name SMART_RECOMPILE ON
	set_global_assignment -name VERILOG_FILE Temporizador.v
	set_global_assignment -name VERILOG_FILE Contador04.v
	set_global_assignment -name VERILOG_FILE Contador010.v
	set_global_assignment -name VERILOG_FILE BCDto7segsVHDL.v
	set_global_assignment -name VERILOG_FILE ULA.v
	set_global_assignment -name VERILOG_FILE ACC_CPU_32BITS.v
	set_global_assignment -name VERILOG_FILE MUX.v
	set_global_assignment -name VERILOG_FILE BitExtensor.v
	set_global_assignment -name VERILOG_FILE ControlUnitCurrentState.v
	set_global_assignment -name VERILOG_FILE ControlUnitNextState.v
	set_global_assignment -name VERILOG_FILE ControlUnit.v
	set_global_assignment -name VERILOG_FILE ControlUnitOutput.v
	set_global_assignment -name VERILOG_FILE SingleClockRAM.v
	set_global_assignment -name VERILOG_FILE RegWriteLogic.v
	set_global_assignment -name VERILOG_FILE PCWriteLogic.v
	set_global_assignment -name VERILOG_FILE PCFetch.v
	set_global_assignment -name VERILOG_FILE IOLogic.v
	set_global_assignment -name VERILOG_FILE DeBounce.v
	set_global_assignment -name VERILOG_FILE bin2bcd.v
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform1.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform2.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform3.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform4.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform5.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform6.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform7.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform8.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform9.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform10.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform11.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform12.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform13.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE output_files/Waveform.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE output_files/Waveform1.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform14.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform15.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform16.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform17.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform18.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform19.vwf
	set_global_assignment -name ENABLE_OCT_DONE OFF
	set_global_assignment -name ENABLE_CONFIGURATION_PINS OFF
	set_global_assignment -name ENABLE_BOOT_SEL_PIN OFF
	set_global_assignment -name USE_CONFIGURATION_DEVICE OFF
	set_global_assignment -name CRC_ERROR_OPEN_DRAIN OFF
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -fall
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -fall
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform20.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform21.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform22.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform23.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform24.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform25.vwf
	set_global_assignment -name VERILOG_FILE bin_to_bcd.v
	set_global_assignment -name VERILOG_FILE signalClock.v
	set_location_assignment PIN_W28 -to Output7Segments[14]
	set_location_assignment PIN_AD21 -to Input[0]
	set_location_assignment PIN_AE16 -to Input[1]
	set_location_assignment PIN_AD15 -to Input[2]
	set_location_assignment PIN_AB22 -to button_clock_in
	set_location_assignment PIN_G19 -to WaitingInput
	set_location_assignment PIN_H22 -to Output7Segments[0]
	set_location_assignment PIN_J22 -to Output7Segments[1]
	set_location_assignment PIN_L25 -to Output7Segments[2]
	set_location_assignment PIN_L26 -to Output7Segments[3]
	set_location_assignment PIN_E17 -to Output7Segments[4]
	set_location_assignment PIN_F22 -to Output7Segments[5]
	set_location_assignment PIN_G18 -to Output7Segments[6]
	set_location_assignment PIN_Y2 -to clock
	set_location_assignment PIN_U24 -to Output7Segments[7]
	set_location_assignment PIN_U23 -to Output7Segments[8]
	set_location_assignment PIN_W25 -to Output7Segments[9]
	set_location_assignment PIN_W22 -to Output7Segments[10]
	set_location_assignment PIN_W21 -to Output7Segments[11]
	set_location_assignment PIN_Y22 -to Output7Segments[12]
	set_location_assignment PIN_M24 -to Output7Segments[13]
	set_location_assignment PIN_AE15 -to Input[3]
	set_location_assignment PIN_AC19 -to Input[4]
	set_location_assignment PIN_AF16 -to Input[5]
	set_location_assignment PIN_AD19 -to Input[6]
	set_location_assignment PIN_AF15 -to Input[7]
	set_location_assignment PIN_AF24 -to Input[8]
	set_location_assignment PIN_AE21 -to Input[9]
	set_location_assignment PIN_AF25 -to Input[10]
	set_location_assignment PIN_AC22 -to Input[11]
	set_location_assignment PIN_AE22 -to Input[12]
	set_location_assignment PIN_AF21 -to Input[13]
	set_location_assignment PIN_AF22 -to Input[14]
	set_location_assignment PIN_AD22 -to Input[15]
	set_location_assignment PIN_AG25 -to Input[16]
	set_location_assignment PIN_AC15 -to reset_in
	set_location_assignment PIN_W27 -to Output7Segments[15]
	set_location_assignment PIN_Y26 -to Output7Segments[16]
	set_location_assignment PIN_W26 -to Output7Segments[17]
	set_location_assignment PIN_Y25 -to Output7Segments[18]
	set_location_assignment PIN_AA26 -to Output7Segments[19]
	set_location_assignment PIN_AA25 -to Output7Segments[20]
	set_location_assignment PIN_G21 -to Negative
	set_location_assignment PIN_Y19 -to Output7Segments[21]
	set_location_assignment PIN_AF23 -to Output7Segments[22]
	set_location_assignment PIN_AD24 -to Output7Segments[23]
	set_location_assignment PIN_AA21 -to Output7Segments[24]
	set_location_assignment PIN_AB20 -to Output7Segments[25]
	set_location_assignment PIN_U21 -to Output7Segments[26]
	set_location_assignment PIN_V21 -to Output7Segments[27]
	set_location_assignment PIN_AC17 -to OutputPC[14]
	set_location_assignment PIN_AA15 -to OutputPC[15]
	set_location_assignment PIN_AB15 -to OutputPC[16]
	set_location_assignment PIN_AB17 -to OutputPC[17]
	set_location_assignment PIN_AA16 -to OutputPC[18]
	set_location_assignment PIN_AB16 -to OutputPC[19]
	set_location_assignment PIN_AA17 -to OutputPC[20]
	set_location_assignment PIN_AH18 -to OutputPC[7]
	set_location_assignment PIN_AF18 -to OutputPC[8]
	set_location_assignment PIN_AG19 -to OutputPC[9]
	set_location_assignment PIN_AH19 -to OutputPC[10]
	set_location_assignment PIN_AB18 -to OutputPC[11]
	set_location_assignment PIN_AC18 -to OutputPC[12]
	set_location_assignment PIN_AD18 -to OutputPC[13]
	set_location_assignment PIN_AE18 -to OutputPC[0]
	set_location_assignment PIN_AF19 -to OutputPC[1]
	set_location_assignment PIN_AE19 -to OutputPC[2]
	set_location_assignment PIN_AH21 -to OutputPC[3]
	set_location_assignment PIN_AG21 -to OutputPC[4]
	set_location_assignment PIN_AA19 -to OutputPC[5]
	set_location_assignment PIN_AB19 -to OutputPC[6]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
