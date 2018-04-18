import processing.pdf.*;

PFont dotmatrix;
PShape logo;
PShape path;
String date;
boolean member = false;
int batch = 20;

/**
 * Setup method
 *
 * This method is automatically called before the sketch is luanched. It sets some parameters up.
 */
void setup(){
  size(204,325);
  background(255, 255, 255);
  
  dotmatrix = createFont("DOTMATRI.TTF",32,true);
  logo = loadShape("LogoE.svg");
  path = logo.getChild("logo");
  path.disableStyle();
  date = String.valueOf(day());
  randomSeed(1991);
}

/**
 * Frame drawing method
 *
 * This method is called by processing on each frame. In this case, it is empty because everything's managed by drawCard() 
 */
void draw(){}


/**
 * Keyboard callback
 *
 * Everytime a key is pressed, this method is called by processing. The keys configuration for this sketch is the following:
 *     - m: toggle between members and pass cards
 *     - enter: generate 25 cards
 */
void keyPressed(){
  if(key == 'm')
    member = !member;
    
  if(key == ENTER){
    for(int i = 1; i <= 25; i++){
      beginRecord(PDF, "/exports/card"+ date + String.valueOf(minute()) + String.valueOf(second())+ String.valueOf(i) + ".pdf"); 
      drawCard(member); 
      endRecord();
    }
  }else{
    drawCard(member); 
  }
}

/**
 * Draw a card
 *
 * This method generates a new card and displays it to the screen.
 * 
 * @param isMember boolean defining if the generated card is a member card. True for member card, false or pass
 */
void drawCard(boolean isMember){
  background(255, 255, 255);
  color[] colors;    // array of colors
  int diskDiameter;  // diameter of the disks
  int layerSpacing;  // space between each layer
  int diskFactor;    // factor for the number of disks for each layer: diskFactor * layerNumber
  int layersCount;   // number of layers
  String text;
  if(isMember){
    color[] c = {#2c9670, #4b7e65, #6b655a, #8a4d4f, #a93545, #c91c3a, #e8042f};
    colors = c;
    diskDiameter = 5;
    layerSpacing = 1;
    diskFactor = 10;
    layersCount = 30;
    text = "Membre 2017";
  }else{
    color[] c = {#D6D4A0, #DB995A, #DA7635, #E24E1B, #654236};
    //color[] c = {#F1BF98, #FB8B24, #D90368, #820263, #291720};
    colors = c;
    diskDiameter = 7;
    layerSpacing = 1;
    diskFactor = 12 ;
    layersCount = 40;
    text = "Pass 2017";
  }
  
  for(int i = 0; i < layersCount; i++){
    color ci = colors[i%colors.length] ;
    drawLayer(diskFactor * (i+1),width/2, height/3, (i+1) * (diskDiameter + layerSpacing), ci, diskDiameter);
  }

  shapeMode(CENTER);
  fill(255,255,255);
  shape(path,width/2, height/3);
  
  noStroke();
  fill(255,255,255);
  rect(0,height,width,-60);
  
  textAlign(CENTER);
  textFont(dotmatrix);
  fill(colors[(layersCount-1)%colors.length]);
  text(text,width/2,height - 20);
}

/**
 * Draw only one of the concentric circle
 *
 * This method draws one of the dotted concentric circles
 * 
 * @param count        number of dots on the circle
 * @param cx           x coordinate of the center 
 * @param cy           y coordinate of the center
 * @param size         rayon of the circle
 * @param dotsColor    color of the dots
 * @param dotsDiameter diameter of the dots
 */
void drawLayer(int count, float cx, float cy, float size, color dotsColor, int dotsDiameter {
  for(int i = 0; i < count; i++){
    float angle = random(2*PI) ;
    float x = cx + size * cos(angle);
    float y = cy + size * sin(angle);
    
    noStroke();
    fill(dotsColor);
    ellipse(x, y, dotsDiameter  dotsDiameter ;
  }
}