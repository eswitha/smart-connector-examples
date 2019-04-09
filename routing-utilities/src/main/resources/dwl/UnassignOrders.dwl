%dw 2.0
output application/xml
ns ns0 http://roadnet.com/apex/
ns ns1 http://roadnet.com/apex/DataContracts/
ns ns2 http://www.w3.org/2001/XMLSchema-instance
ns ns3 http://schemas.datacontract.org/2004/07/Roadnet.Apex.Server.Services.Routing.DataContracts
ns ns4 http://schemas.microsoft.com/2003/10/Serialization/Arrays
ns ns5 http://www.w3.org/2001/XMLSchema
---
{		
	ns0#UnassignOrders: {
		ns0#context @(ns2#'type': 'ns1:SingleRegionContext', 'xmlns:ns1' : '$(ns1 as String)'): {
			ns1#BusinessUnitEntityKey: vars.businessUnit,
			ns1#RegionEntityKey: vars.region
		},
		ns0#orderEntityKeys: {
			ns1#DomainInstance: {
				ns1#EntityKey: vars.entityKey,
				ns1#Version: vars.version
				}
			},
		ns0#removeOrderOptions: {
			ns3#AddToUnassigneds: true,
			ns3#DeliveryQuantitiesOnVehicle: false
			}
	}
}