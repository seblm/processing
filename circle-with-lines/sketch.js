function setup() {
    createCanvas(400, 400);
    noLoop();
}

function draw() {
    let x = 200;
    let y = 200;
    for (let i = 0; i < 10; i++) {
        line(200, y - 200 + i * 20, x +       i * 20, 200);
    }
    for (let i = 0; i < 10; i++) {
        line(200, y       + i * 20, x + 200 - i * 20, 200);
    }
    for (let i = 0; i < 10; i++) {
        line(200, y + 200 - i * 20, x -       i * 20, 200);
    }
    for (let i = 0; i < 10; i++) {
        line(200, y       - i * 20, x - 200 + i * 20, 200);
    }
}
