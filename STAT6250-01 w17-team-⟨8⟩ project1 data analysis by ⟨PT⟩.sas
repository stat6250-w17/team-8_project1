

*Question: what is the average age of the group who attendence in these three years?

proc freq data=SST091113_raw;
   tables Age;
run;

*I used above coding to calculating the weight of each age and then calculation the average age.



proc freq data=SST091113_raw;
   tables item4-item6;
run;

proc format;
   value Age   low-64='< 65'
               65-80='65-80'
               81-high='> 80';
               
    value seed   low-450='< 450';
    
run;

*question:compare the gender ratio of swimmers for 2009 and overall three years?

*First I need to code the gender ratio for all three years as:

    proc freq data=SST091113_raw;
   tables Gender;   
    
run;

*Now its time to code the gender ratio for 2009 as:

    proc freq data=SST091113_raw(obs199);
   tables Gender;   
    
run;

*Question: Is there any difference between Splits in their Min and Max?

proc means data=SST091113_raw min max maxdec=0;
   var Split_1 Split_2 Split_3 Split_4 Split_5 Split_6 Split_7 Split_8 Split_9 Split_10;
run;



