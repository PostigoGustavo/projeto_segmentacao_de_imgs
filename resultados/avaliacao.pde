PImage segmentedImage;
PImage groundTruthImage;

int FP = 0; 
int FN = 0;
int VP = 0;
int VN = 0;

String saida = "/home/user/Desktop/Projeto_Segmentacao_de_imgs/";
String nome_img = "imgX.png";

void setup() {
  size(800, 600);
  
  segmentedImage = loadImage("/home/user/Desktop/Projeto_Segmentacao_de_imgs/imgX/imgX_ground_new.png");
  groundTruthImage = loadImage("/home/user/Desktop/Projeto_Segmentacao_de_imgs/imgX/imgX_ground.png");
  
  int newWidth = width; 
  int newHeight = height; 

  segmentedImage.resize(newWidth, newHeight);
  groundTruthImage.resize(newWidth, newHeight);
  
  markErrors();
  
  image(segmentedImage, 0, 0);
}

void markErrors() {
  segmentedImage.loadPixels();
  groundTruthImage.loadPixels();
  
  // Iterar sobre cada pixel nas imagens
  for (int i = 0; i < segmentedImage.pixels.length; i++) {
    int segmentedPixel = segmentedImage.pixels[i];
    int groundTruthPixel = groundTruthImage.pixels[i];
    
    // Comparar os pixels entre a imagem segmentada e a imagem de ground truth
    if (segmentedPixel == color(255) && groundTruthPixel == color(0)) {
      // Falso positivo: destacar em vermelho
      segmentedImage.pixels[i] = color(255, 0, 0);
      FP++;
    } else if (segmentedPixel == color(0) && groundTruthPixel == color(255)) {
      // Falso negativo: destacar em azul
      segmentedImage.pixels[i] = color(0, 0, 255);
      FN++;
    } else if (segmentedPixel == color(255) && groundTruthPixel == color(255)) {
      VP++;
    } else if (segmentedPixel == color(0) && groundTruthPixel == color(0)) {
      VN++;
    }
  }
  
  segmentedImage.updatePixels();
  
  // Calcular métricas
  float precision = (float) VP / (VP + FP);
  float recall = (float) VP / (VP + FN);
  float f1Score = 2 * precision * recall / (precision + recall);
  
  println("Precision: " + precision);
  println("Recall: " + recall);
  println("F1-Score: " + f1Score);
  
}

void draw(){
  
  save(saida + nome_img);
}
