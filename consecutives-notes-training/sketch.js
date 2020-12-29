function setup() {
    createCanvas(400, 400);
    noLoop();
}

const notes = ['Do', 'Ré', 'Mi', 'Fa', 'Sol', 'La', 'Si'];

let note = null;
let state = -1;

function draw() {
    background(256);
    textSize(32);
    state++;
    if (state % 3 === 0)  {
        const current = note;
        do {
            note = random(notes)
        } while (note === current);
    }
    const index = notes.indexOf(note);
    text(note, 200, 200);
    if (state % 3 > 0) {
        text('→ ' + notes[(index + 1) % 7], 250, 200);
    }
    if (state % 3 > 1) {
        text(notes[(index + 6) % 7] + ' ←', 120, 200);
    }
}

function keyReleased() {
    redraw();
}

function mouseReleased() {
    redraw();
}
