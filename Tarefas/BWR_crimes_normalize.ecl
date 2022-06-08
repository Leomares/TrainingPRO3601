import $,STD;

Crimes := $.File_crime_optimized.File;
LayoutCrimes := $.File_crime_optimized.NewLayout;

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
  DEDUP(AddressTable,ALL), 
	CrimeAddressFormat(LEFT,COUNTER)
 );

OUTPUT(CrimeAddress,NAMED('Locais'));

//Tratamento de crimes

CrimeData := RECORD
    UNSIGNED row_id;
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

CrimeData addressCode(LayoutCrimes Le, UNSIGNED code) := TRANSFORM
  SELF.row_id := code;
  SELF.Le;
END;

CrimeData_ID := PROJECT(
  //ROLLUP

);