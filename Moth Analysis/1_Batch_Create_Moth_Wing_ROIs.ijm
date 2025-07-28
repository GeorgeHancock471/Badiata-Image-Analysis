D=getDirectory("MSPECS");

FL = getFileList(D);

ML =newArray();

for(i=0;i<FL.length;i++){
if(endsWith(FL[i],".mspec")) ML=Array.concat(ML,FL[i]);
}

Array.show(ML);


for(m=0; m<ML.length; m++){

	savePath = D+ML[m];

	fileType = ".zip"; // seems to only want zips even with one selection
	savePath = replace(savePath, ".mspec", fileType); // replace .txt with either .roi or .zip as required


if(File.exists(savePath)){
close("*");
run(" Load Multispectral Image", "select="+D+ML[m]);


mothGate=1;
mT=0;
while(mothGate==1){

run("Function Create Wing ROI");


mT=mT+1;
mothGate=0;
if(mT<2) mothGate=getBoolean("Are there more moths to do?");

}



	selectionArray = newArray(roiManager("count"));

	for(i=0; i<roiManager("count"); i++)
		selectionArray[i] = i;

	roiManager("Select", selectionArray);

	roiManager("Save", savePath);

	showStatus("Done saving ROIs with multispectral image");
	
	print(" \nROIs saved to: " + savePath);
}}


waitForUser("All MSPECs complete");