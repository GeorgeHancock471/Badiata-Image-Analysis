mspecGate=1;

while(mspecGate==1){


//Clear ROIs
while(roiManager("Count")>0){
roiManager("select",newArray(roiManager("Count")));
roiManager("Delete");
}



//Clear Images
close("*");


setTool("rectangle");
// STEP 1. MSPEC CREATION
//........................................................

//Select image
waitForUser("Open a Raw Image");



//Use the RAW name for the MSPEC
imagePath=File.openDialog("Select Raw Image" );
imageName=replace(File.getName(imagePath),".ORF","");

//Create the MSPEC
run(" Generate Multispectral Image", "camera=Visible image=[RAW Photo] grey=[Same photo] standard=3,91 alignment=None image_0=[Linear Normalised Reflectance Stack] image_1="+imageName+" select=["+imagePath+"]");



// STEP 2. Scale Bar
//........................................................

run("Select None");

setTool("line");
waitForUser("Draw a line on the scale bar.\nThen hit OK");
if(selectionType() == 5 || selectionType() == 6){ // straight line - calculate pythagorean distance
	getSelectionCoordinates(xCoords, yCoords);
	scaleLength = pow(pow(xCoords[0]-xCoords[1],2) + pow(yCoords[0]-yCoords[1],2), 0.5);
} else { // other shape (hopefully square or circle for ball bearing etc..) so take average bounds
	waitForUser("The selection isn't a line, so the tool will take the average bounds (w+h)/2");
	getSelectionBounds(x, y, selWidth, selHeight);
	scaleLength = (selWidth + selHeight)/2;
}

Dialog.create("Scale Bar");
	Dialog.addMessage("How long is the scale bar?");
	Dialog.addNumber("Length, diameter or bounding box dimensions (e.g. in mm)", 0);
Dialog.show();

	rulerLength = Dialog.getNumber();

if(rulerLength >= 0 || rulerLength <= 0){
	letter = "Scale Bar:" + scaleLength + ":" + rulerLength;
	roiManager("add");
	roiManager("select",roiManager("count")-1);
	roiManager("rename",letter);
}else waitForUser("Error","Please only enter numbers in the scale bar length");



// STEP 5. Save
//........................................................

	//savePath = getInfo("log");
	//savePath = split(savePath, "\n");
	savePath = getMetadata("Info");
	//saveFlag = 0;

	if(endsWith(savePath, ".mspec") == false)
		savePath = File.openDialog("Select image config file");

	fileType = ".zip"; // seems to only want zips even with one selection
	savePath = replace(savePath, ".mspec", fileType); // replace .txt with either .roi or .zip as required

	selectionArray = newArray(roiManager("count"));

	for(i=0; i<roiManager("count"); i++)
		selectionArray[i] = i;

	roiManager("Select", selectionArray);

	roiManager("Save", savePath);

	showStatus("Done saving ROIs with multispectral image");
	
	print(" \nROIs saved to: " + savePath);
	
	
close();

mspecGate=getBoolean("Are there more images to do?");
}
