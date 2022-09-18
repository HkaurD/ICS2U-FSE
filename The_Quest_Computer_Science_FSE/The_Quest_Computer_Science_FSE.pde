//Harbin Kaur Dhillon //<>//
//The Quest-FSE

//To get the song in the background imported into the code
import processing.sound.*;
SoundFile song;

boolean canShoot=true;//The player can only shoot when canShoot is false; can only shoot 1 spell at a time
int x=50;//The x-position of Harry Potter in the main menu when he runs across the screen
int vx=1200;//Voldemort's starting position in the third level; he is going to be moving right and left on the screen
int vdir=-3;//To move Voldemort on the screen, first towards the left
int x1=10;//Beginning of level 1; the intro text moving
int x2=20;//Beginning of level 2; the intro text moving
int x3=20;//Beginning of level 3; the intro text moving
int y=20;//y-coordinate of the horcrux in the first level
int y2=20;//y-coordinate of the horcrux in the second level
int offset1;//The background position; needed for side scrolling in the first level
int offset2;//The background position; needed for side scrolling in the second level
int offset3;//The background position; needed for side scrolling in the third level
int jumpSpeed=-25;//To make the characters jump
int gravity=2;
int level=1;//The levels start from level 1
int lives=10;
//To reset the number of spells back to 5 after each level
int spells=5;//Number of spells in the first level 
int spells2=5;//Number of spells in the second level
int spells3=5;//Number of spells in the third level
int numplatforms=70;
int pw=60;//The platforms' width
int ph=10;//The platforms' height
int numdementors=15;//Number of enemies, dementors, in the second level
int numenemyspells=30;//Number of enemy spells in the second level
int health=5;//The health for Voldemort in level 3; if the health is 0, the player wins

float frame1=0.0;//The frame rate for the character running in the game menu
float frame2=0.0;//1st character; Ron
float frame3=0.0;//Spiders
float frame4=0.0;//Spells in level 1
float frame5=0.0;//Snakes
float frame6=0.0;//2nd character; Hermione
float frame7=0.0;//Spells in level 2
float frame8=0.0;//Enemy spells in level 2
float frame9=0.0;//3rd character; Harry
float frame10=0.0;//Spells in level 3
float frame11=0.0;//Voldemort's images in level 3
float frame12=0.0;//Voldemort's spells in level 3
float volume=1;

PFont font;
PFont font2;

PImage bg;//The background at the main menu
PImage bg2;//The background for the 'instructions' tab in the main menu 
PImage bg3;//The background in level 1
PImage bg4;//The background for when the player wins
PImage bg5;//The background in level 2
PImage bg6;//The background in level 3
PImage volume1;
PImage volume2;
PImage hearts;
PImage wand;
PImage hermionespell;
PImage gameoverbg;
PImage horcrux1;
PImage horcrux2;
PImage dementors;

PImage[] images3=new PImage[15];
PImage[] rightImages1=new PImage[4];//The right images for Ron; level 1
PImage[] leftImages1=new PImage[4];//The left images for Ron; level 1
PImage[] rightImages2=new PImage[4];//The right images for Hermione; level 2
PImage[] leftImages2=new PImage[4];//The left images for Hermione; level 2
PImage[] rightImages3=new PImage[4];//The right images for Harry; level 3
PImage[] leftImages3=new PImage[4];//The left images for Harry; level 3
PImage[] spiders=new PImage[71];
PImage[] rightspellImages=new PImage[8];
PImage[] leftspellImages=new PImage[8];
PImage[] snakes=new PImage[50];
PImage[] enemyspells=new PImage[8];
PImage[] voldemortrightimages=new PImage[3];
PImage[] voldemortleftimages=new PImage[3];
PImage[] vrightspells=new PImage[8];//Voldemort's spells facing the right in level 3
PImage[] vleftspells=new PImage[8];//Voldemort's spells facing the left in level 3

IntList ex=new IntList();//The x-xoordinates of the randomly drawn spiders in the first level
//The x-coordinates and y-coordinates of the spells for the 1st character
IntList sx1=new IntList();
IntList sy1=new IntList();
//The x-coordinates and y-coordinates of the spells for the 2nd character
IntList sx2=new IntList();
IntList sy2=new IntList();
//The x-coordinates and y-coordinates of the spells for the 3rd character
IntList sx3=new IntList();
IntList sy3=new IntList();
IntList spellspeed1=new IntList();//To move the spells left OR right in level 2; the spells in level 1 only go right
IntList spellspeed2=new IntList();//To move the spells left OR right in level 3
IntList snakex=new IntList();//The x-coordinates of the snakes
IntList yhorcrux1=new IntList();//The y-coordinate of the horcrux in level 1; it moves down towards the character
IntList yhorcrux2=new IntList();//The y-coordinate of the horcrux in level 2; it moves down towards the character
IntList platx=new IntList();//The x-positions for the platforms in level 2
IntList platy=new IntList();//The y-positions of the platforms in level 2
IntList dementorsx=new IntList();//The x-positions of the dementors in level 2
IntList dementorsy=new IntList();//The y-positions of the dementors in level 2
IntList sdir=new IntList();//The speed/direction of ALL THE dementors; to change their directino before they're off the screen
IntList enemyspellsx=new IntList();//The random x-coordinates of the enemy spells in level 2 and the top of the screen  
IntList enemyspellsy=new IntList();//The random y-coordinates of the enemy spells in level 2 from off the top of the screen
IntList vspellsx=new IntList();//The x-coordinates of Voldemort's spells  
IntList vspellsy=new IntList();//The y-coordinates of Voldemort's spells
IntList vspellspeed=new IntList();//To move Voldemort's spells left OR right in level 3, like in level 2

//To determine whether you show the left images or right images of the 3 characters in all the levels, based on what key is pressed
boolean moveRight=false;
boolean moveLeft=false;
//To know whether to show the left images or right images for Voldemort in level 3
boolean vmoveRight=false;
boolean vmoveLeft=true;
boolean vright=false;//If Voldemort's facing the right
boolean vleft=false;//If Voldemort's facing the left
boolean jump=false;
boolean[] keys=new boolean[128];

int gameMode=0;//To make different tabs in the menu screen; 0 is the main menu, 1 is playing, 2 is the instructions and 3 is the controls
int idle=0;//To determine whether the character is facing left or right; 0 is right and 1 is left
int numSpiders=20;//The number of spiders
int numSnakes=20;//The number of snakes

