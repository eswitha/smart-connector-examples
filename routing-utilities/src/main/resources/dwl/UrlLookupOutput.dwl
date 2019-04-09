%dw 2.0
output application/java
---
{
	mappingURL: vars.soapResponse.body.RetrieveUrlsForContextResponse.RetrieveUrlsForContextResult.MappingService,
	routingURL: vars.soapResponse.body.RetrieveUrlsForContextResponse.RetrieveUrlsForContextResult.RoutingService,
	queryURL: payload.queryURL,
	sessionGuid: payload.sessionGuid
}