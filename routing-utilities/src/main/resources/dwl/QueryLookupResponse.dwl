%dw 2.0
output application/java
---
{
	mappingURL: payload.body.RetrieveUrlsForContextResponse.RetrieveUrlsForContextResult.MappingService,
	routingURL: payload.body.RetrieveUrlsForContextResponse.RetrieveUrlsForContextResult.RoutingService,
	queryURL: vars.queryUrl,
	sessionGuid: vars.sessionGuid
}