

This file uses the following analytic dataset to address several research
questions regarding Swimming time for seniors

Dataset Name:Senior Swimm Times, STAT6250-01_w17-team-8_project1_data_preparation.sas
, which is assumed to be in the same directory as this file

See included file for dataset properties
;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-8_project1_data_preparation.sas;
%let sasUEFilePrefix = team-8_project1;

* load external file that generates analytic dataset SST091113_analytic_file
using a system path dependent on the host operating system, after setting the
relative file import path to the current directory, if using Windows;
%macro setup;
%if
	&SYSSCP. = WIN
%then
	%do;
		X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";			
		%include ".\&dataPrepFileName.";
	%end;
%else
	%do;
		%include "~/&sasUEFilePrefix./&dataPrepFileName.";
	%end;
%mend;
%setup


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
Question: what is the average age of the group who attendence in these three years?
;

proc freq data=SST091113_raw;
   tables Age;
run;

*
I used above coding to calculating the weight of each age and then calculation the average age.
;



proc freq data=SST091113_raw;
   tables item4-item6;
run;

proc format;
   value Age   low-64='< 65'
               65-80='65-80'
               81-high='> 80';
               
    value seed   low-450='< 450';
    
run;

*
question:compare the gender ratio of swimmers for 2009 and overall three years?
;

First I need to code the gender ratio for all three years as:

    proc freq data=SST091113_raw;
   tables Gender;   
    
run;

option firstobs=2 obs=200;
proc print data=SST091113_raw;
run;
proc freq data=SST091113_raw;
table Gender;
run;


*
Question: Is there any difference between Splits in their Min and Max?
;

proc means data=SST091113_raw min max maxdec=0;
   var Split_1 Split_2 Split_3 Split_4 Split_5 Split_6 Split_7 Split_8 Split_9 Split_10;
run;







