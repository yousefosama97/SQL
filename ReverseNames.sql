# REVERSE Last Name and First Name
  
CONCAT(SUBSTING_INDEX (FullName, ' ', -1), SUBSTING_INDEX (FullName, ' ', 1)) ;

# Can use it as 
UPDATE Clients SET ReverseFullName = CONCAT(SUBSTING_INDEX (FullName, ' ', -1), SUBSTING_INDEX (FullName, ' ', 1)); 
