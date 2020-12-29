let images = [];

let tiles = [];

function preload() {
    images.push(
        loadImage("assets/peppa-pig.jpg"),
        loadImage("assets/star-wars-rebels.jpg"),
        loadImage("assets/winnie-the-pooh.jpg")
    );
    for (let i = 0; i < 9; i++) {
        tiles.push(random([0, 1, 2]))
    }
}

function setup() {
    createCanvas(640, 480);
    noLoop();
}

function mousePressed() {
    draw();
}

function draw() {
    let x = floor(mouseX / width * 3);
    let y = floor(mouseY / height * 3);

    let index = x + y * 3;

    tiles[index] += 1;

    if (tiles[index] === 3) {
        tiles[index] = 0;
    }

    let w = width / 3;
    let h = height / 3;

    image(images[tiles[0]], 0    , 0    , w, h, 0                             ,                       0        , images[tiles[0]].width / 3, images[tiles[0]].height / 3);
    image(images[tiles[1]], w    , 0    , w, h, images[tiles[1]].width / 3    ,                       0        , images[tiles[1]].width / 3, images[tiles[1]].height / 3);
    image(images[tiles[2]], w * 2, 0    , w, h, images[tiles[2]].width / 3 * 2,                       0        , images[tiles[2]].width / 3, images[tiles[2]].height / 3);
    image(images[tiles[3]], 0    , h    , w, h, 0                             , images[tiles[3]].height / 3    , images[tiles[3]].width / 3, images[tiles[3]].height / 3);
    image(images[tiles[4]], w    , h    , w, h, images[tiles[4]].width / 3    , images[tiles[4]].height / 3    , images[tiles[4]].width / 3, images[tiles[4]].height / 3);
    image(images[tiles[5]], w * 2, h    , w, h, images[tiles[5]].width / 3 * 2, images[tiles[5]].height / 3    , images[tiles[5]].width / 3, images[tiles[5]].height / 3);
    image(images[tiles[6]], 0    , h * 2, w, h, 0                             , images[tiles[6]].height / 3 * 2, images[tiles[6]].width / 3, images[tiles[6]].height / 3);
    image(images[tiles[7]], w    , h * 2, w, h, images[tiles[7]].width / 3    , images[tiles[7]].height / 3 * 2, images[tiles[7]].width / 3, images[tiles[7]].height / 3);
    image(images[tiles[8]], w * 2, h * 2, w, h, images[tiles[8]].width / 3 * 2, images[tiles[8]].height / 3 * 2, images[tiles[8]].width / 3, images[tiles[8]].height / 3);

    line(0        , 0        , w * 3 - 1, 0        );
    line(0        , h        , w * 3 - 1, h        );
    line(0        , h * 2    , w * 3 - 1, h * 2    );
    line(0        , h * 3 - 1, w * 3 - 1, h * 3 - 1);
    line(0        , 0        , 0        , h * 3 - 1);
    line(w        , 0        , w        , h * 3 - 1);
    line(w * 2    , 0        , w * 2    , h * 3 - 1);
    line(w * 3 - 1, 0        , w * 3 - 1, h * 3 - 1);
}