int[] v1={0, 0, height, 300};//v1[0] is the first character's horizontal velocity, v1[1] is the vertical velocity, v1[2] is the bottom of the screen and v1[3] is the screen position
int[] v2={0, 0, height, 300};//v2[0] is the second character's horizontal velocity, v2[1] is the vertical velocity, v2[2] is the bottom of the screen and the platforms and v2[3] is the screen position
int[] v3={0, 0, height, 300};//v3[0] is the third character's horizontal velocity, v3[1] is the vertical velocity, v3[2] is the bottom of the screen and v3[3] is the screen position
int[] ron={300, 409, 18, 40};//ron[0] is the first character's x coordinate, ron[1] is the y coord, ron[2] is the width, and ron[3] is the height
int[] hermione={300, 650, 32, 32};//hermione[0] is the second character's x coordinate, hermione[1] is the y coord, hermione[2] is the width, and hermione[3] is the height
int[] harry={300, 695, 32, 48};//harry[0] is the third character's x coordinate, harry[1] is the y coord, harry[2] is the width, and harry[3] is the height

void setup() {
  size(500, 334);//The size of the screen in the main value
  frameRate(60);
  surface.setResizable(true);//To enable changing the size of the screen for different levels
  font=loadFont("AmericanTypewriter-Light.vlw");//Uploading a built in font in Processing to use in the code
  font2=loadFont("AmericanTypewriter-Bold.vlw");
  //Uploading the backgrounds for the different levels and the game
  bg=loadImage("Hogwarts Wallpaper 3.jpg");
  bg2=loadImage("Hogwarts Letter.jpg");
  bg3=loadImage("Hogsmeade1.png");// The background is 1161 by 479
  bg4=loadImage("WinBackground.jpg");
  bg5=loadImage("Level2background.jpg");
  bg6=loadImage("Background4.jpg");
  //Uploading images that control and represent raising or lowering the volume and resizing it to make them an appropriate size for the game
  volume1=loadImage("Volume Increase.jpg");
  volume1.resize(40, 40);
  volume2=loadImage("Volume Decrease.jpg");
  volume2.resize(40, 40);
  hearts=loadImage("Lives.png");//Uploading hearts that will represent the characters' lives
  hearts.resize(30, 30);
  wand=loadImage("Wand.png");//Uploading wands that will represent the number of spells the character has left
  wand.resize(30, 30);
  hermionespell=loadImage("Hermione017.png");
  gameoverbg=loadImage("GameOver.jpg");
  horcrux1=loadImage("Horcrux1.png");
  horcrux1.resize(50, 70);
  horcrux2=loadImage("Horcrux2.png");
  horcrux2.resize(50, 70);
  dementors=loadImage("Dementors.png");
  dementors.resize(20, 60);
  //song=new SoundFile(this, "Harry Potter Theme Song.mp3");//Uploading the song mp3 file for the game
  //song.play();//Playing the song
  for (int i=0; i<rightImages1.length; i++) {//To upload all the right images of Ron for level 1
    rightImages1[i]=loadImage("Ron"+nf(i+8, 3)+".png");
  }
  for (int i=0; i<leftImages1.length; i++) {//To upload all the left images of Ron for level 1
    leftImages1[i]=loadImage("Ron"+nf(i+4, 3)+".png");
  }
  for (int i=0; i<rightImages2.length; i++) {//To upload all the right images of Hermione for level 2
    rightImages2[i]=loadImage("Hermione"+nf(i+12, 3)+".png");
  }
  for (int i=0; i<leftImages2.length; i++) {//To upload all the left images of Hermione for level 2
    leftImages2[i]=loadImage("Hermione"+nf(i+6, 3)+".png");
  }
  for (int i=0; i<rightImages3.length; i++) {//To upload all the right images of Harry for level 3 and the main menu
    rightImages3[i]=loadImage("Harry"+nf(i+8, 3)+".png");
  }
  for (int i=0; i<leftImages3.length; i++) {//To upload all the left images of Harry for level 3
    leftImages3[i]=loadImage("Harry"+nf(i+4, 3)+".png");
  }
  for (int i=0; i<spiders.length; i++) {//To upload all the images/the sprites of the spiders
    spiders[i]=loadImage("Spiders"+nf(i, 3)+".png");
  }
  for (int i=0; i<numSpiders; i++) {//Creating random integer x-coordinates for the spiders off the right side of the screen
    ex.append(round(random(700, 4000)));
  }
  for (int i=0; i<rightspellImages.length; i++) {
    rightspellImages[i]=loadImage("Spell"+nf(i+32, 3)+".png");
  }
  for (int i=0; i<leftspellImages.length; i++) {
    leftspellImages[i]=loadImage("Spell"+nf(i+40, 3)+".png");
  }
  for (int i=0; i<snakes.length; i++) {
    snakes[i]=loadImage("tile"+nf(i, 3)+".png");
  }
  for (int i=0; i<numSnakes; i++) {
    snakex.append(round(random(700, 5000)));//Random x positions for the snakes off the right side of the screen
  }
  for (int i=0; i<numplatforms; i++) {
    //Creating random platforms around the screen in level 2 
    platx.append(int(random(100, 1180)));//The screen size in level 2 is 600 by 720, while the background is 1280 by 720
    platy.append(int(random(40, 680)));
  }
  for (int i=0; i<numdementors; i++) {
    //Creating random x and y-coordinates for the dementors in level 2
    dementorsx.append(int(random(50, 1230)));
    dementorsy.append(int(random(0, 550)));
  }
  for (int i=0; i<numdementors; i++) {
    sdir.append(int(random(1, 2)));//Creating random speeds for the dementors in level 2
  }
  for (int i=0; i<enemyspells.length; i++) {
    enemyspells[i]=loadImage("EnemySpell"+nf(i, 3)+".png");
  }
  for (int i=0; i<numenemyspells; i++) {
    //Creating random x and y-coordinates for the enemy spells that fly down in level 2
    enemyspellsx.append(int(random(10, 1270)));
    enemyspellsy.append(int(random(-4000, 0)));
  }
  for (int i=0; i<voldemortleftimages.length; i++) {//To upload all the left images of Voldemort in level 3
    voldemortleftimages[i]=loadImage("Voldemort"+nf(i, 3)+".png");
  }
  for (int i=0; i<voldemortrightimages.length; i++) {//To upload all the right images of Voldemort in level 3
    voldemortrightimages[i]=loadImage("Voldemort"+nf(i+3, 3)+".png");
  }
  for (int i=0; i<vrightspells.length; i++) {
    vrightspells[i]=loadImage("VSpell"+nf(i+32, 3)+".png");
  }
  for (int i=0; i<leftspellImages.length; i++) {
    vleftspells[i]=loadImage("VSpell"+nf(i+40, 3)+".png");
  }
}//End setup

