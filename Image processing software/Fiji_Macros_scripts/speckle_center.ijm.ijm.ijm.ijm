
//saveAs("Results", "C:/Users/91897/Desktop/CP302/Results_speckle.csv");

// Set the input and output directories
//inputDir = "C:/Users/91897/Desktop/Vinegar_eels/Center/";
//outputPath = "C:/Users/91897/Desktop/CP302/Center_Speckle_image_processed/Optical_intensity/results.csv";

// Open a new file to write the results
// = File.open(outputPath);
//File.append("Image Name, Optical Intensity", file);

// List all files in the input directory
//list = getFileList(inputDir);

// Process each file
//for (i = 0; i < list.length; i++) {
    // Check if the file is an image
    //if (endsWith(list[i], ".png")) {
        // Open the image
        //open(inputDir + list[i]);
        
        //setTool("rectangle");
        //makeRectangle(208, 0, 1096, 821);
        
        // Convert image to grayscale if necessary
        //run("8-bit");

        //run("Measure");

        // Get the optical intensity from the results table
       // intensity = getResult("Mean", nResults - 1);

        // Write the image name and optical intensity to the CSV file
        //File.append(list[i] + ", " + intensity, file);
        
        // Close the image
        //close();
   // }
//}

// Close the results file
//File.close(file);

// Notify the user
//print("Processing complete! Results saved to " + outputPath);

// Set the input and output directories
inputDir = "C:/Users/91897/Desktop/Vinegar_eels/Center/";
outputPath = "C:/Users/91897/Desktop/CP302/Center_Speckle_image_processed/Optical_intensity/results.csv";

// Open a new file to write the results
file = File.open(outputPath);
File.append("Image Name, Optical Intensity", outputPath);

// List all files in the input directory
list = getFileList(inputDir);

// Process each file
for (i = 0; i < list.length; i++) {
    // Check if the file is an image (only process .png files)
    if (endsWith(list[i], ".png")) {
        // Open the image
        open(inputDir + list[i]);
        
        // Convert the image to grayscale if necessary
        run("8-bit");

        run("Measure");

        // Get the optical intensity (mean value) from the results table
        intensity = getResult("Mean", nResults - 1);

        // Write the image name and optical intensity to the CSV file
        File.append(list[i] + ", " + intensity, outputPath);
        
        // Close the image
        close();
    }
}

// Notify the user
print("Processing complete! Results saved to " + outputPath);
