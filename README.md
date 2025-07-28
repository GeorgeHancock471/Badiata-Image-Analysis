# INSTRUCTIONS

 NB if you have any issues please email: ghancockzoology@gmail.com Subject, Badiata moth analyses

## Installation

To install you need to have ImageJ (not FIJI) with the micatoolbox installed

https://imagej.net/ij/ - Image J

https://www.empiricalimaging.com/ - micatoolbox

Extract the contents of the zip file and paste into the ImageJ plugins folder.

E.g. Cone Models should merge with the Cone Models folder from ImageJ.

## Creating moth .mspec images from .RAW files

Run ImageJ .exe

Navigate to Plugins/Moth_Analysis_Scripts/

Run "Batch Create Moth MSPECS"

You will be asked to select a RAW image.

Ideally all RAW images should be kept within the same folder for ease of analysis.

Once loaded:
- select the dark standard, this is 3% for a XRITE Colour Chart
- select the light standard, this is 91% for a XRITE Colour Chart
- draw a line for the scale bar and then input the size in mm.

The MSPEC will then be saved and you will be asked if you need to make anymore in a loop until 
you wish to stop.


## Creating regions of interest for the moths

Navigate to Plugins/Moth_Analysis_Scripts/

Run "Batch Create Moth Wing ROIs"

NB this is designed specifically for the the analysis for Badiata moths as they were photographed
by Mikael

Select the folder where you .mspecs are saved.

For each image you will be prompted to draw a polygon around the moth wings.
	- Do not draw it too close to the wing iseld especially for the frayed edges.
	- Then use the select tool to remove the background
	- clean
	- Then select the side label

This will add new ROIs for each forewing.

This script could be modified to do other wings.


## Creating presentation images

Navigate to Plugins/Moth_Analysis_Scripts/

Run "Batch Create ROI Presentation Images"

Select the XYZ camera model for the moths which is 'Moth Measure'

If you want the wings to be straight type the Prescript: "Rotate Wing ROIs"

This will then go through all of the .mspecs in a selected folder generating .pngs

These are saved to a subfolder titled PNGs

## Obtaining image analysis metrics

Navigate to Plugins/Moth_Analysis_Scripts/

Run "Batch RNL Chromaticity Analyses 3.0"

The default settings should be correct, but specify the following:

Organisation: Single MSPEC folder
StartFolder: 
EndFolder:
ConeCatch: Moth Measure CIE XYZ
WeberFraction: Human XYZ 0.05
AcuityView: No
visual-acuity: 
view-distance:
Prescript: Rotate Wing ROIs
CropROI: None

Simple Measures:
	Mean: Yes
	StdDev: Yes
	Mode: No
	Min: No
	Max: No
	Kurtosis: No
	ROIs: AllRois
	
GabRat:
	Lum: No
	Col: No
	ROIs: AllRois
	
SpatialMeasures:
	Lum: Yes
	Col: Yes
	Orientation: Gabor4
	ROIs: AllRois

Spatial Settings:
	N Oct: 6
	Offset: 0 
	Scale: SetScale
	MScale: 10 mm
	ROI Scale: None
	ROI bound: current
	
	
TestMode: 0

DeleteExisting: 1

OutputLabel: Human XYZ 0.05

This script will save the measures as two files: simple measures and pattern measures with the output label.