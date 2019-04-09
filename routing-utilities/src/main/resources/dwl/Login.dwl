%dw 2.0
output application/xml
ns ns0 http://roadnet.com/apex/
ns ns1 http://schemas.datacontract.org/2004/07/Roadnet.Apex.Server.Services.Login
---
{
	ns0#Login: {
		ns0#emailAddress: vars.userName,
		ns0#password: vars.password,
		ns0#appInfo: {
			ns1#ClientApplicationIdentifier: vars.clientId
		}
	}
}