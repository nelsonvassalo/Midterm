// CODE MIDTERM
// Rotoscoping
//
// This sketch loads the assigned frames and plays them back
// Add your own draw code
// Then it saves out the rendered frames
//
// DON'T FORGET TO CHANGE THE VALUE OF THE STUDENTNAME VARIABLE TO YOUR NAME!!

import java.io.File;

File[] tempfiles;
ArrayList<File> files;
PImage image;
String currentFilename;
int xspacing = 16;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

int i = 0;
float angle = 0.0;  
float waveH = 75.0; 
float distWave = 500.0;  
float dx;
float[] waveY;  // Using an array to store height values for the wave
int r,b;
color c = color(r, 255, b);



// EDIT THIS LINE WITH YOUR NAME!
String studentName = "Nelson";

void setup() {
  files = new ArrayList<File>();
  w = width+16;
  dx = (TWO_PI / distWave) * xspacing;
  waveY = new float[w/xspacing];
  r = 0;
  b = 255;

  // get list of files from directory
  File dir = new File(sketchPath() + "/rawFrames");
  tempfiles = dir.listFiles();

  // filter out files that don't end in .png
  for (int i = 0; i < tempfiles.length; i++) {
    String path = tempfiles[i].getAbsolutePath();
    if (path.toLowerCase().endsWith(".png")) {
      files.add(tempfiles[i]);
    }
  }

  // Resize the canvas to full-HD 1080p glory
  size(1920, 1080);
  pixelDensity(1);
  
  // if that doesn't work, comment it out and uncomment this instead:
  //size(1920, 1080);
  //pixelDensity(1);
}

void draw() {
  // DO NOT ALTER THE LINE BELOW
  prepare();


  
  renderCircle();
  calcWave();
  renderWave();
  // STOP ADDING YOUR CODE HERE -----

  // DO NOT ALTER THE LINES BELOW
   if (frameCount <= files.size()) { 
    export();
  } 
  if (frameCount == files.size()) {
    exit();
  }
}

void renderCircle() {

  if (frameCount >3) {
    r+= 25;
    b-= 25;
    noFill();
    stroke(r, 0, b, 255);
    strokeWeight((frameCount-4)*16);
    ellipse(width/2 + 39, height/2+10, frameCount*112, frameCount*112);
  }
}
void calcWave() {
  angle += 2;
  float x = angle;
  for (int i = 0; i < waveY.length; i++) {
    waveY[i] = sin(x)*waveH*mouseY/100;
    x+=dx;
  }
}

void renderWave() {
  if (frameCount <=5) {
    noStroke();
    fill(r,0,b);
    for (int x = 0; x < waveY.length; x++) {
      ellipse(x*xspacing, height/2+waveY[x], mouseX/10, mouseY/10);
    }
}
}

// DO NOT ALTER THIS FUNCTION!!
void prepare() {
  String path = files.get(frameCount-1).getAbsolutePath();
  currentFilename = files.get(frameCount-1).getName();

  // Load current file into our PImage variable
  tint(255, 255);
  image = loadImage(path);
  image(image, 0, 0, width, height);
}

// DO NOT ALTER THIS FUNCTION!!
void export() {
  // saves frame without watermark
  saveFrame(sketchPath() + "/outFrames/edited_" + currentFilename);

  int sidePadding = 125;
  int bottomPadding = 50;
  
  textAlign(LEFT);
  textSize(32);
  fill(255);
  text(studentName, sidePadding + 1, height - bottomPadding + 1);
  fill(0);
  text(studentName, sidePadding, height - bottomPadding);

  // saves frame with watermark
  saveFrame(sketchPath() + "/outFrames/watermarked_" + currentFilename);
}