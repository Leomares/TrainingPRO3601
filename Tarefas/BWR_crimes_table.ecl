import TrainingPRO3601;

Crimes := TrainingPRO3601.Tarefas.File_crime_optimized.File;

lessCrimes := Crimes(year >= 2010,year < 2021);

yearly_data := RECORD 
  lessCrimes.year;
  number := COUNT(GROUP);
END;

Yearly_crimes := TABLE(lessCrimes,yearly_data,year);

OUTPUT(Yearly_crimes);

average := AVE(Yearly_crimes,Yearly_crimes.number);
OUTPUT(average);