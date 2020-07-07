---
title: "Codebook"
output: html_document
---

This document explains the variables and transformations performed for cleaning the data.

# Data

The data is data collected from the accelerometers from the Samsung Galaxy S smartphone, and was obtained from: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

# Variables

data_observations: observations from the accelerometers from the sansung galaxy S.\\
data_labels: activities from which the observations were obtained.\\
data_subjects: subjects from whiich the observations were obtained.\\
features: lists of variable names in the observation data set from the messy data.\\
activities: lists of activities names from the messy data.\\
tidy_data: cleaned data.\\
average_data: averages of each variable in tidy_data by Activity and Subjects.\\

# Transformations

1. First merge all rows between test and train data to obtain only 3 data sets.
2. Name all variables in the data sets obtained from the point 1.
3. Name all activities in the label data set.
3. Extract only the variables with measures of the mean and standard deviation in the observations data set.
4. Merge all data by column.
5. From the data obtained in the previous point, create a data set with the averages of each variable in tidy_data by Activity and Subjects.