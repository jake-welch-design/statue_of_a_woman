import com.hamoid.*;
VideoExport videoExport;

PImage img;

color bg = 255;
color primary = 0;

int vidLength = 30;
int frames = 60;
int delay = 1;

void setup() {
  size(1080, 1920);
  frameRate(frames);

  videoExport = new VideoExport(this, "wave2.mp4");
  videoExport.setFrameRate(frames);
  videoExport.startMovie();
  videoExport.setQuality(100, 0);

  imageMode(CENTER);
  img = loadImage("statue_of_a_woman.png");
  img.resize(width, height);
}

void draw() {
  background(bg);
  noStroke();
  blendMode(DIFFERENCE);
  rectMode(CORNER);
  ellipseMode(CORNER);

  float tilesX = ceil(width / 8);
  float tilesY = ceil(height / 8);

  float tileW = ceil(width / tilesX);
  float tileH = ceil(height / tilesY);

for (int x = 0; x < tilesX; x++) {
  for (int y = 0; y < tilesY; y++) {

    int px = int(x * tileW);
    int py = int(y * tileH);

    color c = img.get(px, py);
    float b = brightness(c);

    if (b < 254) { 
      blendMode(DIFFERENCE);
      float frequency = 0.1;
      float speed = 0.4;
      float size = map(b, 0, 255, 0, tileW);
      float wave = map(sin((frameCount * speed + x + y) * frequency), -1, 1, 0, 20);

      fill(c);
      rect(px, py, size + wave, size + wave);
    } else {
      blendMode(BLEND); 
      fill(255); 
      rect(px, py, tileW, tileH); 
    }
  }
}

  if (frameCount > delay) {
    videoExport.saveFrame();
  }
  if (frameCount >= (frames * vidLength) + delay) {
    exit();
  }
}
