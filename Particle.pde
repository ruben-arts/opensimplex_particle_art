// How many pixels around the edges of the screen will the drawing start/continue
int BORDER = 40;

class Particle {
  float maxRadius;
  float currentRadius;
  float noiseScaleX;
  float noiseScaleY;

  PVector dir = new PVector(0.0, 0.0);
  PVector vel = new PVector(0.0, 0.0);
  PVector pos = new PVector(0.0, 0.0);
  
  // With some tweaking 0.1 was good for drawing as fast as possible without getting dotted lines.
  float speed = 0.1;
  
  OpenSimplexNoise noise;
  
  Particle(float maxRadius, float noiseScaleX, float noiseScaleY) {
    this.maxRadius = maxRadius;
    this.noiseScaleX = noiseScaleX;
    this.noiseScaleY = noiseScaleY;
    genPose();
    
    noise = new OpenSimplexNoise();
  }

  void genPose() {
    pos.x = random(-BORDER, width+BORDER);
    pos.y = random(-BORDER, height+BORDER);
    currentRadius = 0.1;
  }

  boolean atBorder() {
    if (pos.x > width + BORDER || pos.x < -BORDER || pos.y > height + BORDER || pos.y < -BORDER) {
      return true;
    }
    return false;
  }
  void move(boolean regen) {
    if (regen && atBorder()) {
      genPose();
      return;
    }

    // Calculate angle with noise.
    float noiseValue = (float) noise.eval((pos.x/float(width)) * noiseScaleX, (pos.y/float(height)) * noiseScaleY);
    float angle = noiseValue * TWO_PI;

    // Use angle to calculate new pos.
    dir.x = cos(angle);
    dir.y = sin(angle);
    vel = this.dir.copy();
    vel.mult(this.speed * currentRadius);
    pos.add(this.vel);

    // Bump radius
    currentRadius = min(currentRadius+0.08, maxRadius);
  }
  
  void updateNoiseScale(float x, float y){
    noiseScaleX = x;
    noiseScaleY = y;
  }
  void display() {
    ellipse(pos.x, pos.y, currentRadius, currentRadius);
  }
}
