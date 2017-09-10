***** Spice Netlist for Cell 'Lab1' *****

************** Module Lab1 **************
xi0 gnd n0 n1 n2 vout lf347 
v0 gnd n2 dc='12' ac='0' 
v1 n1 gnd dc='12' ac='0' 
c0 gnd n0 4p
r0 n0 vout 180k noisy=0
c1 n0 vout 22p
i0 gnd n0 dc 0a ac 0 sin('0a' '1n' '20k' '.1us') 





.include '../../../SpiceModels/ECE214_models.mod'
.include '../../../SpiceModels/ECE342_models.mod'
.temp 27
.tran .1u 1m
.ac .1u 1m
.global gnd
.options post=1 delmax=5p relv=1e-6 reli=1e-6 relmos=1e-6 method=gear

.end

