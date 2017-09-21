***** Spice Netlist for Cell 'Lab1' *****

************** Module Lab1 **************
v1 n0 gnd dc='12' ac='0' 
v0 n1 gnd dc='-12' ac='0' 
c0 gnd vin 4p
i0 vin gnd dc 0a ac 1a sin('0a' '10u' '20k' '0s') 
xi0 gnd vin n0 n1 vout lf347 
r0 vin vout 400k noisy=0
c1 vin vout 10p





.include '../../../SpiceModels/ECE214_models.mod'
.include '../../../SpiceModels/ECE342_models.mod'
.temp 27
.ac dec 200 0 1e7
.global gnd
.options post=1 delmax=5p relv=1e-6 reli=1e-6 relmos=1e-6 method=gear

.end

