# Functional Stuff for JavaScript

## Installation

Using npm:

	$ npm install fstuff

## Description

Ad hoc solutions for very specific problems related to functional programming in JavaScript and CoffeeScript with Bluebird, Ramda and miscellaneous other things.

## Features
- `sequence(h:HashMap<x,Promise<y>>) : Promise<HashMap<x,y>>` Turns a HashMap of promises into a promise of a HashMap. This is meant for HashMaps from the ['hashmap' module](https://www.npmjs.com/package/hashmap). If you use regular objects as maps you can just use [bluebird's .props() function](https://github.com/petkaantonov/bluebird/blob/master/API.md#props---promise) instead.
- `do -> [statements]` do-notation for bluebird, best used in CoffeeScript. See examples for details.

## Examples

### sequence

Imagine you read a large text file as a stream and each line contains a path to a file of which you want to count the words. If you do this with bluebird promises and construct a HashMap of paths to word counts you will end up with a HashMap of promises which you can sequence:

```coffeescript
F = require 'fstuff'

getThings = new Promise (resolve, reject) ->
	unresolvedWordCounts = new HashMap()
	...
	steam.on 'line', (path) ->
		...
		unresolvedWordCounts.set path, getPromiseOfWordCount(path)

	stream.on 'end', ->
		F.sequence(unresolvedWordCounts).then (wordCounts) ->
			...
			things = doSomethingWith(wordCounts)
			...
			resolve things
```

### do-notation

In CoffeeScript, you don't have to use commas in lists if you put each list entry on a separate line. Assuming that the above code returns a promise of a list of things and F is 'fstuff' and _ is 'ramda' then you could do this:

```coffeescript
F.do -> [
	getThings()
	_.map ThingUtils.prettyPrint
	_.join '\n\n'
	console.log
]
```

...which would be equivalent to this bluebird code:

```coffeescript
getThings()
.then _.map ThingUtils.prettyPrint
.then _.join '\n\n'
.then console.log
```

...so the point of this is not having to type ".then" in front of every line except the first one.

## Developer Hint

The git repository only contains the source code while the module on npmjs.com only contains the compiled JavaScript. If you want to modify fstuff you shoudl do this:

1. Get the source code from https://github.com/RedNifre/fstuff (Don't edit the raw JavaScript...)
2. Install `broccoli-timepiece` globally.
3. Run `broc.sh`. This starts broccoli-timepiece which monitors the source directory so any changes will be compiled instantly. The script is just one line so if you are on Windows you can just copy the line and run it directly instead.
