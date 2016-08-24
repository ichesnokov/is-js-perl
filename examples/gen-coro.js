function* task() {
  let counter = 1;
  yield counter++;
  yield counter++;
  yield counter++;
}

var iterator = task();

let res = iterator.next();
while (!res.done) {
    console.log(res.value);
    res = iterator.next();
}
