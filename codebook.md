# Code Book - Getting and Cleaning Data Project

This Code Book describes the data, variables, and transformations performed to clean up the source data and produce the final tidy dataset.

## Source Data Description
The source data comes from the "Human Activity Recognition Using Smartphones Dataset". It contains data collected from 30 volunteers performing daily activities while wearing a smartphone equipped with embedded inertial sensors (accelerometer and gyroscope).

## Transformations Applied

1. The training (`train`) and testing (`test`) datasets were merged to form a single dataset.
2. Only features calculating the mean (`mean()`) and standard deviation (`std()`) were extracted.
3. Activity numeric IDs were mapped to literal descriptors based on `activity_labels.txt`.
4. Variable names were cleaned using the following rules:
   * Prefixes `t` and `f` were expanded to `time` and `frequency`.
   * `Acc` was replaced with `Accelerometer`.
   * `Gyro` was replaced with `Gyroscope`.
   * `Mag` was replaced with `Magnitude`.
   * Body duplication typos like `BodyBody` were fixed to `Body`.
   * Dashes `-` and parentheses `()` were removed, and proper CamelCase was applied.
5. The dataset was aggregated by taking the average (`mean`) of each variable for each unique combination of subject and activity.

## Variables in the Tidy Dataset

The final tidy dataset (`tidy_dataset.txt`) consists of **180 rows** and **68 columns**.

### Identifiers
* **`subjectId`** (Integer): The unique identification number of the volunteer participant. Ranges from 1 to 30.
* **`activity`** (Factor): The descriptive name of the activity performed by the subject when measurements were taken. 
  * `WALKING`
  * `WALKING_UPSTAIRS`
  * `WALKING_DOWNSTAIRS`
  * `SITTING`
  * `STANDING`
  * `LAYING`

### Sensor Measurements (66 Columns)
All feature variables listed below are **numeric** values. They represent the **mean average** calculated for each subject and activity. 

*Note: All original sensor signals were normalized and bounded within a scope of `[-1, 1]`, making these aggregated averages unitless.*

#### Time-Domain Signals
* `timeBodyAccelerometerMeanX` / `Y` / `Z`
* `timeBodyAccelerometerSTDX` / `Y` / `Z`
* `timeGravityAccelerometerMeanX` / `Y` / `Z`
* `timeGravityAccelerometerSTDX` / `Y` / `Z`
* `timeBodyAccelerometerJerkMeanX` / `Y` / `Z`
* `timeBodyAccelerometerJerkSTDX` / `Y` / `Z`
* `timeBodyGyroscopeMeanX` / `Y` / `Z`
* `timeBodyGyroscopeSTDX` / `Y` / `Z`
* `timeBodyGyroscopeJerkMeanX` / `Y` / `Z`
* `timeBodyGyroscopeJerkSTDX` / `Y` / `Z`
* `timeBodyAccelerometerMagnitudeMean` / `STD`
* `timeGravityAccelerometerMagnitudeMean` / `STD`
* `timeBodyAccelerometerJerkMagnitudeMean` / `STD`
* `timeBodyGyroscopeMagnitudeMean` / `STD`
* `timeBodyGyroscopeJerkMagnitudeMean` / `STD`

#### Frequency-Domain Signals
* `frequencyBodyAccelerometerMeanX` / `Y` / `Z`
* `frequencyBodyAccelerometerSTDX` / `Y` / `Z`
* `frequencyBodyAccelerometerJerkMeanX` / `Y` / `Z`
* `frequencyBodyAccelerometerJerkSTDX` / `Y` / `Z`
* `frequencyBodyGyroscopeMeanX` / `Y` / `Z`
* `frequencyBodyGyroscopeSTDX` / `Y` / `Z`
* `frequencyBodyAccelerometerMagnitudeMean` / `STD`
* `frequencyBodyAccelerometerJerkMagnitudeMean` / `STD`
* `frequencyBodyGyroscopeMagnitudeMean` / `STD`
* `frequencyBodyGyroscopeJerkMagnitudeMean` / `STD`
