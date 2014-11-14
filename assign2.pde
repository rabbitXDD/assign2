// global variables
float frogX, frogY, frogW, frogH, frogInitX, frogInitY;
float leftCar1X, leftCar1Y, leftCar1W, leftCar1H;//car1
float leftCar2X, leftCar2Y, leftCar2W, leftCar2H;//car2
float rightCar1X, rightCar1Y, rightCar1W, rightCar1H;//car3
float rightCar2X, rightCar2Y, rightCar2W, rightCar2H;//car4
float pondY;

boolean up;
boolean down;
boolean left;
boolean right;

float frog_Speed;
float car1_Speed;
float car2_Speed;
float car3_Speed;
float car4_Speed;

int life;
int currentTime = 0;
int speedLevel;

final int GAME_START = 1;//final means that GAME_START is a constant and its value won't change
final int GAME_WIN = 2;  //This is a protecting method.
final int GAME_LOSE = 3;
final int GAME_RUN = 4;
final int FROG_DIE = 5;
int gameState;

// Sprites
PImage imgFrog, imgDeadFrog;
PImage imgLeftCar1, imgLeftCar2;
PImage imgRightCar1, imgRightCar2;
PImage imgWinFrog, imgLoseFrog;

void setup(){
  size(640,480);
  textFont(createFont("font/Square_One.ttf", 20));
  // initial state
  gameState = GAME_START;
  
  frog_Speed = 20;

  // the Y position of Pond
  pondY = 32;
  
  // initial position of frog
  frogInitX = 304;
  frogInitY = 448;
  
  frogW = 32;
  frogH = 32;
  
  leftCar1W=leftCar2W=rightCar1W=rightCar2W = 32;//all cars' width 
  leftCar1H=leftCar2H=rightCar1H=rightCar2H = 32;//all cars' height
  leftCar1X = leftCar2X = 0; //position X of leftCar1,2
  rightCar1X = rightCar2X =640-rightCar1H;//position X of rightCar1,2
  
  leftCar1Y = 128;//position Y of leftCar1
  rightCar1Y =192;//position Y of rightCar1
  leftCar2Y  =256;//position Y of leftCar2
  rightCar2Y =320;//position Y of rightCar2
  
  // prepare the images
  imgFrog = loadImage("data/frog.png");
  imgDeadFrog = loadImage("data/deadFrog.png");
  imgLeftCar1 = loadImage("data/LCar1.png");//img of car1
  imgLeftCar2 = loadImage("data/LCar2.png");//img of car2
  imgRightCar1 = loadImage("data/RCar1.png");//img of car3
  imgRightCar2 = loadImage("data/RCar2.png");//img of car4
  imgWinFrog = loadImage("data/win.png");
  imgLoseFrog = loadImage("data/lose.png");
}

