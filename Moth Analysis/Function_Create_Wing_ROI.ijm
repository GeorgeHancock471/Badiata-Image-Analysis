run("RGB Color");
roiManager("Show All");

iw=getWidth();

setTool("polygon");
waitForUser("Draw a polygon around the wing\nThen click OK");
run("Make Inverse"); run("Set...","value=255");
run("Select None");
run("Wand Tool...", "tolerance=11 mode=Legacy");
setTool("wand");
waitForUser("Select the remaining background using Shift Click\n Then click OK");


run("Set...","value=255");
run("32-bit");

setThreshold(0,250);
run("Create Selection");
run("Set...","value=0");


waitForUser("Use the pen tool to clean any holes");

run("Analyze Particles...", "size=3000-Infinity pixel add");

roiManager("select",roiManager("count")-1);
Roi.getBounds(x,y,w,h);
close();

T=getTitle();

sArray=newArray("l","r");
s=0;
if(x>iw/2) s=1;

Dialog.createNonBlocking("Moth_ID");
Dialog.addMessage("Assign the correct lablel\n l=left, r=right.") 
Dialog.addChoice("Side",sArray,sArray[s]);
Dialog.show();

roiManager("Select", roiManager("count")-1);

roiN = T+"_"+Dialog.getChoice();
roiManager("Update");
roiManager("Rename",roiN);