void draw() {
  //song.amp(volume);//To change the volume of the song, if the player wants
  if (gameMode==0) {
    mainMenu();//If the game mode is 0, show the main menu
    textFont(font);//To make all the text in the 1st uploaded font
  } else if (gameMode==1) {
    playing();//If the game mode is 1, show the first level and start the game
    textFont(font);//To make all the text in the 1st uploaded font
  } else if (gameMode==2) {
    instructions();//If the game mode is 2, show the instructions to the game
    textFont(font2);//To make all the text in the 2nd uploaded font
  } else if (gameMode==3) {
    controls();//If the game mode is 3, show the contols screen
    textFont(font);//To make all the text in the 1st uploaded font
  } else if (gameMode==4) {
    showGameOver();//The actual game over function with the background and text
    textFont(font);//To make all the text in the 1st uploaded font
  } else if (gameMode==5) {
    restartLevel1();//If the player presses on the restart level 1 button, then level 1 resets back to the beginning
  }
}//End draw

void playing() {
  if (level==1) {//If the 'Start' function is done and the level is equal to 1;by default the level is 0
    //Drawing the functions that create the first level

    surface.setSize(600, 479);//Changing the size of the screen so that I could create a "side-scrolling" effect
    x1=Start(x1);//To show the 'Start' function at x1, which is 20
    if (x1>width) {
      offset1=200-ron[0];//The offset1 variable shows part of the background based on the character's position in level 1
      image(bg3, offset1, 0);//Drawing the background at the offset position, which changes as the character moves
      fill(255);//White text
      moveSpells();
      moveRon();
      checkSpellsSpiders();
      drawSpells();
      drawCharacters1();
      checkGround();
      drawSnakes();
      moveSnakes();
      checkRonSnakes();
      checkSpellsSnakes();
      drawHorcrux1();
      moveHorcrux1();
    }
  }
  if (level==2) {

    surface.setSize(600, 720);//The background is 1280 by 720 pixels
    x2=Startlevel2(x2);
    if (x2>width) {
      offset2=v2[3]-hermione[0];
      image(bg5, offset2, 0);
      fill(255);
      drawCharacters2();
      moveHermione();
      checkGround2();
      moveSpells2();
      drawSpells2();
      drawDementors();
      moveDementors();
      checkHermioneDementors();
      checkSpellsDementors();
      drawenemyspells();
      checkHermioneEnemyspells();
      drawHorcrux2();
    }
  }
  if (level==3) {
    if (health>0) {//If Voldemort is still alive and has a health greater than 0, then you draw the characters and play level 3
      surface.setSize(600, 768);//The background is 2304 by 768 pixels
      x3=Startlevel3(x3);
      if (x3>width) {
        offset3=v3[3]-harry[0];
        image(bg6, offset3, 0);
        drawCharacters3();
        moveHarry();
        checkGround3();
        drawSpells3();
        moveSpells3();
        drawVoldemort();
        drawvspells();
        movevspells();
        checkvspellsHarry();
        checkVoldemortHarry();
        checkspellVoldemort();
      }
    }
    youWin();//Only if Voldmort's health is 0, the player wins
  }
  //These functions are continously playing regardless of the level
  checkGameOver();
  backToMain();
  if (level>1) {//You can only restart level 1 if you are on levels 2 or 3
    checkRestartLevel1();
  }
}//End playing

void instructions() {
  surface.setSize(550, 383);//Setting the size of the screen as the same size of the bagkround image; 550 by 383
  image(bg2, 0, 0);//Drawing the backgorund image at point (0, 0) so that it covers the whole screen
  textSize(30);
  fill(0);//Black text
  textAlign(CENTER);//Centering the text
  text("How To Play", 270, 70);//Title
  textSize(10);
  fill(0);//Black text
  textAlign(LEFT);//Moving the text to start from the left
  //Showing the text that tells the player what to do in the game; instructions
  text("Harry Potter, Ron Weasley and Hermione Granger are on a quest to kill Voldemort, and it's your", 30, 100);
  text("job to help them. You will face 3 different levels in which you will have different obstacles", 30, 120);
  text("and enemies. You must avoid or destroy them with spells before you lose all your lives; you have", 30, 140);
  text("10 lives. You have 5 spells max with each character and you gain 2 spells when killing an enemy.", 30, 160);
  //Displaying the images and the text to show the player what keys to use to move and displaying the meaning of images; e.g. hearts represent lives
  text("Jump = Space Bar", 30, 190);
  text("Spells = s key", 30, 210);
  text("Move right = Right arrow", 30, 230);
  text("Move left = Left arrow", 30, 250);
  image(hearts, 300, 190);
  text("= Number of lives", 340, 210);
  image(wand, 300, 230);
  text("= Number of spells", 340, 250);
  backToMain();
}//End instructions

void controls() {
  background(bg);//Displaying the bg image as the background
  fill(255);//White text
  textSize(20);
  text("Music Controls", 50, 50);
  fill(255);
  //Displaying the '+' and '-' images that when clicked, change the volume
  image(volume1, 50, 100);
  image(volume2, 150, 100);
  if (volume>=0) {
    text("Volume Level: "+volume, 300, 100);//To show the volume, if the volume is more than 0 next to the images
  }
  backToMain();
}//End controls

void mousePressed() {
  if (mouseX>50 && mouseX<90 && mouseY>100 && mouseY<140 && volume<1) {//If the player clicks on the '+' image, and the volume is less than 1/is not on full volume
    volume+=0.1;//Increase the volume by 0.1
  }
  if (mouseX>150 && mouseX<190 && mouseY>100 && mouseY<140 && volume>0) {//If the player clicks on the '-' image, and the volume is more than 0/is not on mute
    volume-=0.1;//Decrease the volume by 0.1
  }
}//End mousePressed

