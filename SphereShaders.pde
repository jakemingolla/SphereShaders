/*
  Introduction to geometry shaders.
 
 Jake Mingolla
 December, 2015
 
 Built using GLGraphics version 1.0 and Procession version 1.5.1
 */

import codeanticode.glgraphics.*;
import controlP5.*;
import processing.opengl.PGraphicsOpenGL;

GLModel[] spheres;
GLSLShader shader;

ControlP5 cp5;

int numSpheres = 1;

float time;
float currentTime;
float TIME_FACTOR = 0.01;
float MAX_EXPLODE = 100;
int MAX_DETAIL = 500;
int MAX_RADIUS = 300;

float xInterval;
float yInterval;
float zInterval;

float xNoise;
float yNoise;
float zNoise;

float spacing;
float currentExplode;
float explode;
boolean explodeIncreasing = true;
float velocity;

int detail;
int currentDetail = -1;
int radius;
int currentRadius = -1;

float red;
float green;
float blue;

boolean pointLight;

GLModel obj;

void setup() {
  size(1200, 700, GLConstants.GLGRAPHICS);

  setupControlP5();

  shader = new GLSLShader(this, "basic-vertex.vert", "sphere-wave.geom", "basic-lighting.frag");

  shader.setupGeometryShader(TRIANGLES, TRIANGLES, 3);
}

void setupControlP5() {
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  int h = 15;

  cp5.addSlider("xInterval")
    .setPosition(15, h)
      .setRange(EPSILON, 100)
        .setNumberOfTickMarks(500)
          .setValue(15.0);

  h += 15;
  cp5.addSlider("yInterval")
    .setPosition(15, h)
      .setRange(EPSILON, 100)
        .setNumberOfTickMarks(500)
          .setValue(50.0);

  h += 15;
  cp5.addSlider("zInterval")
    .setPosition(15, h)
      .setRange(EPSILON, 100)
        .setNumberOfTickMarks(500)
          .setValue(10.0);

  h += 15;
  cp5.addSlider("xNoise")
    .setPosition(15, h)
      .setRange(EPSILON, 100)
        .setNumberOfTickMarks(500)
          .setValue(30.0);

  h += 15;
  cp5.addSlider("yNoise")
    .setPosition(15, h)
      .setRange(EPSILON, 100)
        .setNumberOfTickMarks(500)
          .setValue(100.0);

  h += 15;
  cp5.addSlider("zNoise")
    .setPosition(15, h)
      .setRange(EPSILON, 100)
        .setNumberOfTickMarks(500)
          .setValue(5.0);

  h += 15;
  cp5.addSlider("spacing")
    .setPosition(15, h)
      .setRange(EPSILON, 100)
        .setNumberOfTickMarks(500)
          .setValue(20.0);

  h += 15;
  cp5.addSlider("red")
    .setPosition(15, h)
      .setRange(0, 255)
        .setNumberOfTickMarks(500)
          .setValue(100);

  h += 15;
  cp5.addSlider("green")
    .setPosition(15, h)
      .setRange(0, 255)
        .setNumberOfTickMarks(500)
          .setValue(100);

  h += 15;
  cp5.addSlider("blue")
    .setPosition(15, h)
      .setRange(0, 255)
        .setNumberOfTickMarks(500)
          .setValue(100);

  h += 15;
  Toggle t1 = cp5.addToggle("explode")
    .setValue(0)
      .setPosition(15, h)
        .setSize(100, 10);
  Label l1 = t1.captionLabel();
  l1.style().marginTop = -14; // move upwards
  l1.style().marginLeft = 103; // move to the right;

  h += 15;
  cp5.addSlider("velocity")
    .setPosition(15, h)
      .setRange(EPSILON, 1)
        .setNumberOfTickMarks(500)
          .setValue(0.5);

  h += 15;
  Toggle t2 = cp5.addToggle("pointLight")
    .setValue(0)
      .setPosition(15, h)
        .setSize(100, 10);
  Label l2 = t2.captionLabel();
  l2.style().marginTop = -14; // move upwards
  l2.style().marginLeft = 103; // move to the right;

  h += 15;
  cp5.addSlider("time")
    .setPosition(15, h)
      .setRange(EPSILON, 10)
        .setNumberOfTickMarks(500)
          .setValue(0.5);

  h += 15;
  cp5.addSlider("detail")
    .setPosition(15, h)
      .setRange(10, MAX_DETAIL)
        .setValue(100);

  h += 15;
  cp5.addSlider("radius")
    .setPosition(15, h)
      .setRange(100, MAX_RADIUS)
        .setValue(200);

  cp5.addTextlabel("label")
    .setText("JAKE MINGOLLA 2015")
      .setPosition(15, height - 15)
        .setColorValue(color(255, 255, 255));
}

void draw() {
  background(0);
  calculateSphere();
  fill(255, 255, 255);
  text("FPS: " + frameRate, 19, height - 20);
  GLGraphics renderer = (GLGraphics)g;
  renderer.beginGL();
  shader.start();

  setTime();

  setInterval();
  setNoise();
  setSphereInformation();

  noLights();
  translate(width/2, height/2, 0);
  obj.setTint(red, green, blue);
  renderer.model(obj);

  shader.stop();
  renderer.endGL();

  cp5.draw();
  handlePointlight();
}

void calculateSphere() {
  if (currentDetail != round(detail) || currentRadius != round(radius)) {
    currentDetail = round(detail);
    currentRadius = round(radius);
    if (obj != null) {
      obj.delete();
    }
    obj = createSphere(detail, radius);
  }
}

void handlePointlight() {
  if (pointLight) {
    pointLight(255, 255, 255, mouseX, mouseY, 400);
  } 
  else {
    noLights();
    pointLight(255, 255, 255, width/2, height/2, 1000);
  }
}

void setNoise() {
  shader.setFloatUniform("xNoise", xNoise);
  shader.setFloatUniform("yNoise", yNoise);
  shader.setFloatUniform("zNoise", zNoise);
}

void setInterval() {
  shader.setFloatUniform("xInterval", xInterval);
  shader.setFloatUniform("yInterval", yInterval);
  shader.setFloatUniform("zInterval", zInterval);
}

void setSphereInformation() {
  shader.setFloatUniform("Spacing", spacing);
  if (explode > EPSILON || currentExplode > EPSILON) {
    if (currentExplode > MAX_EXPLODE || explode < EPSILON) {
      explodeIncreasing = false;
    } 
    else if (currentExplode < EPSILON) {
      explodeIncreasing = true;
    }
    if (explodeIncreasing) {
      currentExplode += velocity;
    } 
    else {
      currentExplode -= velocity;
    }

    shader.setFloatUniform("Explode", currentExplode);
  } 
  else {
    shader.setFloatUniform("Explode", 0.0);
    currentExplode = 0.0;
    explodeIncreasing = true;
  }
}

void setTime() {
  currentTime = millis() * time * TIME_FACTOR;

  shader.setFloatUniform("Time", currentTime);
}

