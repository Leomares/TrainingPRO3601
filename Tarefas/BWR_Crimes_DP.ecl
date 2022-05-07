IMPORT $,STD;

Crimes := $.File_crime_raw.File;
CrimesOpt := $.File_crime_optimized.File;

profileResults := STD.DataPatterns.Profile(CrimesOpt);
//bestrecord     := STD.DataPatterns.BestRecordStructure(Crimes);


OUTPUT(profileResults, ALL, NAMED('profileResults'));
//OUTPUT(bestrecord, ALL, NAMED('BestRecord'));

