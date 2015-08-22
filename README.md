# fstuff
Random stuff for functional programming in JavaScript/CoffeeScript.

## sequence(HashMap<A,Promise<B>) -> Promise<HashMap<A,B>>
For HashMaps from 'hashmap' and promises from 'bluebird':

sequence :: (HashMap h, Promise p) => h (p a) -> p (h a)

Turns a hashmap of promises into a promise of a hashmap.
