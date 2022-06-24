import $;
 
//build($.File_crime_optimized.Index_file,OVERWRITE);

Crimes := $.File_crime_optimized.File;
CrimesLayout := $.File_crime_optimized.NewLayout;

Crime_format := RECORD
  Crimes.block;
  Crimes.primary_type;
  number_cnt := COUNT(GROUP);
 END;
 
EXPORT FilteredCrimes := SORT(TABLE(Crimes,Crime_format,block,primary_type),block,-number_cnt);

//OUTPUT(FilteredCrimes);