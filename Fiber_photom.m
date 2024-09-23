% Timeseries extraction
%% Originally created by Jae-Chang Kim 14.10.2021 (Han and Morris et. al, Cell Rep. 2023 Jan 31;42(1):111914. doi: 10.1016/j.celrep.2022.111914. Epub 2023 Jan 2.)
%% by Szilvia Vas 11.09.2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Please adjust parameters
FilePath = 'C:\Users\feszi\OneDrive - University of Cambridge\Desktop\Herbison lab\Photometry\1__DREADD_NA\Paper\Submission\to submit\Fiber_photom';
Filename = {'AHAP6.1h_#78_PPAP BL@8-31_CNO 3mgkg_05-01-2022.csv'}; 
minPeakDistance = 30; % minimum peak distance in second unit x 20 second (each data point)
%------------------------------------------------------------------------
dataEstimationTime = 10; % temporal resolution in Hz

recITI = 5; % Recording time in second
nonITI = 10; % non-recording time in second
DownSamplingRate = nonITI; % Downsampling rate in second
fsDS = 1/DownSamplingRate; % Sampling Rate after Downsampling

BSTimeWindow = 900 % 900; % baseline correction window for downsampled data in second
BSCorrTimeWindow = 600 % 600; % baseline fitting after zscoring; in second
TSThreshold = 2; % initial low value

currFile = fullfile(FilePath,Filename{1});
TS=readmatrix(currFile); % To read Timeseries

TSx=TS(:,1); % Timeseries x-axis (time in second unit) 
TS405=TS(:,2); % Timeseries for 405nm (for subtract to 490nm)
TS490=TS(:,3); % Timeseries for 490nm (for peak detecting)
totRecTime = fix(max(TSx)); % total recording time in seconds (24h: 86400)
startRecTime = fix(min(TSx));%(SV)

TSxDS = [startRecTime:recITI+nonITI:totRecTime]';% Downsampled x-axis (from 0 second to the total recording time with increment of number of averaged data points)
TS490DS=sepblockfun(TS490,[recITI*dataEstimationTime,1,1],'mean');
TS405DS=sepblockfun(TS405,[recITI*dataEstimationTime,1,1],'mean');
   
% 490-405 then baseline correction
TS490405DS=TS490DS-TS405DS;
TS490405DScorrected = msbackadj(TSxDS, TS490405DS, 'WindowSize', BSTimeWindow, 'StepSize', BSTimeWindow);
TS490405DSBS=TS490405DS-TS490405DScorrected; % fitted baseline 
NormTSGCaMP = zscore(TS490405DScorrected);

NormGCaMPfitted = msbackadj(TSxDS, NormTSGCaMP, 'WindowSize', BSCorrTimeWindow, 'StepSize', BSCorrTimeWindow);

TableCorrectedBS = table();
TableCorrectedBS.TSxDS = TSxDS; % x-axis, time (in sec)
TableCorrectedBS.NormGCaMPfitted = NormGCaMPfitted;  % y-axis, Corrected Baseline
TableCorrectedBS.NormTSGCaMP = NormTSGCaMP;  % y-axis, z-scored 490 - 405

[fp fn fex] = fileparts(currFile);
writetable(TableCorrectedBS,fullfile(FilePath,sprintf('TableBS_%s.xlsx',fn)));
   
[pks, locs, w, p] = findpeaks(NormGCaMPfitted,TSxDS,'MinPeakDistance',minPeakDistance,'MinPeakHeight',TSThreshold);
TSThreshold = max(pks)/3;
[pks, locs, w, p] = findpeaks(NormGCaMPfitted,TSxDS,'MinPeakDistance',minPeakDistance,'MinPeakHeight',TSThreshold);

figure;
findpeaks(NormGCaMPfitted,TSxDS,'Annotate','extents','WidthReference','halfheight','MinPeakDistance',minPeakDistance,'MinPeakHeight',TSThreshold)
hold on; %using 900s baseline fitting to raise the baseline above 0    
plot(TSxDS,TSThreshold*ones(1,length(TSxDS)))

TableFWHM = table();
TableFWHM.id = [1:length(pks)]';
TableFWHM.peakX = locs;
TableFWHM.peakY = pks;
    
[fp fn fex] = fileparts(currFile);
writetable(TableFWHM,fullfile(FilePath,sprintf('TableFWHM_%s.xlsx',fn)));