void mainMenu() {
  background(bg);//Displaying the bg image as the background
  textAlign(LEFT);//Making the text appear from the left side of the screen
  textSize(35);
  fill(255);//White text
  //Displaying the text that represents the different tabs on the main menu
  text("Play", 210, 140);
  text("Instructions", 150, 180);
  text("Controls", 180, 220);
  image(rightImages3[int(frame1)], x, 270);//To display the right images of Harry Potter to male him look like he's running 
  frame1+=0.1;//Increasing frame image 
  x+=3;//To increase the x-coordinate of Harry Potter to make him 'run' to th right side of the screen
  if (frame1>4) {//If the frame image is more than the 4th/last one
    frame1=1.0;//Display the 1st one; not the 0th image
  }
  if (x>width) {//If the player is off the screen
    x=-500;//So that the player is off the left side of screen, and comes onto the screen a few seconds later
  }
  if (mouseIn(205, 120, 70, 20)) {//If the players mouse in hovering over the "Play" text
    //Displaying the text "Play" in black text 
    fill(0);
    text("Play", 210, 140);
    if (mousePressed) {//If the player clicks on the "Play" text
      gameMode=1;//Start the game and the playing function
      lives=10;
    }
  }
  if (mouseIn(145, 160, 205, 30)) {//If the players mouse is hovering over the "Instructions" text
    //Displaying the text "Instructions" in black text
    fill(0);
    text("Instructions", 150, 180);
    if (mousePressed) {//If the player clicks on the "Instructions" text
      gameMode=2;//Show the instructions screen and start the instructions function
    }
  }
  if (mouseIn(175, 200, 145, 25)) {//If the players mouse is hovering over the "Controls" text
    //Displaying the text "Controls" in black text
    fill(0);
    text("Controls", 180, 220);
    if (mousePressed) {//If the player clicks on the "Controls" text
      gameMode=3;//Show the controls screen and start the controls function
    }
  }
}//End mainMenu

void backToMain() {
  textAlign(LEFT);
  textSize(15);
  fill(255);//White text
  text("Back", 50, 30);//To create a back to main menu button
  if (mouseIn(45, 10, 60, 30)) {//If the player is hovering over the "Back" text
    //Display the "Back" text in black 
    fill(0);
    text("Back", 50, 30);
    if (mousePressed) {//If the player clicks on the "Back" text
      surface.setSize(500, 334);//Reset the background to the size of bg
      gameMode=0;//Go back to the game menu
    }
  }
}//End backToMain

int Start(int x1) {
  //The intro text for the start of level 1
  background(0);
  x1+=2;//To increase the x position of the text to make it look like it's moving to the right
  textFont(font2);//Displaying the text in the 2nd font
  textSize(20);
  fill(255);//Black text
  text("Dodge and use spells to obtain and click on the horcrux!", x1, height/2);//Moving and displaying the text to the right from position (20, 239.5)
  return x1;
}//End Start

void checkSpellsSpiders() {//A nested loop to check for collisions
  for (int i=0; i<ex.size(); i++) {//All the x-coordinates for the spiders
    int[] spider={ex.get(i), 429, 20, 16};
    for (int m=0; m<sx1.size(); m++) {
      int[] spellxy={sx1.get(m), sy1.get(m), 25, 7};
      //If a one of the spells touch the spiders, then the spider is removed and the spell is removed
      if (hitBox(spider, spellxy)) {
        sx1.remove(m);
        sy1.remove(m);
        ex.remove(i);

        if (spells<5) {//They get another spell is the number of spells is less than 5
          spells++;
        }
        break;
      }
    }
  }
}//end checkSpellsSpiders

void drawSpells() {
  for (int m=0; m<sx1.size(); m++) {//Drawing the spells at the spot where the player presses the 's' key
    image(rightspellImages[int(frame4)], sx1.get(m), sy1.get(m)); 
    frame4+=0.1;
    if (frame4>8) {
      frame4=1.0;
    }
  }
}//end drawSpells

void drawCharacters1() {
  for (int i=0; i<lives; i++) {//Drawing 10 hearts to represent the 10 lives
    image(hearts, 50+i*30, 27);
  }
  for (int i=0; i<spells; i++) {//Drawing 5 spells to represent the number of spells left
    image(wand, 425+i*30, 27);
  }
  if (moveRight) {//If the player presses the right key
    image(rightImages1[int(frame2)], v1[3], ron[1]);//Display the right images and move them towards the right with horizontal velocity
  } else if (moveLeft) {//If the player presses the left key
    image(leftImages1[int(frame2)], v1[3], ron[1]);//Display the left images
  } else {//If no key is pressed
    if (idle==0) {//If the charater's facing the right, show the right images
      image(rightImages1[0], v1[3], ron[1]);
    } else if (idle==1) {//If the players facing the left, show the left images
      image(leftImages1[0], v1[3], ron[1]);
    }
  }
  frame2+=0.1;//Increase the frame image for the right or left images
  if (frame2>4) {//If the last frame image is shown
    frame2=1.0;//Go back to the 1st image, not the 0th
  }
  for (int i=0; i<ex.size(); i++) {//All the x-coordinates for the spiders
    int[] spider={ex.get(i), 429, 20, 16};//An array for all the spiders; 0 is the x-coordinate, 1 is the y-coordinate, 3 is the width and 4 is the height
    image(spiders[int(frame3)], ex.get(i), spider[1]);//Drawing all the spiders' images and the spiders at different positions
    frame3+=0.1;//Increasing the frame image to make them look like their moving
    ex.add(i, -3);//Decreasing the x-position of each spider and moving them towards the left
    if (frame3>71) {//If the last frame image is shown
      frame3=1.0;//Go back to the 1st
    }
    if (hitBox(ron, spider)) {//If the character, Ron, touches a spider
      lives--;//Decrease the number of lives by 1
      ex.remove(i);//Remove the spider
    }
  }
}//End drawCharacters

void addSpell() {
  //When the 's' key is pressed, then you draw the spells wherever the character is
  sx1.append(v1[3]+50);
  sy1.append(ron[1]+20);
}//end addSpell

void moveSpells() {
  for (int m=0; m<sx1.size(); m++) {
    //Moving ALL the spells towards the right
    sx1.add(m, 1);
  }
}//end moveSpells

void moveRon() {
  if (jump && ron[1]==height-ron[3]-30 && v1[1]==0) {//If the player presses the space bar and if Ron is on the ground
    v1[1]=jumpSpeed;//Setting the vertical velocity to the jumpSpeed to make Ron jump
  }
  if (moveRight && ron[0]<761) {//If the player presses the right arrow key and if Ron is more than 300 minus the horizontal size of the bg3, 1161
    v1[0]=2;//Move to the right
    idle=0;//Facing the right
    if (v1[3]<449) {//To move the character to the right 2 pixels if the screen is less than 449, 30 minus the right side of the screen  
      v1[3]+=2;
    }
  } else if (moveLeft && ron[0]>300) {//If the player presses the left arrow key and if Ron is more than 300 pixels from the left of the screen
    v1[0]=-2;//Move to the left
    idle=1;//Facing the left
    if (v1[3]>30) {//To move the player 2 pixels to the left if Ron's more than 30 pixels, but less than 300 pixels from the left side of the screen
      v1[3]-=2;
    }
  } else {
    v1[0]=0;//Not moving
  }
  v1[1]+=gravity;//Applying gravity to the jump
  ron[0]+=v1[0];//Increasing the x-position of the character by the horizontal velocity;moving left or right
}//End moveRon

