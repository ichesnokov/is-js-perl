"use strict";

let str = "a1b2c3";
let re = /[a-z]\d+/y;
let matched;
while (matched = re.exec(str)) {
    console.log(matched[0]);
}
