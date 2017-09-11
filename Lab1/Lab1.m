%% Matlab m-file for ECE342
% ECE 342 Lab 1 - TZA

%% Set variables and filenames
% add the ngspice matlab toolbox to the path
addpath('C:\CppSim\CppSimShared\HspiceToolbox');
% set format and clear variables
format long;
clear variables;
% set the hspc filename
hspc_filename = sprintf('test.hspc');
hspc_filename_2 = sprintf('test2.hspc');

%% Set parameters for transient simulation and write to hspc file
hspc_addline('.tran .1u 1m', hspc_filename);
hspc_addline('.ac dec 200 0 1e6', hspc_filename_2);

%% Run ngspice
ngsim(hspc_filename);

%% Load simulation results and extract time and vout1 and vout2
simdata = loadsig('simrun.raw');
sim_time = evalsig(simdata, 'TIME');
sim_Vout1 = evalsig(simdata,'vout');

%% Run AC simulation
ngsim(hspc_filename_2);
simdata = loadsig('simrun.raw');
sim_frequency = evalsig(simdata, 'FREQUENCY');
sim_Vout2 = evalsig(simdata,'vout');
sim_Vin2 = evalsig(simdata,'vin');
sim_Vout2 = 20 .* log10(abs(sim_Vout2) ./ abs(sim_Vin2));

%% Plot Vout as a function of time
% define font size (fs) and linewidth (lw)
fs = 16;
lw = 1.5;
% set figure size and location
FigHandle = figure('Name', 'Amplifier Output', 'Position', [200, 75, 850, 600]);

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
title('Time Domain')
% legend
legend('Simulated Output');
% set axis limits
axis([0, 1, -5, 5]);

%% second subplot
subplot(2,1,2)
semilogx(sim_frequency, sim_Vout2, 'linewidth', lw);
% add grid
grid on;
% increase font size
set(gca, 'fontsize', fs);
% y-axis and x-axis labels
ylabel('Gain (dB)', 'fontsize', fs);
xlabel('Frequency (Hz)', 'fontsize', fs);
% title
title('Frequency Domain')
% legend
legend('Simulated Output');
% set axis limits
axis([0, 1e6, 0, 120]);

%% end of M file