void checkGround() {//So the player doesn't fall out of the screen
  ron[1]+=v1[1];//Increasing the character's y-position by the vertical velocity; jumping up and down
  if ((ron[1]+ron[3])>=height-30) {//If the character's y-position is more than 30 pixels from the height of the screen
    v1[1]=0;//Not jumping any more
    v1[2]=height;
    ron[1]=height-ron[3]-30;//Reseting Ron's y-position to 30 pixels above the height of the screen
  }
}//End checkGround

void drawSnakes() {
  for (int i=0; i<snakex.size(); i++) {
    image(snakes[int(frame5)], snakex.get(i), 409);//Drawing all the snakes at the random x-coordinates
    frame5+=0.1;
    if (frame5>7) {
      frame5=1.0;
    }
  }
}//End drawSnakes

void moveSnakes() {
  for (int i=0; i<snakex.size(); i++) {
    //Moving ALL the snakes towards the left 
    snakex.add(i, -2);
  }
}//End moveSnakes

void checkRonSnakes() {
  for (int i=0; i<snakex.size(); i++) {
    int [] snakexy={snakex.get(i), 409, 32, 32};
    if (hitBox(ron, snakexy)) {//If Ron touches one of the snakes, the character loses a life and the snake is removed
      lives--;
      snakex.remove(i);
    }
  }
}//End checkRonSnakes

void checkSpellsSnakes() {//A nested loop to check for collision between a spell and a snake
  for (int i=0; i<snakex.size(); i++) {
    int [] snakexy={snakex.get(i), 409, 32, 32};
    for (int m=0; m<sx1.size(); m++) {
      int[] spellxy={sx1.get(m), sy1.get(m), 25, 7};
      if (hitBox(snakexy, spellxy)) {//If a spell touches a snake, the snake is removed and the spell is removed
        snakex.remove(i);
        sx1.remove(m);
        sy1.remove(m);
        if (spells<5) {//If the number of spells is less than 5, the character gets another spell
          spells++;
        }
        break;
      }
    }
  }
}//End checkSpellsSnakes

int Startlevel2(int x2) {
  //The intro for the start of level 2
  background(0);
  x2+=2;//To increase the x position of the text to make it look like it's moving to the right
  textFont(font2);//Displaying the text in the 2nd font
  textSize(20);
  fill(255);//Black text
  text("Get ready for level 2!", x2, height/2);//Moving and displaying the text to the right from position (20, 239.5)
  return x2;
}//End Startlevel2

void moveHorcrux1() {
  for (int i=0; i<yhorcrux1.size(); i++) {
    image(horcrux1, 250, yhorcrux1.get(i));//Showing the horcrux at the top of the screen
    yhorcrux1.add(i, 1);//Moving the picture downwards
    if (yhorcrux1.get(i)>=400) {//If the picture is about to get off the bottom of the screen, then display the picture at the y-coordinate of 400
      yhorcrux1.set(i, 400);
    }
    if (mouseIn(250, yhorcrux1.get(i), 50, 70)) {
      if (mousePressed) {//If the player clicks on the horcrux image, then the player is on level 2
        level=2;
      }
      break;
    }
  }
}//End moveHorcrux1

void drawHorcrux1() {
  if (ron[0]+ron[2]==width-30) {//If the enemies are all gone and the character moves to the right side of the screen, where the enemies were coming from
    yhorcrux1.append(y);//Creating the y value where the horcrux will be drawn
  }
}//End drawHorcrux1

void drawCharacters2() {
  for (int i=0; i<lives; i++) {//Drawing the number of lives; represented by hearts
    image(hearts, 50+i*30, 27);
  }
  for (int i=0; i<spells2; i++) {//Drawing the number of spells left
    image(wand, 425+i*30, 27);
  }
  if (moveRight) {//If the player presses the right key
    image(rightImages2[int(frame6)], v2[3], hermione[1]);//Display the right images and move them towards the right with horizontal velocity
  } else if (moveLeft) {//If the player presses the left key
    image(leftImages2[int(frame6)], v2[3], hermione[1]);//Display the left images
  } else {//If no key is pressed
    if (idle==0) {//If the character's facing the right, show the right images
      image(rightImages2[0], v2[3], hermione[1]);
    } else if (idle==1) {//If the players facing the left, show the left images
      image(leftImages2[0], v2[3], hermione[1]);
    }
  }
  frame6+=0.1;//Increase the frame image for the right or left images
  if (frame6>4) {//If the last frame image is shown
    frame6=1.0;//Go back to the 1st image, not the 0th
  }
  for (int i=0; i<platx.size(); i++) {
    fill(255);//White rectangles
    noStroke();
    rect(platx.get(i)+offset2, platy.get(i), pw, ph);//To draw the platforms on the screen
  }
}//End drawCharacters2

void moveHermione() {//This is the same function used to make Ron, the first character, move
  if (jump && hermione[1]+hermione[3]==v2[2] && v2[1]==0) {//If the player presses the space bar and if Hermione is on the ground
    v2[1]=jumpSpeed;//Setting the vertical velocity to the jumpSpeed to make Hermione jump
  }
  if (moveRight && hermione[0]<980) {//If the player presses the right arrow key and if Hermione is more than 300 minus the horizontal size of the bg5, 1280
    v2[0]=2;//Move to the right
    idle=0;//Facing the right
    if (v2[3]<540) {//To move the character to the right 2 pixels if the screen is less than 540, 60 minus the right side of the screen  
      v2[3]+=2;
    }
  } else if (moveLeft && hermione[0]>300) {//If the player presses the left arrow key and if Hermione is more than 300 pixels from the left of the screen
    v2[0]=-2;//Move to the left
    idle=1;//Facing the left
    if (v2[3]>30) {//To move the player 2 pixels to the left if Hermione is more than 30 pixels, only if she's less than 300 pixels from the left side of the screen
      v2[3]-=2;
    }
  } else {
    v2[0]=0;//Not moving
  }
  v2[1]+=gravity;//Applying gravity to the jump
  hermione[0]+=v2[0];//Increasing the x-position of the character by the horizontal velocity; moving left or right
}//End moveHermione

