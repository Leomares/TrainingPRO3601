EXPORT File_crimes := MODULE
	EXPORT Layout := RECORD
		STRING8 ID;
		STRING11 CaseNumber;
		STRING22 Date;
		STRING38 Block;
		STRING4 IUCR;
		STRING33 PrimaryType;
		STRING60 Description;
		STRING53 LocationDescription;
		BOOLEAN Arrest;
		BOOLEAN Domestic;
		STRING4 Beat;
		STRING8 District;
		UNSIGNED8 Ward;
		STRING14 CommunityArea;
		STRING8 FBICode;
		STRING12 XCoord;
		STRING12 YCoord;
		STRING4 Year;
		STRING22 UpdateOn;
		INTEGER8 Latitude;
		INTEGER8 Longitude;
		STRING29 Location;
		END;
	EXPORT File := DATASET('~class::lmp::intro::crimes',Layout,CSV);
END;