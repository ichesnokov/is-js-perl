'use strict';

function msgAfterTimeout (msg, who, timeout) {
    return new Promise(
        (resolve, reject) => {
            setTimeout(() => resolve(`${msg} Hello ${who}!`), timeout)
        }
    )
}
msgAfterTimeout("", "Foo", 500).then(
    (msg) =>
        msgAfterTimeout(msg, "Bar", 1000)
).then(
    (msg) => {
        console.log(`Done after 1500ms:${msg}`)
    }
)
