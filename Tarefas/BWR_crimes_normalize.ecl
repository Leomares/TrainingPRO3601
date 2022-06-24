import $,STD;

Crimes := $.File_crime_optimized.File;
LayoutCrimes := $.File_crime_optimized.NewLayout;

OUTPUT(Crimes,NAMED('Crimes'));

//Dados totais de local
//LayoutAddress := RECORD
//	 UNSIGNED row_id;
//   STRING38 block;
//    STRING53  location_description;
//    STRING4 beat;
//    STRING3 district;
//   UNSIGNED1 ward;
//    UNSIGNED1 community_area;
//    UNSIGNED4 x_coordinate;
//    UNSIGNED4 y_coordinate;
//    UNSIGNED2 year;
//    REAL8 latitude;
//    REAL8 longitude;
//    STRING29 location;
//END;

//Tratamento de enderecos

Address := RECORD
  Crimes.district; 
  Crimes.community_area; 
  Crimes.block;
END;

Address_ID := RECORD
  UNSIGNED row_id;
  Crimes.district; 
  Crimes.community_area; 
  Crimes.block;
END;

Address_ID CrimeAddressFormat(Address Le, UNSIGNED cnt) := TRANSFORM
	SELF.row_id := cnt;
	SELF := Le;
END;

AddressTable := TABLE(Crimes, Address);

CrimeAddress := PROJECT(
  AddressTable, 
	CrimeAddressFormat(LEFT,COUNTER)
 );

Address_ID duplicate(Address_ID Le, Address_ID Ri) := TRANSFORM
  SELF.row_id := IF(Ri.row_id <= Le.row_id,Ri.row_id,Le.row_id);
  SELF := Le;
END;

CrimeAddress_dup := ROLLUP(
  CrimeAddress,
  LEFT.district = RIGHT.district AND
  LEFT.community_area = RIGHT.community_area AND 
  LEFT.block = RIGHT.block,
  duplicate(LEFT,RIGHT)
);

OUTPUT(CrimeAddress_dup,NAMED('Locais'));

//Tratamento de crimes

CrimeData := RECORD
    UNSIGNED add_id;
    UNSIGNED date;
    STRING time;
		UNSIGNED4 id;
    STRING9 case_number;
    STRING4 iucr;
    STRING33 primary_type;
    STRING60 description;
    STRING5 arrest;
    STRING5 domestic;
    STRING3 fbi_code;
    UNSIGNED2 year;
    STRING22 updated_on;
END;

CrimeData AddID(LayoutCrimes Le, CrimeAddress A):= TRANSFORM
  SELF.date := STD.Date.FromStringToDate(Le.date[1..10], '%m/%d/%Y');
  SELF.time := 
      IF(Le.date[21..22] = 'PM' AND (UNSIGNED1)Le.date[12..13] < 12,
        (STRING2)((UNSIGNED1)Le.date[12..13]+ 12),
        Le.date[12..13])+
      Le.date[15..16]+
      Le.date[18..19];
  SELF := Le;
  SELF.add_id := A.row_id;
END;

//normalizacao dos enderecos nos dados de crimes
 

Crime_withID := JOIN(
    Crimes, CrimeAddress_dup, 
    LEFT.district = RIGHT.district AND
    LEFT.community_area = RIGHT.community_area AND 
    LEFT.block = RIGHT.block,
    AddID(LEFT,RIGHT),
    LEFT OUTER,
    LOOKUP
  );

OUTPUT(Crime_withID,NAMED('Normalizado'));