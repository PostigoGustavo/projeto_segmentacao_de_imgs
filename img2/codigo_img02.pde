PImage img;

void setup() {
  size(800, 600);
  img = loadImage("img2.png");
  
  img.resize(width, height);  // Redimensionar a imagem para o tamanho da tela
  
  // Aplica o filtro de suavização
  smoothFilter(img);
  
  // filtro para escurecer a imagem
  filterEscurecimento(img, 1.6);
  
  // Aplica o filtro de suavização
  smoothFilter(img);
    
  // Aplica o filtro para remover o fundo da imagem
  removeBackground(img);
  
  // remove esse filtro para a imagem img1_ground_new_2.png
  transformToWhite(img);
   
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
      
    } else if (r > 50 && r < 150 && g > 50 && g < 150 && b > 50 && b < 150) {
      
      img.pixels[i] = color(r,g,b);
      
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
  
  // Atualiza os pixels da imagem
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = temp[i];
  }
  
  img.updatePixels();
}


void transformToWhite(PImage inputImg) {
  inputImg.loadPixels();
   
  // Percorre todos os pixels da imagem
  for (int i = 0; i < inputImg.pixels.length; i++) {
    // Obtém a cor do pixel atual
    color pixelColor = inputImg.pixels[i];
    
    // Verifica se o pixel não é preto
    if (brightness(pixelColor) != 0) {
      // Define a cor do pixel como branco
      inputImg.pixels[i] = color(255);
    }
  }
  
  img.updatePixels();
}


void draw() {
  // Exibindo a imagem segmentada
  image(img, 0, 0);
  
  save("img1_ground.png");
}
