vcom -reportprogress 300 -work work {C:\Users\LI Chuan\Desktop\Monocycle\TP1\assemblage_unite_traitement_tb}
vsim -gui work.assemblage_unite_traitement_tb
add wave -position insertpoint sim:/assemblage_unite_traitement_tb/*
run