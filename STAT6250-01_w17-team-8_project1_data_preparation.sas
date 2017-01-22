
This file prepares the dataset described below for analysis.
Dataset Name: Senior Swimm Times
Experimental Units: Three years (2009, 2011, 2013), cross-sectional (565 
individuals) swimming time.
Number of Observations: 565
Number of Features: 21
Data Source: The file http:// .txt was
downloaded & edited to produce file sst091113-edited.xls by 
Data Dictionary: http://  or worksheet
"Data Field Descriptions" in file sst091113_edited.xls
Unique ID: Obs
;

* setup environmental parameters;
%let inputDatasetURL =
http://filebin.ca/39cGB7L4N9rr/sst091113-edited.xls
;

*
age frequency
;

proc freq data=sst091113_edited;
   tables Age;
run;


*
gender ratio?
;


    proc freq data=sst091113_edited;
   tables Gender;   
    
run;

*
gender for 2009
;

option firstobs=2 obs=200;
proc print data=sst091113_edited;
run;
proc freq data=sst091113_edited;
table Gender;
run;


*
Min and Max of Splits times
;

proc means data=sst091113_edited min max maxdec=0;
   var Split_1 Split_2 Split_3 Split_4 Split_5 Split_6 Split_7 Split_8 Split_9 Split_10;
run;
