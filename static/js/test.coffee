a = [1..10]
b = (x*x for x in a)
console.log b

f = (a, b) ->
	a + b