void draw(){
  switch (gameState){
    case GAME_START:
        background(10,110,16);   
        int spacing = 100;
        textAlign(CENTER);
        text("Click level of speed:",width/2,width/3-24);
        for (int i=1; i<6; i++){
            fill(50,10,100);
            rect(i*spacing-10, width/3, spacing, 100);
            fill(0);
            text(i, i*spacing+30, width/3+50);
          }
        break;
    case FROG_DIE:
        if(millis()-currentTime >= 1000){
        frogX=frogInitX;
        frogY=frogInitY;
        gameState = GAME_RUN;
        }
        break;
    case GAME_RUN:
        background(10,110,16);
        
        // draw Pond
        fill(4,13,78);
        rect(0,32,640,32);

        // show frog live
        for(int i=0;i<life;i++){
            image(imgFrog,64+i*48 ,32);
         }

        // draw frog
        image(imgFrog, frogX, frogY);

        // -------------------------------
        // Modify the following code
        // to meet the requirement
        // -------------------------------
        //determine car speed randomly
  
   switch(speedLevel){
     
     case 1:
   car1_Speed = random(0,5);
   car2_Speed = random(0,5);
   car3_Speed = random(0,5);
   car4_Speed = random(0,5);
   break;
     case 2:
   car1_Speed = random(3,10);
   car2_Speed = random(3,10);
   car3_Speed = random(3,10);
   car4_Speed = random(3,10);
   break;
     case 3:
   car1_Speed = random(5,12);
   car2_Speed = random(5,12);
   car3_Speed = random(5,12);
   car4_Speed = random(5,12);
   break;
     case 4:
   car1_Speed = random(10,15);
   car2_Speed = random(10,15);
   car3_Speed = random(10,15);
   car4_Speed = random(10,15);
   break;
     case 5:
   car1_Speed = random(15,20);
   car2_Speed = random(10,20);
   car3_Speed = random(5,20);
   car4_Speed = random(0,20);
   break;   
   }
   //println(car1_Speed);
   //println(car2_Speed);
   //println(car3_Speed);
   //println(car4_Speed);
         //car1 move
         
         leftCar1X += car1_Speed;
         if (leftCar1X > width){
             leftCar1X = 0;
         }
         image(imgLeftCar1, leftCar1X, leftCar1Y);
  
         //car2 move
         leftCar2X += car2_Speed;
         if (leftCar2X > width){
             leftCar2X = 0;
         }
         image(imgLeftCar2, leftCar2X, leftCar2Y);
  
         //car3 move
         rightCar1X -= car3_Speed;
         if (rightCar1X < 0){
             rightCar1X = width;
         }
         image(imgRightCar1, rightCar1X, rightCar1Y);

         //car4 move
         rightCar2X -= car4_Speed;
         if (rightCar2X < 0){
             rightCar2X = width;
         }
         image(imgRightCar2, rightCar2X, 
         rightCar2Y);
         
         //frog boundary
          
          if(frogX >= width-32){
            right = false;
            frogX = width-32;
          }
          if(frogX <= 0){
            left = false;
            frogX = 0;
          }
          if(frogY >= height-32){
            down = false;
            frogY = height-32;
          }
         
         float frogCX = frogX+frogW/2;
         float frogCY = frogY+frogH/2;
         
         // car1 hitTest
           if(frogCX>leftCar1X && frogCX<leftCar1X+48 && frogCY>leftCar1Y && frogCY<leftCar1Y+48)
           {
             currentTime = millis();
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
           }             
         // car2 hitTest
           if(frogCX>rightCar1X && frogCX<rightCar1X+48 && frogCY>rightCar1Y && frogCY<rightCar1Y+48)
           {
               currentTime = millis();
               image(imgDeadFrog, frogX, frogY);
               life--;
               gameState = FROG_DIE;
           }             
           // car3 hitTest
           if(frogCX>leftCar2X && frogCX<leftCar2X+48 && frogCY>leftCar2Y && frogCY<leftCar2Y+48)
           {
               currentTime = millis();
               image(imgDeadFrog, frogX, frogY);
               life--;
               gameState = FROG_DIE;
           }             
           // car4 hitTest
                if(frogCX>rightCar2X && frogCX<rightCar2X+48 && frogCY>rightCar2Y && frogCY<rightCar2Y+48)
                {
               currentTime = millis();
               image(imgDeadFrog, frogX, frogY);
               life--;
               gameState = FROG_DIE;
           }             
           
           //frog win
               if(frogY <= 32){
                 gameState = GAME_WIN;
               }
           
           //frog lose
               if(life == 0){
                 gameState = GAME_LOSE;
               }
        break;
    case GAME_WIN:
        background(0);
        image(imgWinFrog,207,164);
        fill(255);
        textAlign(CENTER);
        text("You Win !!",width/2,height/5);
        text("PRESS ENTER TO RESTART",width/2,height/5+40);
        break;
    case GAME_LOSE:
        background(0);
        image(imgLoseFrog,189,160);
        fill(255);
        textAlign(CENTER);
        text("You Lose",width/2,height/5); 
        text("PRESS ENTER TO RESTART",width/2,height/5+40);
        break;
  }
}
void keyPressed() {
    if (key == CODED && gameState == GAME_RUN) {
     switch( keyCode )
      {//frog move
         case UP:
          frogY = frogY - frog_Speed;
          break;
          
        case DOWN:
          frogY = frogY + frog_Speed;
          break;
          
        case LEFT:
          frogX = frogX - frog_Speed;
          break;
          
        case RIGHT:
          frogX = frogX + frog_Speed;
          break;
      }
  }
  if(key==ENTER && (gameState == GAME_WIN||gameState == GAME_LOSE)){
      gameState = GAME_START;
      life=3;
      frogX = frogInitX;
      frogY = frogInitY;
    }
}

void mouseClicked(){
  if ( gameState == GAME_START &&
       mouseY > width/3 && mouseY < width/3+100){
       // select 1~9
       //int num = int(mouseX / (float)width*9) + 1;
       int speed = (int)map(mouseX, 90, 590, 0, 5) + 1;
        speedLevel = speed;
        
        life=3;
        frogX = frogInitX;
        frogY = frogInitY;
        gameState = GAME_RUN;
       }
}

    
