onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/D/clock
add wave -noupdate /top/D/reset
add wave -noupdate /top/D/fetchedInstruction
add wave -noupdate /top/D/RequestUpdate
add wave -noupdate /top/D/UpdateRegister
add wave -noupdate /top/D/UpdateRegValue
add wave -noupdate /top/D/RequestUpdate2
add wave -noupdate /top/D/UpdateRegister2
add wave -noupdate /top/D/UpdateRegValue2
add wave -noupdate /top/D/RequestFetch
add wave -noupdate /top/D/executeIsReady
add wave -noupdate /top/D/mode
add wave -noupdate /top/D/outputAddress
add wave -noupdate /top/D/outputAddress2
add wave -noupdate -radix binary /top/D/value1
add wave -noupdate -radix binary /top/D/value2
add wave -noupdate -radix binary /top/D/value3
add wave -noupdate /top/D/Operation
add wave -noupdate /top/D/GPR
add wave -noupdate /top/D/ListOfUsedReg
add wave -noupdate /top/D/tempList
add wave -noupdate /top/E/executeIsReady
add wave -noupdate /top/E/Branching
add wave -noupdate /top/E/BranchingLocation
add wave -noupdate /top/E/toReg
add wave -noupdate /top/E/toWrite
add wave -noupdate /top/E/toLoad
add wave -noupdate /top/E/toSwap
add wave -noupdate /top/E/StoreAddress
add wave -noupdate /top/E/StoreAddress2
add wave -noupdate /top/E/StoreValue
add wave -noupdate /top/E/StoreValue2
add wave -noupdate /top/M/outReg
add wave -noupdate /top/M/outSwap
add wave -noupdate /top/M/memoryIsReady
add wave -noupdate /top/M/RegAddress
add wave -noupdate /top/M/RegValue
add wave -noupdate /top/M/RegAddress2
add wave -noupdate /top/M/RegValue2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {182294 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 204
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {172800 ps} {312749 ps}
