/*
Cobra History Query 
Andreas Haslbeck
06.2019
*/


SELECT Adresse.ID
		,Adresse.COMPANY1
		,Adresse.FIRSTNAME0
		,Adresse.LASTNAME0
		,Adresse.MODIFIEDBY
		,Adresse.DATEMODIFIED
		,History_Config.TableName
		,AP_FIELDINFOS.LOGICAL_NAME
		,AP_FIELDINFOS.USERLEVEL_NAME
		,History_ResultDetail.OLDVALUE
		,History_ResultDetail.NEWVALUE
		,History_ResultDetail.COLUMNID 
FROM ADDRESSES as Adresse
INNER JOIN History_ResultDetail as History_ResultDetail
	ON Adresse.Id = History_ResultDetail.ADDRESSID
INNER JOIN History_Result as History_Result
	ON History_Result.TID = History_ResultDetail.TID
INNER JOIN History_Config as History_Config
	ON History_Config.TableID = History_Result.TABLEID
INNER JOIN History_Config_Fields as History_Config_Fields
	ON History_Config_Fields.[Table] = History_Config.TableName
INNER JOIN [AP_FIELDINFOS] as AP_FIELDINFOS
	ON AP_FIELDINFOS.LOGICAL_NAME = History_Config_Fields.NAME
-- Clauses ändern !!!!!
WHERE History_Config.TableID = '2' 
AND Adresse.YESNO41 = '1' 
AND ISDATE(History_ResultDetail.OLDVALUE) = 0 
AND History_ResultDetail.NEWVALUE is not NULL 
AND AP_FIELDINFOS.USERLEVEL_NAME != N'GUID' 
AND LOGICAL_NAME != N'DATEMODIFIED' 
AND LOGICAL_NAME != N'DATECREATE'
AND LOGICAL_NAME != N'MODFIEDBY'
AND LOGICAL_NAME != N'CREATEDBY'
AND Adresse.MODIFIEDBY like N'%cobra%'
AND History_ResultDetail.OLDVALUE NOT LIKE History_ResultDetail.NEWVALUE
ORDER BY Adresse.ID

    