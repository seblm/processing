function setup() {
    createCanvas(400, 400);
    noLoop();
    let checkedTables = [...Array(10).keys()].map(table => table + 1);
    for (let i = 1; i < random(5, 10); i++) {
        checkedTables.splice(random(0, checkedTables.length), 1);
    }
    for (let i = 1; i <= 10; i++) {
        createCheckbox(`x ${i}`, checkedTables.includes(i));
    }
}

const colors = ['#fac', '#fbc', '#fcc', '#fdc', '#fec', '#ffc', '#caf', '#cdf', '#cff', '#cdd', '#cfd', '#cfc'];
const orders = ['first', 'second'];

let number = null;
let table = null;
let order = null;
let color = null;
let newOperation = true;

function draw() {
    textSize(32);
    newOperation = !newOperation;

    if (newOperation) {
        const current = number;
        do {
            number = int(random(11));
        } while (number === current);
        table = random(selectAll('input[type=checkbox]').flatMap((checkbox, index) => checkbox.checked() ? [index + 1] : []));
        order = random(orders);
        background(random(colors));
    }

    let operation;
    if (order === 'first') {
        if (newOperation) {
            operation = `${number} x ${table} = `;
        } else {
            operation = `${number} x ${table} = ${number * table}`;
        }
    } else {
        if (newOperation) {
            operation = `${table} x ${number} = `;
        } else {
            operation = `${table} x ${number} = ${number * table}`;
        }
    }
    text(operation, 120, 200);
}

function keyReleased() {
    redraw();
}

function mouseReleased(mouseEvent) {
    if (mouseEvent.target.tagName === 'CANVAS') {
        redraw();
    }
}
