class ColorScheme {
  // The amount of slices the gradient is measured in, also the size of the output aray.
  int slices;

  // Colors in the gradient.
  color color1;
  color color2;

  // Background color can be overwriten to be seperate from gradient,
  // defaults to middle of the gradient.
  color backgroundColor;

  // Array of colors into wich the gradient is sliced, size is the slices value.
  color[] colorArray;

  ColorScheme(int slices, color color1, color color2) {
    this.slices = slices;
    this.color1 = color1;
    this.color2 = color2;
    
    backgroundColor = lerpColor(color1, color2, 0.5);
    
    colorArray = new color[slices];
    for (int c = 0; c < slices; c++) {
      float interval = map(c, 0.0, float(slices-1), 0.0, 1.0);
      colorArray[c] = lerpColor(color1, color2, interval);
    }
    println(colorArray);
  }
  
  color at(int index){
    return colorArray[index];
  }
  
  color getBackground(){
    return backgroundColor;
  }
}
