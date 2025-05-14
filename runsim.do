vlib work
vmap work work

vlog +acc -incr ./*.v

vsim +acc -t ps -lib work -c tb

add wave -noupdate -r /tb/*

run -all
