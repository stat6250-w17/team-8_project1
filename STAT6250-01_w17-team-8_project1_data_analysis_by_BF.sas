
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
Research Question: What are the top twenty districts with the highest mean
values of "Time"?

Rationale: This should help find the state with the slowest swim times in 
year 2009, 2011 and 2013 so the swim clubs might have better plans for 
improving the swim times for certain states with slower swim times.

Methodology: Use PROC MEANS to compute the mean of Time for State and Year, 
and output the results to a temportatry dataset. Use PROC SORT extract and 
sort just the means the temporary dateset, and use PROC PRINT to print just 
the first twenty observations from the temporary dataset;
;
proc means mean noprint data=SST091113_analytic_file;
    class State Year ;
    var Time;
    output out=SST091113_analytic_file_temp;
run;

proc sort data=SST091113_analytic_file_temp(where=(_STAT_="MEAN"));
    by descending Time;
run;

proc print noobs data=SST091113_analytic_file_temp(obs=20);
    id State Year;
    var Time;
run;


*
Research Question: How does the distribution of "Time" for swimmers
comparing in 2009, 2011 and 2013?

Rationale: This would help inform whether the improvement of the swim time
over the years.

Methodolody: Compute five-number summaries by Time variable;

proc means min q1 median q3 max data=SST091113_analytic_file;
    class Year;
    var Time;
run;


*
Research Question: How many the swimmers are in each state?

Rationale: This would help determine which states have larger groups of 
swimmers so the swim clubs might have a better funding for future.

Methodology: Use proc freq to create a frequency talbe for swimmers in 
each state;

proc freq data=SST091113_analytic_file;
    table State;
run;
