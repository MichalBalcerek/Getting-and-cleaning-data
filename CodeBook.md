#Introduction
The script "run_analysis.R" provides the code which performs all the 5 steps described in the course project:

- first, it reads all the necessary data to find all variables with mean/std;
- then, it finds all the rows with such strings: I did it in such way to subset the big data in the moment of reading it, instead of doing it later;
- later, it reads all the data (x_trains, x_tests, etc), but using only those rows found in the previous step;
- then, it all binds the data together (cbind);
- finally, it adds the appropriate labels and variable names and then it calculates required average measures for each subject and activity type (the output is called "tidy.txt")

#Variables

- "features" contains the correct names of the features for the final dataset ("allData"), which are applied to the column names stored in "meanStd_cols", a numeric vector which points to rows of desired data;
- "activityLabels" contains the correct names of activities for the final dataset ("allData");
- "x_train", "y_train", "x_test", "y_test", "subject_train" and "subject_test" contain the data from the downloaded files of the corresponding names;
- "train" merges (cbind) all train data ("x_train", "y_train" and "subject_train");
- "test" merges (cbind) all test data ("x_test", "y_test" and "subject_test");
- "allData" merges "train" and "test" in a big dataset;
- finally, "allData.mean" contains the relevant averages which will be later stored in a "tidy.txt" file.
