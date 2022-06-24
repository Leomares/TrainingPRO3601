import $;

EXPORT FN_SearchCrimes(STRING38 block_of_interest):= FUNCTION
    
   RETURN OUTPUT($.FilteredCrimes(block = block_of_interest));
   
END;