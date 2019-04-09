%dw 2.0
output application/json
---
payload.Body.RetrieveResponse.RetrieveResult.Items.*DomainEntity map ((record) ->
	record mapObject ((value, key) -> {
		((key) : value ) if (value != null) 
}))