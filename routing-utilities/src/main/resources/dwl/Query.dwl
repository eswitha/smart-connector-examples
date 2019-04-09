%dw 2.0
output application/xml
ns ns0 http://roadnet.com/apex/
ns ns1 http://roadnet.com/apex/DataContracts/
ns ns2 http://www.w3.org/2001/XMLSchema-instance
ns ns3 http://schemas.datacontract.org/2004/07/Roadnet.Apex.Server.Services.WCFShared.DataContracts.Expression
ns ns4 http://www.w3.org/2001/XMLSchema
ns ns5 http://schemas.datacontract.org/2004/07/Roadnet.Apex.Server.Services.DataTransferObjectMapping
fun checkFilterSetup(value) =
	if ((typeOf(value) as String) == "String")
		filterField(value)
	else
		filterCompoundField(value)
fun filterField(value) = 
	{
	    ns1#'$(value)' : true
	}
fun filterCompoundField(compoundSetup) =
	{
		ns1#'$(compoundSetup.name)' : {(compoundSetup.fields map ((record) ->
			checkFilterSetup(record)
		))}
	}
---
{
	ns0#Retrieve: {
		ns0#regionContext @(ns2#'type': 'ns1:SingleRegionContext', 'xmlns:ns1' : '$(ns1 as String)'): {
			ns1#BusinessUnitEntityKey: vars.businessUnit,
			ns1#RegionEntityKey: vars.region
		},
		ns0#options: {
			(ns1#Expression @(ns2#'type':'ns3:EqualToExpression', 'xmlns:ns3' : '$(ns3 as String)'): {
				ns3#Left @(ns2#'type':'ns3:PropertyExpression'): {
					ns3#Name: vars.configuration.expression.fieldName
				},
				ns3#Right @(ns2#'type':'ns3:ValueExpression'): {
					ns3#Value @(ns2#'type':'ns4:' ++ vars.configuration.expression.valueType, 'xmlns:ns4' : '$(ns4 as String)'): vars.configuration.expression.value
				},
			}) if (vars.configuration.expression != null),
			ns1#FilterChildren: false,
			ns1#IncludeDeleted: false,
			ns1#PageIndex: 0,
			ns1#PageSize: 0,
			ns1#Paged: false,
			ns1#PropertyInclusionMode: if (vars.configuration.retrievalFields == null) 'All' else 'AccordingToPropertyOptions',
			(ns1#PropertyOptions @(ns2#'type' : 'ns1:' ++ vars.configuration.retrievalFields.propertyType) : {
				(ns5#CustomProperties: vars.configuration.retrievalFields.customFields) if (vars.configuration.retrievalFields.customFields != null),
	        		(vars.configuration.retrievalFields.fields map ((field) ->
	        			checkFilterSetup(field)
	            ))
	        }) if (vars.configuration.retrievalFields != null),
			ns1#ReturnTotalItems: false,
			ns1#ReturnTotalPages: false,
			ns1#Type: vars.configuration.returnType			
		}
	}
}