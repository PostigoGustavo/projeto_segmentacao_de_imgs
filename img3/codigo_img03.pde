PImage img;

void setup() {
  
  size(800, 600);
  
  img = loadImage("img3.png");
  
  img.resize(width, height);  // Redimensionar a imagem para o tamanho da tela
  
  // Aplica o filtro de suavização
  smoothFilter(img);
  
  // filtro para escurecer a imagem
  filterEscurecimento(img, 0.9);
  
  // Aplica o filtro de suavização
  smoothFilter(img);
    
  // Aplica o filtro para remover o fundo da imagem
  removeBackground(img);
  
  noiseReductionFilter(img);
   
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
        (r > g && r > b && g > b && r > 70 && r < 120 && g > 70 && g < 100 && b < 50 ) ||
        (g > r && r > b && g > 50 && r > 50)) {
        
      img.pixels[i] = color(255);
      //img.pixels[i] = color(r, g, b);
      
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


void noiseReductionFilter(PImage img) {
  img.loadPixels();
  color[] temp = new color[img.pixels.length];
  int cols = img.width;
  int rows = img.height;
  
  // Aplica o filtro de redução de ruído
  for (int i = 1; i < cols - 1; i++) {
    for (int j = 1; j < rows - 1; j++) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      float totalWeight = 0; // Total dos pesos dos pixels vizinhos
      
      // Obtém os pixels ao redor do pixel atual e aplica uma ponderação
      for (int di = -1; di <= 1; di++) {
        for (int dj = -1; dj <= 1; dj++) {
          int x = i + di;
          int y = j + dj;
          
          // Calcula a distância do pixel central
          float distance = dist(0, 0, di, dj);
          float weight = 1.0 / (distance + 1); // Quanto mais próximo, maior o peso
          
          int loc = x + y * cols;
          color c = img.pixels[loc];
          sumR += red(c) * weight;
          sumG += green(c) * weight;
          sumB += blue(c) * weight;
          totalWeight += weight;
        }
      }
      
      // Calcula a média ponderada das cores
      float avgR = sumR / totalWeight;
      float avgG = sumG / totalWeight;
      float avgB = sumB / totalWeight;
      
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


void draw() {
  // Exibindo a imagem segmentada
  image(img, 0, 0);
  
  save("img3_ground_new.png");
  
  //save("img3_ground_new_2.png");
}
