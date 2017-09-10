%% Sample Matlab m-file for ECE342
% ECE 214 Lab 9 - Astable Multivibrator

%% Set variables and filenames
% add the ngspice matlab toolbox to the path
addpath('C:\CppSim\CppSimShared\HspiceToolbox');
% set format and clear variables
format long;
clear variables;
% set the hspc filename
hspc_filename = sprintf('test.hspc');
% set the digilent csv filename
digilent_filename = sprintf('test.csv');

%% Set component parameters
capacitor_1 = 1.35e-9;
capacitor_2 = 1.35e-9;
hspc_set_param('cap1', capacitor_1, hspc_filename);
hspc_set_param('cap2', capacitor_2, hspc_filename);

rdown = 30e3;
rup = 60e3;
rx = 1e3;
hspc_set_param('ru', rup, hspc_filename);
hspc_set_param('rd', rdown, hspc_filename);
hspc_set_param('rx', rx, hspc_filename);

%% Set parameters for transient simulation and write to hspc file
hspc_addline('.tran .1u 1m', hspc_filename);

%% Run ngspice
ngsim(hspc_filename);

%% Load simulation results and extract time and vout1 and vout2
simdata = loadsig('simrun.raw');
sim_time = evalsig(simdata, 'TIME');
sim_Vout1 = evalsig(simdata,'vout');
%sim_Vout2 = evalsig(simdata,'xi0_vout2');

%% Load Digilent results and extract time and channel1 and channel2
%measdata = csvread(digilent_filename, 6);
% meas_time = measdata(:,1);
% meas_v1 = measdata(:,2);
% meas_v2 = measdata(:,3);

%% Plot Vout as a function of time
% define font size (fs) and linewidth (lw)
fs = 16;
lw = 1.5;
% set figure size and location
FigHandle = figure('Name', 'Oscillator Output', 'Position', [200, 75, 850, 600]);

%% First subplot
subplot(2,1,1);

plot(sim_time.*1e3,  sim_Vout1, 'linewidth',lw);
%axis([0, .5, -2, 10]);
% add grid
grid on;
% increase font size
set(gca, 'fontsize', fs);
% y-axis and x-axis labels
ylabel('Voltage (V)', 'fontsize', fs);
xlabel('Time (ms)', 'fontsize', fs);
% title
title('Astable Multivibrator')
% legend
legend('Simulated Output', 'Measured Output', 'location', 'northwest');
% set axis
%axis([0, .2, 0, 10]);

%% second subplot
subplot(2,1,2)
plot(sim_time*1e3, sim_Vout2, meas_time*1e3+0.38, meas_v1, 'linewidth', lw);
%axis([0,.5,-4,10]);
% add grid
grid on;
% increase font size
set(gca, 'fontsize', fs);
% y-axis and x-axis labels
ylabel('Voltage (V)', 'fontsize', fs);
xlabel('Time (ms)', 'fontsize', fs);
% legend
legend('Siulated Output', 'Measured Output', 'location', 'northwest');
% set axis limits
%axis([0, .1, 0, 20]);

%% end of M file
