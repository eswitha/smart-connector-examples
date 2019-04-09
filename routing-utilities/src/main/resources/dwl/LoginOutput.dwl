%dw 2.0
output application/java
---
{
	queryURL: payload.body.LoginResponse.LoginResult.QueryServiceUrl,
	sessionGuid: payload.body.LoginResponse.LoginResult.UserSession.Guid
}