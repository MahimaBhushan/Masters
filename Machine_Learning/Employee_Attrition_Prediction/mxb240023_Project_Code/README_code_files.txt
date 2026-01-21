This folder contains all the Jupyter Notebooks and dataset files used in the Employee Attrition Prediction project.

1. 01_ML_Project_Data_Loading_and_EDA.ipynb

Loads the IBM HR Analytics dataset

Performs cleaning and initial inspection

Conducts Exploratory Data Analysis (EDA)

Generates plots such as histograms, bar charts, box plots

Saves the cleaned dataset (df_after_eda.csv)


2. 02_ML_Project_Data_Preprocessing.ipynb

Removes constant/non-informative columns

Performs One-Hot Encoding on categorical features

Scales numerical features

Applies Train/Test split

Uses SMOTE to balance classes

Saves processed dataset in the folder Preprocessed_Data


3. 03_ML_Project_Modeling_and_Training.ipynb

Loads preprocessed training & test files

Trains four ML models: Logistic Regression, Decision Tree, Random Forest, XGBoost

Computes accuracy, precision, recall, F1-score

Plots ROC and Precision–Recall curves

Generates comparison tables

Saves best model metrics


4. WA_Fn-UseC_-HR-Employee-Attrition.csv

Original IBM HR Analytics dataset (raw data)


5. df_after_eda.csv

Cleaned dataset generated after EDA

Used for preprocessing


6. Preprocessed_Data Folder

Contains:

Processed training and test CSV files

Scaled & balanced datasets

Ready-to-use data for model training