void checkGround2() {//So the player doesn't fall out of the screen and to make the player land on a platform

  //Checking if the player is landing on a platform
  for (int i=0; i<platx.size(); i++) {
    // On the left-side of the platform,        On the left-side of the platform, On the surface of the platorm,        //Is falling through the platform 
    if (hermione[0]+hermione[2]>platx.get(i) && hermione[0]<platx.get(i)+pw && hermione[1]+hermione[3]<=platy.get(i) && hermione[1]+hermione[3]+v2[1]>platy.get(i)) {
      v2[2]=platy.get(i);//The player is landing on the platform
      hermione[1]=v2[2]-hermione[3];
      v2[1]=0;//Not jumping
    }
  }

  //Checking if the player is falling off the screen
  hermione[1]+=v2[1];//Increasing the character's y-position by the vertical velocity; jumping up and down
  if ((hermione[1]+hermione[3])>=height-38) {//If the character's y-position is more than 30 pixels from the height of the screen
    v2[1]=0;//Not jumping any more
    v2[2]=height-38;
    hermione[1]=height-hermione[3]-38;//Reseting Hermione's y-position to 30 pixels above the height of the screen
  }
}//End checkGround2

void drawSpells2() {
  for (int m=0; m<sx2.size(); m++) {
    if (sx2.get(m)==v2[3]+50) {//If the character is facing the right, show the right images of the spell
      image(rightspellImages[int(frame7)], sx2.get(m), sy2.get(m));
    } else {//If the character is facing the left, show the left images of the spell
      image(leftspellImages[int(frame7)], sx2.get(m), sy2.get(m));
    }
    frame7+=0.1;
    if (frame7>8) {
      frame7=1.0;
    }
  }
}//end drawSpells2

void addSpell2() {
  if (idle==0) {//Facing the right
    sx2.append(v2[3]+50);
    spellspeed1.append(2);//The spell will move towards the right
  } else {//Facing the left
    sx2.append(v2[3]);
    spellspeed1.append(-2);//The spell will move towards the left
  }
  sy2.append(hermione[1]+20);
}//End addSpell2

void moveSpells2() {
  for (int m=0; m<sx2.size(); m++) {
    sx2.add(m, spellspeed1.get(m));//Moving the spells, depending on whether the character was facing left or right when the 's' key is pressed
  }
}//End moveSpells2

void drawDementors() {
  for (int i=0; i<dementorsx.size(); i++) {
    image(dementors, dementorsx.get(i)+offset2, dementorsy.get(i));//Drawing the dementors at random location from the left side of the screen
  }
}//End drawDementors

void moveDementors() {
  for (int i=0; i<dementorsx.size(); i++) {
    dementorsx.add(i, sdir.get(i));//To move the dementors depending on the random speeds
    if (dementorsx.get(i)>1280 || dementorsx.get(i)<0) {//If a dementor is about to come off the screen
      sdir.set(i, -sdir.get(i));//Moving the dementor in the other direction; this doesn't move all the dementors at once, but moves them one by one
    }
  }
}//End moveDementors

void checkHermioneDementors() {
  for (int i=0; i<dementorsx.size(); i++) {
    int[] dementorsxy={dementorsx.get(i), dementorsy.get(i), 20, 60};
    if (hitBox(hermione, dementorsxy)) {//If Hermione touches a dementor, then she loses a life and the dementor is removed
      lives--;
      dementorsx.remove(i);
      dementorsy.remove(i);
      sdir.remove(i);//Removing the speed of the dementor
    }
  }
}//End checkHermioneDementors

void checkSpellsDementors() {//A nested loop to check collision between a spell and a dementor
  for (int i=0; i<dementorsx.size(); i++) {
    int[] dementorsxy={dementorsx.get(i)+offset2, dementorsy.get(i), 20, 60};
    for (int m=0; m<sx2.size(); m++) {
      int[] spellxy2={sx2.get(m), sy2.get(m), 25, 7};
      if (hitBox(dementorsxy, spellxy2)) {//If a spell touches a dementor, the dementor and spell are removed
        dementorsx.remove(i);
        dementorsy.remove(i);
        sdir.remove(i);//Removing the speed of the dementor
        sx2.remove(m);
        sy2.remove(m);
        spellspeed1.remove(m);//Removing the speed/direction of the spell
        if (spells2<5) {//If the number of spells is less than 5, add another spell
          spells2++;
        }
        break;
      }
    }
  }
}//End checkSpellsDementors

void drawenemyspells() {
  for (int i=0; i<enemyspellsx.size(); i++) {
    image(enemyspells[int(frame8)], enemyspellsx.get(i)+offset2, enemyspellsy.get(i));
    frame8+=0.1;
    if (frame8>8) {
      frame8=1.0;
    }
    enemyspellsy.add(i, 2);
  }
}//End drawenemyspells

void checkHermioneEnemyspells() {
  for (int i=0; i<enemyspellsx.size(); i++) {
    int[] enemyspellsxy={enemyspellsx.get(i), enemyspellsy.get(i), 19, 32};
    if (hitBox(hermione, enemyspellsxy)) {//If Hermione touches one of the 'enemy spells', she loses a life and the enemy spell is removed
      lives--;
      enemyspellsx.remove(i);
      enemyspellsy.remove(i);
    }
  }
}//End checkHermioneEnemyspells

void drawHorcrux2() {
  if (dementorsx.size()==0) {//If all the dementors are gone or killed
    image(horcrux2, 250, y2);//Drawing the second horcrux moving downwards
    y2+=1;
    if (y2>=650) {//If the image is about to fall through the screen, set it's y-coordinate at 650
      y2=650;
    }
    if (mouseIn(250, y2, 50, 70)) {
      if (mousePressed) {//If the player clicks on the horcrux, they are on level 3
        level=3;
      }
    }
  }
}//End drawHorcrux2

int Startlevel3(int x3) {
  background(0);
  x3+=2;//To increase the x position of the text to make it look like it's moving to the right
  textFont(font2);//Displaying the text in the 2nd font
  textSize(20);
  fill(255);//Black text
  text("Get ready for level 3", x3, height/2);//Moving and displaying the text to the right from position (20, 239.5)
  return x3;
}//End Startlevel3

void drawCharacters3() {
  for (int i=0; i<lives; i++) {//Drawing the number of lives; represented by hearts
    image(hearts, 50+i*30, 27);
  }
  for (int i=0; i<spells3; i++) {//Drawing the number of spells left
    image(wand, 425+i*30, 27);
  }
  if (moveRight) {//If the player presses the right key
    image(rightImages3[int(frame9)], v3[3], harry[1]);//Display the right images and move them towards the right with horizontal velocity
  } else if (moveLeft) {//If the player presses the left key
    image(leftImages3[int(frame9)], v3[3], harry[1]);//Display the left images
  } else {//If no key is pressed
    if (idle==0) {//If the character's facing the right, show the right images
      image(rightImages3[0], v3[3], harry[1]);
    } else if (idle==1) {//If the players facing the left, show the left images
      image(leftImages3[0], v3[3], harry[1]);
    }
  }
  frame9+=0.1;//Increase the frame image for the right or left images
  if (frame9>4) {//If the last frame image is shown
    frame9=1.0;//Go back to the 1st image, not the 0th
  }
}//End drawCharacters3

