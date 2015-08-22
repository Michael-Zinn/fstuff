Promise = require 'bluebird'
HashMap = require 'hashmap'

###
sequence :: (Traversable t, Monad m) => t (m a) -> m (t a)

Turns a HashMap from the 'hashmap' module that contains promises
from the 'bluebird' module into a promise of the hashmap.

Basically like "Promise.all", but for hashmaps instead of lists.
###
exports.sequence = (hashMapOfPromises) ->
	finishedHashmap = new HashMap()
	allPromises = []
	hashMapOfPromises.forEach (value, key) ->
		allPromises.push(value.then( (hash) ->
			finishedHashmap.set key, hash
			))
	Promise.all(allPromises).then ->
		finishedHashmap
