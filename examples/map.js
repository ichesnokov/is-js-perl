"use strict";

let isMarked     = new WeakSet()
let attachedData = new WeakMap()

class Node {
    constructor (id)   { this.id = id                  }
    mark        ()     { isMarked.add(this)            }
    unmark      ()     { isMarked.delete(this)         }
    marked      ()     { return isMarked.has(this)     }
    set data    (data) { attachedData.set(this, data)  }
    get data    ()     { return attachedData.get(this) }
}

let foo = new Node("foo")

// add to isMarked set
foo.mark()
// add to attachedData map
foo.data = "bar"

console.log(`isMarked.has(foo): ${isMarked.has(foo)}`);
console.log(`attachedData.has(foo): ${attachedData.has(foo)}`);

console.log('...deleting foo...');
foo = null  /* remove only reference to foo */

console.log(`isMarked.has(foo): ${isMarked.has(foo)}`);
console.log(`attachedData.has(foo): ${attachedData.has(foo)}`);
