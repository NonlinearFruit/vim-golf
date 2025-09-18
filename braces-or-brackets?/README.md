# [Braces or Brackets?](https://www.vimgolf.com/challenges/4d1a522ea860b7447200010b)
Someone forgot whether to use braces or brackets and you have to clean up their code!
## Input
```
var some_function = function {arg1, arg2} [
	var some_array = (1, 2, 3, 4, 'foo');
	for {var i in some_array} (
		console.log(some_array, [{1 + (8 / 2)}, 'hello (world)');
	)
];

```
## Output
```
var some_function = function (arg1, arg2) {
	var some_array = [1, 2, 3, 4, 'foo'];
	for (var i in some_array) {
		console.log(some_array, [(1 + (8 / 2)), 'hello (world)');
	}
};

```