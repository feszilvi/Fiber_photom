'Read Me' file to the 'Fiber_photom.m' code file. 

## Overview: 
Fiber_photom.m is a simple custom-written MATLAB code to detect peaks in photometry traces recorded by in vivo calcium imgaing fiber photometry (peaks represent activation of a detected neuronal population). The code was originally created by Jae-Chang Kim 14.10.2021 (Han and Morris et. al, Cell Rep. 2023 Jan 31;42(1):111914. doi: 10.1016/j.celrep.2022.111914. Epub 2023 Jan 2.). 

## Hardware requirements of running MATLAB R2021a:
https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/support/sysreq/files/system-requirements-release-2021a-windows.pdf

## Demo: 
The demo file (Demo.csv) was created by the Open-source Neuromouse fiber photometry data acquisition system developed by Tussock Innovation and Argotech (New Zealand, https://www.otago.ac.nz/neuroendocrinology/resources/argotech.html). 

## Instruction for using the code:
When running the code on the demo file the following files need to be present in the same folder:
'Demo.csv'
'Fiber_photom.m'
'sepblockfun.m'

## To run the code:
Please insert to 'FilePath' the path to the folder where the above mentioned files are localized. 
Please insert the name of the demo file ('Demo.csv') to 'Filename'
With pressing CTRL + A, highlight all lines of the code 
Press 'Run' in the Editor
Expected run time: 1-2 minutes

## Expected output files:

* Figure - plots the whole fiber photometry trace for the total length of the recording by highlighting the detected peaks (indicated by blue traingles) that have been detected over the set threshold. [insert figure here]

* Excel table: 'TableFWHM_Demo.xls' : id: ID of detected peaks from the start of the recording; peakX: peak detection times (s) from the start of the recording;  peakY: Y value (amplitude) of the detected peaks; 

* Excel table: 'TableBS_Demo.xls' : downsampled data series. TSxDS: time scale (s); CorrectedBS: correced baseline; NormGCaMPfitted: fluorescence data after background subtraction and baseline-fitting; NormTSGCaMP: z-scored baseline-fitted 
