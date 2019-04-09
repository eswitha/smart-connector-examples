%dw 2.0
output application/json
---
{
	returnType: vars.objectType,
	expression: {
		fieldName: vars.keyType,
		valueType: vars.valueType,
		value: vars.value
	}
}