
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
		X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
		;			
		%include ".\&dataPrepFileName.";
	%end;
%else
	%do;
		%include "~/&sasUEFilePrefix./&dataPrepFileName.";
	%end;
%mend;
%setup



title1
"Research Question: What are mean values for the variable of Time for the state 
in the descending order?"
;
title2
"Rationale: This should help find the state with the slowest swim times so the 
swim clubs might have better plans for improving the swim times for certain 
states with slower swim times."
;
footnote1
"Based on the above output, we can find the state of Nevada has the longest 
swim time, where the state of West Virginia has the shortest swim time."
;
footnote2
"Moreover, by using the _FREQ_ in the id statement for the temp sorted data 
file,  we can discover that the first seven states with the longest swim times 
have fewer swimmers for the competition."
;
footnote3
"Further analysis to look for geographic patterns is associated with the swim 
times, given the states with higher mean swim times, for example, the state of 
Nevada is in desert so the state might be short for water resources, building 
the swim pools would become expensive and having less swim pools for the senior 
to practice swim thereafter."
; 

*
Methodology: Use PROC MEANS to compute the mean of Time for State, and output
the results to a temportatry dataset. Use PROC SORT extract and sort just the
means the temporary dateset, and use PROC PRINT to print just the first thirty 
observations from the temporary dataset;
;
  
proc means 
        mean 
        noprint
        data=SST091113_analytic_file
    ;
    class State ;
    var Time;
    where length(State) = 2;
    output out=SST091113_analytic_file_temp;
run;

proc sort 
        data=SST091113_analytic_file_temp(where=(_STAT_="MEAN"))
    ;
    by descending Time;
run;
    
proc print 
        data=SST091113_analytic_file_temp
    ;
    id State _FREQ_ ;
    var Time;
    where State is not Null ;
run;

title;
footnote;

title1
"Research Question: How does the distribution of Time for swimmers 
comparing in 2009, 2011 and 2013?"
;
title2
"Rationale: This would help inform whether there is the improvement of the 
swim time over the years."
;
footnote1
"Based on the above output, we can find that the distribution of swim time 
was improved in 2013."
;
footnote2
"However the swim time in 2011 was the slowest overall, one of the reasons was  
the maximum swim time in 2011 is much longer than in 2009 and 2013, the data 
distribution had a higher skewed profile in 2009."
;
footnote3
"In addition, more analysis is needed for research of the correlation between 
swim time and economics situation in the country between the years of 2009 and 
2011. For example, if the US house and stock market crashed in 2007~2009 were 
related to the swim time."
; 
 
*
Methodolody: Compute five-number summaries and mean by Time variable;

proc means 
        min q1 median q3 max 
        data=SST091113_analytic_file maxdec=3
    ;
    class Year;
    var Time;
    where length(State) = 2;
run;

title;
footnote;

title1
"Research Question: How many the swimmers are in each state?"
;
title2
"Rationale: This would help determine which states have larger groups of 
swimmers so the swim clubs might have a better funding for future."
;
footnote1
"Based on the above output, the states of CA, TX and OH have the largest 
groups of swimmers in total three competition years."
;
footnote2
"Though the state of CA has the largest groups of swimmers in the 
competition during the years, the swimmers from CA were dropped 
significantly in 2013, further analysis is needed to determine if some 
improvements for the swimmers and swim club for the state of CA."
;

*
Methodology: Use proc freq to create a frequency table for swimmers in 
each state for three competition years;

proc freq data=SST091113_analytic_file order=freq;
    table State*Year 
    /norow nocol nopercent;
    where length(State) = 2;
run;

title;
footnote;