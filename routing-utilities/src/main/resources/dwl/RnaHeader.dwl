%dw 2.0
output application/xml
ns ns1 http://roadnet.com/apex/DataContracts/
---
headers: 
{
	ns1#SessionHeader: {
		ns1#SessionGuid: vars.sessionGuid
	}
}