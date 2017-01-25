
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


*
Question: What is the distribution of time in each age group?
Rationale: I can compare range, minimum and maximum time and other statistics for each age group (50-54, 55-59). 
Methodology: PROC MEANS statement together with statistics to be computed
;

PROC MEANS DATA=sst091113_edited MIN MAX P25 P75 MEDIAN MAXDEC=0;
    class AgeGrp;
    var Time;
run;

*
Question: What is the distribution of time in each gender group in each year?
Rationale: I can compare how minimum, maximum and percentile values are different in each year among men versus women.
Methodology: PROC MEANS statement along with statistics and class statement for each year and gender categories.
;

PROC MEANS DATA=sst091113_edited MIN MAX P25 P75 MEDIAN MAXDEC=0;
    class Year Gender;
    var Time;
run;

*
Question: What is the average and standard deviation in split_1 and split_10 times for swimmers
who achieved top 5 places in each gender?
Rationale: This shows how a group of swimmers (here the group is based on position) strategize his/her race depending on the progression.
Methodology: PROC MEANS and WHERE statement to limit the top places.
;

PROC MEANS DATA=sst091113_edited MEAN STD MAXDEC=0;
	CLASS GENDER PLACE;
	VAR SPLIT_1 SPLIT_10;
	WHERE PLACE <= 5;
RUN;
