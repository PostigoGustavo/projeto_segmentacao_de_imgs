PImage img;

void setup() {
  size(800, 600);
  img = loadImage("img1.png");
  
  img.resize(width, height);  
  
  // Aplica o filtro de suavização
  smoothFilter(img);
  
  // filtro para escurecer a imagem
  filterEscurecimento(img, 0.9);
    
  // Aplica o filtro para remover o fundo da imagem
  removeBackground(img);
  
  // Aplicar filtro de equalização adaptativa
  adaptiveThresholding(img);
   
  image(img, 0, 0);
}


void filterEscurecimento(PImage img, float fator_escurecimento) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);
    
    r *= fator_escurecimento;
    g *= fator_escurecimento; 
    b *= fator_escurecimento;
    
    img.pixels[i] = color(r, g, b);
  }
  img.updatePixels();
}


void removeBackground(PImage img) {
  
  img.loadPixels();
  
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);

    if ((g > r && g > b && g > 50) || 
        (g > r && r > b && g > 50 && r > 50)) { 
        
      img.pixels[i] = color(r, g, b);
      
    } else {
      
      img.pixels[i] = color(0);
    }
  }
  
  img.updatePixels();
}


void smoothFilter(PImage img) {
  
  img.loadPixels();
  
  color[] temp = new color[img.pixels.length];
  int cols = img.width;
  int rows = img.height;
  
  // Aplica o filtro de suavização
  for (int i = 1; i < cols - 1; i++) {
    for (int j = 1; j < rows - 1; j++) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      int count = 0;
      
      // Obtém os pixels ao redor do pixel atual
      for (int di = -1; di <= 1; di++) {
        for (int dj = -1; dj <= 1; dj++) {
          int x = i + di;
          int y = j + dj;
          
          // Calcula a média das cores dos pixels vizinhos
          int loc = x + y * cols;
          color c = img.pixels[loc];
          sumR += red(c);
          sumG += green(c);
          sumB += blue(c);
          count++;
        }
      }
      
      // Calcula a média das cores
      float avgR = sumR / count;
      float avgG = sumG / count;
      float avgB = sumB / count;
      
      // Define a nova cor do pixel
      temp[i + j * cols] = color(avgR, avgG, avgB);
    }
  }
  
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = temp[i];
  }
  
  img.updatePixels();
}


void adaptiveThresholding(PImage img) {
  img.loadPixels(); 
  
  // Calcular a média da intensidade dos pixels na vizinhança
  float sum = 0;
  int count = 0;
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int loc = x + y * img.width; 
      color pixel = img.pixels[loc];
      float intensity = (red(pixel) + green(pixel) + blue(pixel)) / 3.0; // Calcular a intensidade do pixel
      sum += intensity;
      count++;
    }
  }
  
  float avg = sum / count;
  
  // Definir o limiar global
  float threshold = avg;
  
  // Iterar sobre cada pixel da imagem e segmentar com o limiar global
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int loc = x + y * img.width; 
      color pixel = img.pixels[loc];
      float intensity = (red(pixel) + green(pixel) + blue(pixel)) / 3.0; 
      
      if (intensity > threshold) {
        img.pixels[loc] = color(255);
      } else {
        img.pixels[loc] = color(0); 
      }
    }
  }
  
  img.updatePixels(); 
}


void draw() {
  
  image(img, 0, 0);
  
  save("img1_ground_new.png");
}
