int NUM_PARTICLE_COLORS = 3;
int NUM_PARTICLES_PER_COLOR = 1000;

Particle[][] particleArray = new Particle[NUM_PARTICLE_COLORS][NUM_PARTICLES_PER_COLOR];

ColorScheme cs;

// Noise
float noiseScaleX;
float noiseScaleY;
boolean regenParticle = true;

// Hardcoded colors
color[] colorList = new color[NUM_PARTICLE_COLORS];

  
//OpenSimplexNoise noise;
void setup() {
  noStroke();
  smooth();
  size(3840, 2160);

  //// UNCOMMENT TO USE A GRADIENT BETWEEN c1 and c2
  //// ColorScheme
  //color c1 = color(66, 4, 126);
  //color c2 = color(7, 244, 158);
  //cs = new ColorScheme(NUM_PARTICLE_COLORS, c1, c2);
  //background(cs.getBackground());
  
  // Comment when using ColorScheme:
  background(250);
  colorList[0] = color(255);
  colorList[1] = color(66,4,126);
  colorList[2] = color(#2B52F6);
  
  // Noise
  noiseScaleX = 4.0;
  noiseScaleY = noiseScaleX;

  for (int c = 0; c < NUM_PARTICLE_COLORS; c++) {
    for (int i = 0; i < NUM_PARTICLES_PER_COLOR; i++) {
      float mRad = random(60, 100);
      particleArray[c][i] = new Particle(mRad, noiseScaleX, noiseScaleY);
    }
  }
}

void draw() {
  // Draw all particles
  for (int c = 0; c < NUM_PARTICLE_COLORS; c++) {
    // When using the ColorScheme object uncomment:
    //fill(cs.at(c), 100);
    fill(colorList[c], 100);
    for (int i = 0; i < NUM_PARTICLES_PER_COLOR; i++) {
      particleArray[c][i].move(regenParticle);
      particleArray[c][i].display();
    }
  }
}

void updateNoise(float diff) {
  // Updates noise scale with certain diff. 
  noiseScaleX += diff;
  
  // Update all particles (implemented per particle to beable to have noise diffrences per particle.
  for (int c = 0; c < NUM_PARTICLE_COLORS; c++) {
    for (int i = 0; i < NUM_PARTICLES_PER_COLOR; i++) {
      particleArray[c][i].updateNoiseScale(particleArray[c][i].noiseScaleX+diff, particleArray[c][i].noiseScaleY+diff);
    }
  }
}
void keyPressed() {
  if (keyCode == UP) {
    updateNoise(0.1);
  }
  if (keyCode == DOWN) {
    updateNoise(-0.1);
  }
  if (key == 'x') {
    // Turn off particle generation after they reached a border. 
    regenParticle = !regenParticle;
  }
  if (key == 'c'){
    background(250);
  }
  if (key == 's') {
    // Saves to sketchbook workspace
    saveFrame("frames/####.png");
  }
}
