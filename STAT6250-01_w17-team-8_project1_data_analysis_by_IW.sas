
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding 500-yard freestyle swim times for male and female swimmers 
age 50-94 in a biennial national competition in 2009, 2011 and 2013. The 
research tries to find out if some improvements over the years for the swim 
completions, and have some insight if the further funding or investment for the 
swim clubs.


Dataset Name: SST091113_analytic_file created in external file
STAT6250-01_w17-team-8_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

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




title1
"Research Question: What was the distribution of time in each age group?"
;
title2
"Rationale: I can compare range, minimum and maximum time and other statistics for each age group (50-54, 55-59)."
;
footnote1
"The minimum and quartile distribution of time by each group shows the expected outcome, i.e. time taken to compete
increases with the age of the athlete."
;
footnote2
"However, the range and the maximum time show that Age Group 3 (60-64 year old) took the 
longest time range among its participants, which can be attributed the higher number of contestents in this
age group in comparison to other age groups."
;
footnote3
"Further analysis can be done on Age Group 8 as this group has only 23 contentents, but has a 
higher time range comparative to other age groups"
;
*
Methodology: PROC MEANS statement together with statistics to be computed;
;

proc means 
	min max p25 p75 median range maxdec=0
	data=SST091113_analytic_file;
    	class AgeGrp;
    	var Time;
run;
title;
footnote;



title1
"Research Question: What is the distribution of time in each gender group in each year?"
;
title2
"Rationale: I can compare how minimum, maximum and percentile values are different in each year among men versus women."
;
footnote1
"Over 3 years of the meet, median times of athletes have decreased perhaps due to an improvement in training."
;
footnote2
"However, the lowest time recorded for both male and female atheletes have increased over the 3 years of the meet."
;
footnote3
"Further analysis could be conducted on the decreasing number of athlete participation in 2013 in comparison to previous years."
*
Methodology: PROC MEANS statement along with statistics and class statement for each year and gender categories.
;

proc means 
	 min max p25 p75 mediam maxdec=0
	 data=SST091113_analytic_file;
    	class Year Gender;
    	var Time;
run;
title;
footnote;


title1
"Research Question: What is the average and standard deviation in split_1 and split_10 times for swimmers
who achieved top 5 places in each gender?"
;
title2
"Rationale: This shows how a group of swimmers (here the group is based on position) strategize his/her race depending on the progression."
;
footnote1
"The output produced for those on the top 5 positions shows that male participants who won 1st and 2nd places have the same standard 
deviation while this is true for female particpants who won 3rd and 4th places."
;
footnote2
"Female atheletes in 1st place seem to have the highest deviation from mean times for split 1 and 10."
;
footnote3
"Further analysis can be performed on split 1 and 10 times for contestants in the bottom 5 positions, so 
comparisons could be done on all contestants."
;
*
Methodology: PROC MEANS and WHERE statement to limit the top places.
;

proc means mean std maxdec=0
	data=SST091113_analytic_file;
	class Gender Place;
	var Split_1 Split_10;
	where Place <= 5;
run;
title;
footnote;
