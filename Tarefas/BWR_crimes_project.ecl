import $,STD;

Crimes := $.File_crime_optimized.File;
LayoutCrimes := $.File_crime_optimized.NewLayout;

LayoutWithID := RECORD
    UNSIGNED recid;
    UNSIGNED date;
    STRING time;
    UNSIGNED4 id;
    STRING9 case_number;
    //STRING22 date;
    STRING38 block;
    STRING4 iucr;
    STRING33 primary_type;
    STRING60 description;
    STRING53 location_description;
    STRING5 arrest;
    STRING5 domestic;
    STRING4 beat;
    STRING3 district;
    UNSIGNED1 ward;
    UNSIGNED1 community_area;
    STRING3 fbi_code;
    UNSIGNED4 x_coordinate;
    UNSIGNED4 y_coordinate;
    UNSIGNED2 year;
    STRING22 updated_on;
    REAL8 latitude;
    REAL8 longitude;
    STRING29 location;
END;

// 09/05/2015 04:00:00 PM

LayoutWithID AddRecID(LayoutCrimes Le, UNSIGNED cnt):= TRANSFORM
  SELF.recid := cnt;
  SELF.date := STD.Date.FromStringToDate(Le.date[1..10], '%m/%d/%Y');
  SELF.time := 
      IF(Le.date[21..22] = 'PM' AND (UNSIGNED1)Le.date[12..13] < 12,
        (STRING2)((UNSIGNED1)Le.date[12..13]+ 12),
        Le.date[12..13])+
      Le.date[15..16]+
      Le.date[18..19];
  SELF := Le;
END;

Crimes_withID := PROJECT(Crimes, AddRecID(LEFT,COUNTER));

OUTPUT(Crimes);
OUTPUT(Crimes_withID);