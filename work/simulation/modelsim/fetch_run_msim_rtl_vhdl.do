transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/Processor/sc_uart.vhd}
vcom -93 -work work {D:/Processor/output.vhd}
vcom -93 -work work {D:/Processor/fifo.vhd}
vcom -93 -work work {D:/Processor/sdram.vhd}
vcom -93 -work work {D:/Processor/top.vhd}
vcom -93 -work work {D:/Processor/InstructionList.vhd}
vcom -93 -work work {D:/Processor/writeback.vhd}
vcom -93 -work work {D:/Processor/memory.vhd}
vcom -93 -work work {D:/Processor/execute.vhd}
vcom -93 -work work {D:/Processor/decode.vhd}
vcom -93 -work work {D:/Processor/fetch.vhd}

