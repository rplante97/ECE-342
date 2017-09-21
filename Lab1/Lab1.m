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

%% Read digilent csv files
Lab1FFT = sprintf('Lab1ScopeFFT.csv');
Lab1Freq = sprintf('Lab1Network.csv');
Lab1Out = sprintf('Lab1Scope.csv');

% read Vout in
VoutData = csvread(Lab1Out, 9);
VoutTime = VoutData(:,1);
VoutVout = VoutData(:,2);

% read FFT data in
FFTdata = csvread(Lab1FFT, 6);
FFTfreq = FFTdata(:,1);
FFTdB = FFTdata(:,2);

% read frequency response data in
FreqR = csvread(Lab1Freq, 6);
FreqRfreq = FreqR(:,1);
dBGain = FreqR(:,2);
phase = FreqR(:,3);

%% Set parameters for transient simulation and write to hspc file
hspc_addline('.tran .1u 1m', hspc_filename);
hspc_addline('.ac dec 200 0 1e7', hspc_filename_2);

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
sim_Vout2 = 20 .* log10(abs(sim_Vout2));

%% Plot Vout as a function of time
% define font size (fs) and linewidth (lw)
fs = 16;
lw = 1.5;
% set figure size and location
FigHandle = figure('Name', 'Simulated Amplifier Output', 'Position', [200, 75, 850, 600]);

%% First subplot
subplot(2,1,1);

plot(sim_time.*1e3,  sim_Vout1, 'linewidth',lw);
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
axis([0, 1e7, 0, 120]);

FigHandle2 = figure('Name', 'Measured Amplifier Output', 'Position', [200, 75, 850, 600]);

%% First Subplot
subplot(2,2,1)
plot(VoutTime .* 1e3, VoutVout, 'linewidth', lw)
% add grid
grid on;
% increase font size
set(gca, 'fontsize', fs);
% y-axis and x-axis labels
ylabel('Vout (V)', 'fontsize', fs);
xlabel('Time (ms)', 'fontsize', fs);
% title
title('TZA Output')
% legend
legend('Measured Output');
% set axis limits
axis([0, 1, -5, 7]);

%% Second Subplot
subplot(2,2,2)
plot(FFTfreq ./ 1e3, FFTdB, 'linewidth', lw)
% add grid
grid on;
% increase font size
set(gca, 'fontsize', fs);
% y-axis and x-axis labels
ylabel('Amplitude (dB)', 'fontsize', fs);
xlabel('Frequency (kHz)', 'fontsize', fs);
% title
title('TZA Output FFT')
% legend
legend('Measured Output');
% set axis limits
xlim = 2e2;
axis([0, xlim, -120, 20]);
xticks(linspace(20, xlim, xlim/20));

%% Third Subplot
subplot(2,2,3)
semilogx(FreqRfreq, dBGain, 'linewidth', lw)
% add grid
grid on;
% increase font size
set(gca, 'fontsize', fs);
% y-axis and x-axis labels
ylabel('Gain (dB)', 'fontsize', fs);
xlabel('Frequency (Hz)', 'fontsize', fs);
% title
title('TZA Frequency Response')
% legend
legend('Measured Output');
% set axis limits
axis([1e3, 1e6, -40, 15]);

%% Fourth Subplot
subplot(2,2,4)
semilogx(FreqRfreq, phase, 'linewidth', lw)
% add grid
grid on;
% increase font size
set(gca, 'fontsize', fs);
% y-axis and x-axis labels
ylabel('Phase Shift (Degrees)', 'fontsize', fs);
xlabel('Frequency (Hz)', 'fontsize', fs);
% title
title('TZA Frequency Response')
% legend
legend('Measured Output');
% set axis limits
axis([1e3, 1e6, -100, 200]);
%% end of M file
