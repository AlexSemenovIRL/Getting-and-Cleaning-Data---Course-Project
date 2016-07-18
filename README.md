# Getting and Cleaning Data Project

#### Alex Semenov

The script `run_analysis.R` performs the following steps described in the course project's definition:

* Download the dataset if it does not already exist in the working directory
* Load the activity and feature info
* Merge the training and the test sets together to create on dataset
* Then, extract only those columns with the mean and standard deviation measures from the whole dataset. 
* The activity names were extracted
* Appropriately label the data set with descriptive activity names
* Finally, a new dataset with all the average measures for each subject and activity type (Total = 180 rows) were extracted and the file `tidy.txt` was created
* The end result is shown in the file `tidy.txt`.
