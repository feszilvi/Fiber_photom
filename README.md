## Overview: 
Fiber_photom.m is custom-code written in MATLAB to detect peaks in fluorescent signal (representing activation of a detected neuronal population) in in vivo calcium imaging fiber photometry dataset. 

## Hardware requirements of running MATLAB R2021a:
https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/support/sysreq/files/system-requirements-release-2021a-windows.pdf

## Demo: 
The demo file (.xls) was created by the Open-source Neuromouse fiber photometry data acquisition system developed by Tussock Innovation and Argotech (New Zealand, https://www.otago.ac.nz/neuroendocrinology/resources/argotech.html). 


## Instruction for use:
When running the code for the demo file the following files need to be present in the same folder:
'Demo.csv'
'Fiber_photom.m'
'sepblockfun.m'

to run the code:
Please insert the path to the folder where the above mentioned files are to 'FilePath'. 
Please insert the name of the demo file ('Demo.csv') to 'Filename'
CTRL + A - highlight all lines of the code 
Press 'Run' in the Editor
In 1-2 minutes, the program output the followings:
*Figure - indicating the whole fiber photometry trace for the total length of the recording with the peaks (synchronization episodes) that have been detected over threshold (by blue triangles)
* Excel table: 'TableBS....' : downsampled data series. TSxDS: time scale (s); NormGCaMPfitted: baseline-fitted fluorescence data after backgroung subtracton and baseline-fitting; NormTSGCaMP: z-scored baseline-fitted GCaMP data
* Excel table: 'TableFWHM....' : 
