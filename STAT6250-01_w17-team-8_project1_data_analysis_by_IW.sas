

*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
This file prepares the dataset described below for analysis.

Dataset Name: Senior Swimm Times

Experimental Units: Three years (2009, 2011, 2013), cross-sectional (565 
individuals) swimming time.

Number of Observations: 565

Number of Features: 21

Data Source: The file http:// .txt was
downloaded & edited to produce file sst091113-edited.xls by 

Data Dictionary: http://  or worksheet
"Data Field Descriptions" in file sst091113-edited.xls

Unique ID: Obs
;

* setup environmental parameters;
%let inputDatasetURL =
http://filebin.ca/39cGB7L4N9rr/sst091113-edited.xls
;

*
Research Question: What is the correlation between Time and Seed?

Rationale: This should help to understand if lower time during state competitions is a good predictor of 
athlete performance in national competitions.
 
Methodology: Using PROC CORR to calculate simple correlation analysis;


proc corr data=SST091113_analytic_file pearson nosimple noprob plots=none;
	var seed_2;
	with Time;
run; 
