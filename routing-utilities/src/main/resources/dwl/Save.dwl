%dw 2.0
output application/xml
ns ns0 http://roadnet.com/apex/
ns ns1 http://roadnet.com/apex/DataContracts/
ns ns2 http://www.w3.org/2001/XMLSchema-instance
ns ns3 http://schemas.datacontract.org/2004/07/Roadnet.Apex.Server.Services.DataTransferObjectMapping
ns ns4 http://schemas.microsoft.com/2003/10/Serialization/Arrays
ns ns5 http://www.w3.org/2001/XMLSchema
fun processValue(value) =
	if ((typeOf(value) as String) == 'Array') processList(value) else if ((typeOf(value) as String) == 'Object') processObject(value) else value
fun processObject(object) =
	if (object.fieldName?)
	    {
	        ns1#'$(object.fieldName)' : {
				ns3#Action: object.action,
				(ns3#CustomProperties: {(object.customProperties map ((field) -> {
					ns4#KeyValueOfstringanyType: {
						ns4#Key : field.key,
						ns4#Value @(ns2#'type' : 'ns5:' ++ field.valueType, 'xmlns:ns5' : '$(ns5 as String)'): field.value
					}
				}))}) if (object.customProperties != null),
				(ns3#EntityKey: object.entityKey) if (object.entityKey != null),
				((object.fields pluck ($$) default []) map ((field) -> {
					ns1#'$(field)' : processValue(object.fields[field])
				}))
	        }
	    }
	else 
	    object mapObject ((value, key) -> {
	        ns1#'$(key)' : processValue(value)
	    })
fun processList(list) =
	if ((typeOf(list[0]) as String) == 'Object')
		{(list map ((record) -> 
			processValue(record)
		))}
	else 
		list map ((record) ->
	        processValue(record)
	    )
---
{
	ns0#Save: {
		ns0#regionContext @(ns2#'type': 'ns1:SingleRegionContext', 'xmlns:ns1' : '$(ns1 as String)'): {
			ns1#BusinessUnitEntityKey: vars.businessUnit,
			ns1#RegionEntityKey: vars.region
		},
		ns0#objects: {
			ns1#AggregateRootEntity @(ns2#'type': 'ns1:' ++ vars.saveType): {
				ns3#Action: vars.action,
				(ns3#CustomProperties: {(vars.configuration.customProperties map ((field) -> {
					ns4#KeyValueOfstringanyType: {
						ns4#Key : field.key,
						ns4#Value @(ns2#'type' : 'ns5:' ++ field.valueType, 'xmlns:ns5' : '$(ns5 as String)'): field.value
					}
				}))}) if (vars.configuration.customProperties != null),
				(ns3#EntityKey: vars.entityKey) if (vars.entityKey != null),
				ns1#BusinessUnitEntityKey: vars.businessUnit,
				ns1#RegionEntityKeys: {
					ns4#long: vars.region
				},
				((vars.configuration.fields pluck ($$)) map ((field) -> {
					ns1#'$(field)' : processValue(vars.configuration.fields[field])
				}))
  			}
		},
		ns0#options: {
			ns1#IgnoreEntityVersion: true,
			ns1#InclusionMode: if (vars.configuration.options != null) 'AccordingToPropertyOptions' else 'All',
			(ns1#PropertyOptions @(ns2#'type': 'ns1:' ++ vars.configuration.options.optionType): {
				(ns3#CustomProperties: vars.configuration.options.customProperties) if (vars.configuration.options.customProperties != null),
				(vars.configuration.options.fields map ((field) ->
		        		ns1#'$(field)' : true
		        ))
			}) if (vars.configuration.options != null)
		}
	}
}