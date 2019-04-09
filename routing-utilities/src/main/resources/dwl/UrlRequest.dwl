%dw 2.0
output application/xml
ns ns0 http://roadnet.com/apex/
ns ns1 http://roadnet.com/apex/DataContracts/
ns ns2 http://www.w3.org/2001/XMLSchema-instance
---
{
	ns0#RetrieveUrlsForContext: {
		ns0#context @(ns2#'type': 'ns1:SingleRegionContext', 'xmlns:ns1' : '$(ns1 as String)'): {
			ns1#BusinessUnitEntityKey: vars.businessUnit,
			ns1#RegionEntityKey: vars.region
		}
	}
}