void moveHarry() {//This is the same function used to make Ron, the first character, and Hermione, the second character, move
  if (jump && harry[1]+harry[3]+25==v3[2] && v3[1]==0) {//If the player presses the space bar while Harry is on the ground
    v3[1]=jumpSpeed;//Setting the vertical velocity to the jumpSpeed to make Harry jump up
  }
  if (moveRight && harry[0]<2004) {//If the player presses the right arrow key and if Harry is more than 300 minus the horizontal size of the bg6, 2304
    v3[0]=2;//Move to the right
    idle=0;//Facing the right
    if (v3[3]<540) {//To move the character to the right 2 pixels if the screen is less than 540, 60 minus the right side of the screen  
      v3[3]+=2;
    }
  } else if (moveLeft && harry[0]>300) {//If the player presses the left arrow key and if Harry is more than 300 pixels from the left of the screen
    v3[0]=-2;//Move to the left
    idle=1;//Facing the left
    if (v3[3]>30) {//To move the player 2 pixels to the left if Harry is more than 30 pixels, only if he's less than 300 pixels from the left side of the screen
      v3[3]-=2;
    }
  } else {
    v3[0]=0;//Is not moving
  }
  v3[1]+=gravity;//Applying gravity to the jump
  harry[0]+=v3[0];//Increasing the x-position of the character by the horizontal velocity so they move left or right
}//End moveHarry

void checkGround3() {
  harry[1]+=v3[1];//Increasing the character's y-position by the vertical velocity; jumping up and down
  if ((harry[1]+harry[3])>=height-25) {//If the character's y-position is more than 25 pixels from the height of the screen
    v3[1]=0;//Not jumping any more
    v3[2]=height;
    harry[1]=height-harry[3]-25;//Reseting Harry's y-position to 25 pixels above the height of the screen
  }
}//End checkGround3

void drawSpells3() {
  for (int m=0; m<sx3.size(); m++) {
    if (sx3.get(m)==v3[3]+50) {//If the character's facing the right, show the right spell images
      image(rightspellImages[int(frame10)], sx3.get(m), sy3.get(m));
    } else {//If the character's facing the left, show the left spell images
      image(leftspellImages[int(frame10)], sx3.get(m), sy3.get(m));
    }
    frame10+=0.1;
    if (frame10>8) {
      frame10=1.0;
    }
  }
}//end drawSpells3

void addSpell3() {
  if (idle==0) {//Facing the right
    sx3.append(v3[3]+50);
    spellspeed2.append(2);//To move the spells towards the right
  } else {//Facing the left
    sx3.append(v3[3]);
    spellspeed2.append(-2);//To move the spells towards the left
  }
  sy3.append(harry[1]+20);
}//End addSpell3

void moveSpells3() {
  for (int m=0; m<sx3.size(); m++) {
    sx3.add(m, spellspeed2.get(m));//Moving the spells based on if the character was facing the right or left when pressing the 's' key
  }
}//End moveSpells3

void drawVoldemort() {
  if (vmoveRight) {//If Voldemort's facing the right, show his right images
    image(voldemortrightimages[int(frame11)], vx+offset3, 705);
    vright=true;
    if (frameCount%200==0) {//To shoot spells at regular intervals
      vspellsx.append(vx+offset3);
      vspellsy.append(720);
      vspellspeed.append(4);//The spell will move right
    }
  }
  if (vmoveLeft) {//If Voldemort's facing the left, show his left images
    image(voldemortleftimages[int(frame11)], vx+offset3, 705);//Display the left images and move them towards the left with horizontal velocity
    vleft=true;
    if (frameCount%200==0) {//To shoot spells at regular intervals
      vspellsx.append(vx+offset3);
      vspellsy.append(720);
      vspellspeed.append(-4);//The spell will move left
    }
  }
  vx+=vdir;//Moving Voldemort to the left
  if (vx<=0) {//If Voldemort's about to get off the left side of the screen
    vdir=-vdir;//Move in the other direction
    vmoveRight=true;
    vmoveLeft=false;
  }
  if (vx>=1260) {//If Voldemort's about to get off the right side of the screen
    vdir=-vdir;//Move in the other direction
    vmoveRight=false;
    vmoveLeft=true;
  }
  frame11+=0.1;
  if (frame11>3) {
    frame11=1.0;
  }
  fill(255);//White rectangle
  rect(vx+offset3+20, 670, health*5, 10);//Drawing the health bar for Voldemort above his head
}//End drawVoldemort

void checkVoldemortHarry() {
  int[] voldemortxy={vx+offset3, 705, 32, 32};
  if (hitBox(harry, voldemortxy)) {//If Harry touches Voldemort, he loses a life
    lives--;
    vx=int(random(10, 1200));//Voldemort reappears at a random x position on the screen
  }
}//End checkVoldemortHarry

void drawvspells() {
  for (int m=0; m<vspellsx.size(); m++) {
    if (vright) {//Facing the right
      image(vrightspells[int(frame12)], vspellsx.get(m), vspellsy.get(m));//Drawing Voldemort's right spells
    }
    if (vleft) {//Facing the left
      image(vleftspells[int(frame12)], vspellsx.get(m), vspellsy.get(m));//Drawing Voldemort's left spells
    }
  }
  frame12+=0.1;
  if (frame12>8) {
    frame12=1.0;
  }
}//End drawvspells

void movevspells() {
  for (int m=0; m<vspellsx.size(); m++) {
    vspellsx.add(m, vspellspeed.get(m));//Moving Voldemort's spells based on whether he's facing the right or left
  }
}//End movevspells

void checkvspellsHarry() {
  for (int m=0; m<vspellsx.size(); m++) {
    int[] vspellsxy={vspellsx.get(m), vspellsy.get(m), 25, 7};
    if (hitBox(harry, vspellsxy)) {//If Harry touches Voldemort's spells, he loses a life and the spell is removed
      lives--;
      vspellsx.remove(m);
      vspellsy.remove(m);
      vspellspeed.remove(m);//Removing the speed/direction of the spell
    }
  }
}//End checkvspellsHarry

