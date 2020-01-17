using Toybox.Math;
using Toybox.System;

function abs(number) {
    if (number < 0) { return -1 * number; } else { return number; }
}

function max(number1, number2) {
    if (number1 > number2) { return number1; } else { return number2; }
}

function min(number1, number2) {
    if (number1 < number2) { return number1; } else { return number2; }
}

function toInteger(input) {
    return Math.round(input).toNumber();
}

function randomNumber(size) {
    return Math.rand() % size;
}

function shuffleArray(array) {
    var shuffled = [];
    var index, item;
    var count = array.size();
    Math.srand(System.getTimer());

    for (var i=0; i<count; i++) {
        index = randomNumber(count);
        item = array[index];
        array.remove(item);
        shuffled.add(item);
    }

    return shuffled;
}
