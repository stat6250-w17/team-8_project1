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

Data Source: The file 
http://ww2.amstat.org/publications/jse/v22n1/doane/SeniorSwimTimes-DataSet.txt
was downloaded & edited to produce file sst091113_edited.xls by replacing the
missing value with blank cell, reformatting column variable according SAS 
variable naming rules, for example, changing Split-1 to Split_1, etc.

Data Dictionary: 
http://ww2.amstat.org/publications/jse/v22n1/doane/SeniorSwimTimes-Documentation.doc
or worksheet "Data Field Descriptions" in file sst091113_edited.xls

Unique ID: Obs
;

* setup environmental parameters;
%let inputDatasetURL =
http://filebin.ca/39intHCKjBzE/sst091113_edited.xls
;

* create output formats;
proc format;
    value Age   
        low-64  ='< 65'
        65-80   ='65-80'
        81-high ='> 80'
    ;
    value seed 
        low-450 ='< 450'
    ;
run;

* load raw senior swim times dataset over the wire;
filename SSTtemp TEMP;
proc http
    method="get" 
    url="&inputDatasetURL." 
    out=SSTtemp
    ;
run;
proc import
    file=SSTtemp
    out=SST091113_raw
    dbms=xls
    ;
run;
filename SSTtemp clear;

* check raw SST dataset for duplicates with respect to its unique key;
proc sort 
        nodupkey 
        data=SST091113_raw 
        dupout=SST091113_raw_dups 
        out=_null_
    ;
    by Obs
    ;
run;


* build analytic dataset from senior swim times dataset with the least number of
columns and minimal cleaning/transformation needed to address research questions
in corresponding data-analysis files;
data SST091113_analytic_file;
    retain
        Place
	State
        Gender
        Age
        AgeGrp
        Seed
	Time
	Year
        Split_1
        Split_2
        Split_3
        Split_4
        Split_5
        Split_6
        Split_7
        Split_8
        Split_9
        Split_10
    ;
    keep
        Place
	State
        Gender
	Age
	AgeGrp
        Seed
        Time
	Year
        Split_1
        Split_2
        Split_3
        Split_4
        Split_5
        Split_6
        Split_7
        Split_8
        Split_9
        Split_10
    ;
    set SST091113_raw;
run;