void checkspellVoldemort() {
  for (int m=0; m<sx3.size(); m++) {
    int[] spellsxy={sx3.get(m), sy3.get(m), 25, 7};
    int[] voldemortxy={vx+offset3, 705, 32, 32};
    if (hitBox(spellsxy, voldemortxy)) {//If Harry's spell touches Voldemort, remove the spell 
      sx3.remove(m);
      sy3.remove(m);
      spellspeed2.remove(m);//Removing the speed/direction of the spell
      vx=int(random(10, 1200));//Reappearing Voldemort at a random x-position on the screen
      health--;//Decrease Voldemort's health by 1
      if (spells3<5) {//If the number of spells is less than 5
        spells3++;//Add a spell
      }
    }
  }
}//End checkspellVoldemort

void youWin() {
  if (health==0) {//If Voldemort's health is 0, the player wins
    surface.setSize(681, 383);//The size of the new background
    image(bg4, 0, 0);
    fill(255);//White text
    textFont(font);
    text("You Won!", 250, 196.5);
  }
}//End youWin

void checkGameOver() {
  if (lives<=0) {//If the player dies and has no more lives left, they lose
    gameMode=4;//Means the game is over
  }
}//End checkGameOver


void showGameOver() {
  textFont(font);
  fill(255);//White text
  image(gameoverbg, 0, -150);
  text("Game Over", 180, 240);

  textSize(15);
  fill(255);//White text
  text("Back", 50, 30);//To create a back to main menu button
  if (mouseIn(45, 10, 60, 30)) {//If the player is hovering over the "Back" text
    //Display the "Back" text in black 
    fill(0);
    text("Back", 50, 30);
    if (mousePressed) {//If the player clicks on the "Back" text
      surface.setSize(500, 334);//Reset the background to the size of bg
      gameMode=0;//Go back to the game menu
    }
  }
  checkRestartLevel1();//So the player can restart the game if they lose
}//End showGameOver

void checkRestartLevel1() {
  textAlign(LEFT);
  textSize(15);
  fill(255);
  text("Restart Level 1", 150, 30);

  if (mouseIn(150, 10, 120, 30)) {//"back to menu"
    fill(0);
    text("Restart Level 1", 150, 30);
    if (mousePressed) {
      gameMode=5;
    }
  }
}//End checkRestartLevel1

void restartLevel1() {
  //Mr Macanovik helped me create the restart function; he told me I had to empty the lists first and use a new game mode
  lives=10;
  spells=5;
  ex=new IntList();//This removes all the spiders and creates a new list
  for (int i=0; i<numSpiders; i++) {
    ex.append(round(random(700, 4000)));//Random x positions for the spiders off the right side of the screen
  }
  snakex=new IntList();//This removes all the snakes and creates a new list 
  for (int i=0; i<numSnakes; i++) {
    snakex.append(round(random(700, 5000)));//Random x positions for the snakes off the right side of the screen
  }
  //This removes all the platforms in the previous attempt and creates new platforms
  platx=new IntList();
  platy=new IntList();
  for (int i=0; i<numplatforms; i++) {
    platx.append(int(random(100, 1180)));//The screen size in level 2 is 600 by 720, while the background is 1280 by 720
    platy.append(int(random(40, 680)));
  }
  //This removes all the dementors and creates new lists
  dementorsx=new IntList();
  dementorsy=new IntList();
  for (int i=0; i<numdementors; i++) {
    //Creating random x and y-coordinates for the dementors in level 2
    dementorsx.append(int(random(50, 1230)));
    dementorsy.append(int(random(0, 550)));
  }
  sdir=new IntList();//New speeds for the dementors
  for (int i=0; i<numdementors; i++) {
    sdir.append(int(random(1, 2)));//Creating random speeds for the dementors in level 2
  }
  //This removes all the enemy spells and creates new lists
  enemyspellsx=new IntList();
  enemyspellsy=new IntList();
  for (int i=0; i<numenemyspells; i++) {
    //Creating random x and y-coordinates for the enemy spells that fly down in level 2
    enemyspellsx.append(int(random(10, 1270)));
    enemyspellsy.append(int(random(-4000, 0)));
  }
  yhorcrux1=new IntList();//This removes the horcruxes from the first attempt at level 1 and level 2
  yhorcrux2=new IntList();
  gameMode=1;
  level=1;
  ron[0]=300;
  ron[1]=409;
  vx=1200;
}//End restartLevel1

void keyPressed() {//If keys are pressed
  if (key==CODED && keyCode==RIGHT) {
    moveRight=true;//Move to the right
  }
  if (key==CODED && keyCode==LEFT) {
    moveLeft=true;//Move to the left
  }
  if (key==32) {
    jump=true;//Jump
  }
  if ((key==83 || key==115) && canShoot && ron[1]==height-ron[3]-30 && v1[1]==0 && spells>0) {//To shoot spells in level 1
    addSpell();
    spells--;
    canShoot=false;
  }
  if ((key==83 || key==115) && canShoot && hermione[1]==v2[2]-hermione[3] && v2[1]==0 && spells2>0) {//To shoot spells in level 2
    addSpell2();
    spells2--;
    canShoot=false;
  }
  if ((key==83 || key==115) && canShoot && harry[1]==height-harry[3]-25 && v3[1]==0 && spells3>0) {//To shoot spells in level 3
    addSpell3();
    spells3--;
    canShoot=false;
  }
}//End keyPressed

void keyReleased() {//If keys are released, nothing is happening
  if (key==CODED && keyCode==RIGHT) {
    moveRight=false;
  }
  if (key==CODED && keyCode==LEFT) {
    moveLeft=false;
  }
  if (key==32) {
    jump=false;
  }
  if (key==83 || key==115) {
    canShoot=true;
  }
}//End keyReleased 

//If the mouse of the player is inside the given coordinates, the function returns true
boolean mouseIn(int left, int top, int w, int h) {
  return (mouseX > left && mouseX < left+w && mouseY > top && mouseY < top+h);
}//end mouseIn

boolean hitBox(int[] r1, int[] r2) {
  int r1Bot, r1Right;
  int r2Bot, r2Right;
  r1Right=r1[0]+r1[2];//the "right" side of the first rectangle
  r1Bot=r1[1]+r1[3];//the "bottom" of the first rectangle

  r2Right=r2[0]+r2[2];//the "right" side of the second rectangle
  r2Bot=r2[1]+r2[3];//the "bottom" of the second rectangle

  return (r1Right > r2[0] && r1[0] < r2Right && r1Bot > r2[1] && r1[1] < r2Bot);
}//End hitBox
