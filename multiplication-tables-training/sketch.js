function setup() {
    createCanvas(400, 400);
    noLoop();
}

const colors = ['#fac', '#fbc', '#fcc', '#fdc', '#fec', '#ffc', '#caf', '#cdf', '#cff', '#cdd', '#cfd', '#cfc'];
const orders = ['first', 'second'];

let number = null;
let order = null;
let color = null;
let state = -1;

function draw() {
    textSize(32);
    state++;

    if (state % 2 === 0)  {
        const current = number;
        do {
            number = int(random(11));
        } while (number === current);
        order = random(orders);
        background(random(colors));
    }

    if (order === 'first') {
        if (state % 2 === 0) {
            text(`${number} x 3 = `, 120, 200);
        } else {
            text(`${number} x 3 = ${number * 3}`, 120, 200);
        }
    } else {
        if (state % 2 === 0) {
            text(`3 x ${number} = `, 120, 200);
        } else {
            text(`3 x ${number} = ${number * 3}`, 120, 200);
        }
    }
}

function keyReleased() {
    redraw();
}

function mouseReleased() {
    redraw();
}
