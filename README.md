# gettingandcleaningData

The script run_analysis.R first reads in the data for both testing and training. 

The training and testing datasets are then merged together in new datasets by adding the observations from testing at the end of the training datasets using rbind

This is done for X, y and subject

The column names are then made nicer by reading in the appropriate names from "features.txt" for X.
The names of the activities are looked up from "activity_labels.txt" for y.

A temporary data.frame called "used_data"  is created using only the columns with "mean(" or "std" in the column names. 
This is done in order to extract only the measurements on the mean and standard deviation for each measurement. 

Note that in order to leave out column names like "fBodyAcc-meanFreq()-X" which do not contain the mean of some results but rather a feature called meanFreq, 
we search for mean( with a parenthesis. 

The names of the relevant activities are added to the data.frame by using cbind
The ID of the subject being observed in each line is added from the subject data by using cbind

This concludes step 4 in the instructions.

Finally a new dataset is created by averaging all the measurements and grouping by subject and activity.

This is done using the data.table package