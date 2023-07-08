/***************************************
 ** collegeSimFINAL
 ** The Struggle : A Freshman Among Us
 ** Team Binary Beasts
 ** Jannat Gill, Samuel Lee, Syed Husain, Yabi Megersa
 ** 12/4/2020
 ** Team Collaboration
 ** 
 ** completed college first semester simulation 
 ** includes stat tracking, four activities and a game over condition
 ** 
 ****************************************/

PImage campusPic;
PImage deskPic;
PImage study;
PImage food;
PImage leisure;
PImage dorm;

//stat variables
int happiness = int(random(100, 200));
int studying = 100;
int health = int(random(100, 200));
int hunger = int(random(100, 200));
final int MAX_HAPPINESS = 978;
final int MAX_STUDYING = 978;
final int MAX_HEALTH = 978;
final int MAX_HUNGER = 978;

//activity variables
boolean gameOver = false;
boolean inClass = false;
boolean inStudy = false;
boolean inEat = false;
boolean inLeisure = false;
boolean inSleep = false;
boolean overWorld = true;
boolean drawBackground = true;

//study variables
int noteAmount = 0;
int noteMax = 2000;
int vocabMax = 15;
String definitions[];
int vocabSelected[] = new int[] {-1, -1, -1, -1};
Definitions[] vocab = new Definitions[15];
boolean quiz = false;
int question = int(random(0, 4));
boolean clicked = false;
int answer = -1;

//time tracking variables
float time = millis();
float day = 0;
float doPerDay = 5;

//jannat variables and related
float avatarX = 5;
float avatarY = 780;
float xDelta = 2;
int boundY = 550;
PImage bg;
PImage avaL;
PImage avaR;
boolean faceRight = true;

//jannat doEat things
PImage burger;
float burgersX[];
float burgersY[];
final float BURGERX_SIZE = 15;
final float BURGERY_SIZE = 20;
int numberOfburgers = 10;
int numOfburgRemaining = numberOfburgers; 
int points = 0; 

//Syed variables
float building1X = 330;
float building2X = 685;
PFont f;
String typing = ""; // Variable to store text currently being typed
String saved = ""; // Variable to store saved text when return is hit
int xPos;                      
int speed = 1;                 
int xDir = 1;                
int score = 1;                  
int lives = 5;           
boolean lost = false;


/* function: setup sets the size of the game and framerate. 
 ** Also loads some images that are used later
 */
void setup() {
  bg = loadImage("secondback_original.png");
  deskPic = loadImage("desk1.png");
  food = loadImage("sprite_0.png");
  study = loadImage("sprite_0_2.png");
  leisure = loadImage("sprite_0_3.png");
  dorm = loadImage("sprite_0_4.png");
  size(1000, 1000);
  frameRate(60);
}

/* function: draws and calls different activities
 ** 
 ** input: 
 ** output: displays current activity
 */
void draw() {
  if (gameOver == true) {
    youWin();
  } else if (overWorld == true) {
    imageMode(CORNER);
    background(bg);
    checkWeeks();
    printStats();
    drawBuildings();
    drawText();
    moveAvatar();
    enterBuilding();
  } else if (inClass == true) {
    if (drawBackground) {
      noteAmount = 0;
      time = millis();
      image(deskPic, 0, 0);
      drawBackground = false;
    }
    doClass();
  } else if (inStudy == true) {
    if (drawBackground) {
      time = millis();
      answer = -1;
      question = int(random(0, 4));
      background(0);
      assignVocabWords();
      studyText();
      drawBackground = false;
    }
    if (quiz == false) {
      doStudy();
    } else if (quiz == true) {
      studyQuiz();
    }
  } else if (inLeisure == true) {
    if (drawBackground) {
      smooth();
      xPos=width/2;              
      fill(255, 255, 0);
      textSize(25); 
      drawBackground = false;
    }
    Liesure();
  } else if (inEat == true) {
    if (drawBackground) {
      assignFoodPositions();
      drawBackground = false;
    }
    doEat();
  } else if (inSleep == true) {
  }
}



//Syed's Functions

/* function: checks if avatar is within building parameters
 ** 
 ** input: 
 ** output: displays text and calls inBuilding 
 */
void enterBuilding() {
  if ((avatarX <= 380) && (avatarX >= 250)) {
    fill(0);
    textSize(15);
    text("Press p to Attend Class", 290, 690); //go to eat
    inBuilding(1);
  }
  if ((avatarX <= 650) && (avatarX >= 500)) {
    fill(0);
    textSize(15);
    text("Press w to Relax", 560, 690); // go to class
    inBuilding(2);
  }
  if ((avatarX <= 120) && (avatarX >= 1)) {
    fill(0);
    textSize(15);
    text("Press k to Enter Cafeteria", 30, 690); //go to eat
    inBuilding(0);
  }
  if ((avatarX <= 900 ) && (avatarX >= 725)) {
    fill(0);
    textSize(15);
    text("Press s to Study", 810, 690); // go to class
    inBuilding(3);
  }
}

/* function: sends player to activity
 ** 
 ** input: keyboard button and which building is entered
 ** output: changes activity variables
 */
void inBuilding(int toDo) {
  if (toDo == 0) {
    if (key == 'k') {
      inEat = true;
      overWorld = false;
    }
  }
  if (toDo == 1) {
    if (key == 'p') {
      inClass = true;
      overWorld = false;
    }
  }
  if (toDo == 2) {
    if (key == 'w') {
      inLeisure = true;
      overWorld = false;
    }
  }
  if (toDo == 3) {
    if (key == 's') {
      inStudy = true;
      overWorld = false;
    }
  }
}



//Syed Main leisure functions

/* function: calls the display leisure game
 ** 
 ** input: none
 ** output: game
 */
void Liesure() {
  videogame();
}


/* function: displays game
 ** 
 ** input: none
 ** output: game
 */
void videogame() {
  background (0); 
  ellipse(xPos, height/2, 40, 40); 
  xPos=xPos+(speed*xDir);                 
  if (xPos > width-50 || xPos<50)        
  {
    xDir=-xDir;
  }
  text("score = "+score, 10, 50);
  text("lives = "+lives, width-200, 50);       
  if (lives <= 0)                                  
  {
    activityOver(2, false);
  }
  if (score >= 50)                                  
  {
    activityOver(2, true);
  }
}


//jannat functions

/* function: makes avatar
 ** 
 ** input: none
 ** output: an avatar facing left/right
 */
void drawAvatar() {
  if (faceRight == true) {
    avaL = loadImage("avatar.png");
    image(avaL, avatarX, avatarY);
  }
  if (faceRight == false) {
    avaR = loadImage("avatar1.png");
    image(avaR, avatarX, avatarY);
  }
}

/* function: moves avatar across screen
 ** 
 ** input: keyboard arrow keys
 ** output: changes coordinates
 */
void moveAvatar() {
  if (keyPressed == true) {
    if (keyCode == UP) {
      day += .2;
    }
    if (keyCode == DOWN) {
      day -= .2;
    } else if (keyCode == LEFT) {
      faceRight = false;
      drawAvatar();
      avatarX -= xDelta;
    } else if (keyCode == RIGHT) {
      faceRight = true;
      drawAvatar();
      avatarX += xDelta;
    }
  } else {
    drawAvatar();
  }
  wrapAvatar();
}


/* function: Wraps avatar from one end to the opposite end of screen
 ** 
 ** input: none
 ** output: changes avatar coordinates
 */
void wrapAvatar() {
  if (avatarX > width - 128/2) {
    avatarX = 0 - 128/2;
  } 
  if (avatarX < 0 - 128/2) {
    avatarX = width - 128/2;
  }
}

//jannat eat functions

/* function: calls other eat functions
 ** 
 ** input: none
 ** output: eat minigame
 */
void doEat() {
  background(0);
  drawFood();
  endEatGame();
}

/* function: assigns coordinates for eggs used in game
 ** 
 ** input: none
 ** output: coordinates for a number of eggs
 */
void assignFoodPositions() {
  print("Burger assigned");
  burgersX = new float [numberOfburgers];
  burgersY = new float [numberOfburgers];
  for (int i = 0; i <= (numberOfburgers - 1); i++) {
    burgersX[i] = random(200,700);
    burgersY[i] = random(200, 700);
  }
}

/* function: draws egg(s)
 ** 
 ** input: none
 ** output: eggs
 */
void drawFood() {
  for (int i = 0; i <= (numberOfburgers - 1); i++) {
    burger = loadImage("burger.png");
    imageMode(CENTER);
    image(burger, burgersX[i], burgersY[i]);
  }
}

/* function: keeps track of points and checks for minigame over condition
 ** 
 ** input: none
 ** output: calls other function to end game
 */
void endEatGame () {
  textSize(30);
  fill(255, 0, 255); 
  textAlign(LEFT);
  text("Burgers consumed: " + points, 1, 30);
  if (numOfburgRemaining == 0) {
    activityOver(1, true);
  }
}

/* function: moves eggs off screen if clicked 
 ** 
 ** input: mouse buttons
 ** output: egg begones
 */
void mousePressed() {
  if (inEat == true) {
    for (int i = 0; i <= (numberOfburgers - 1); i++) {
      float dist = sqrt((burgersX[i] - mouseX) * (burgersX[i] - mouseX) + ( burgersY[i] - mouseY) * ( burgersY[i] - mouseY));
      println(dist);
     if (dist <= 35) {
         burgersX[i] = -100;
         burgersY[i] = -100;
        points = points + 1; 
        numOfburgRemaining --;
      }
    }
  } else if (inLeisure) {
    if (dist(mouseX, mouseY, xPos, 500)<=50) {
      score=score+speed;                          
      speed=speed+1;
    } else {
      if (speed<1)                                
      {
        speed=speed-1;
      }
      lives=lives-1;
    }
    if (lost==true)                                
    {
      speed=1;                                    
      lives=5;
      score=0;
      xPos=width/2;
      xDir=1;
      lost=false;
      loop();
    }
  }
}


//yabi functions

/* function: displays game over screen
 ** 
 ** input: none
 ** output: game over screen with text
 */
void youWin() {
  noStroke();
  background(0);
  textAlign(CENTER);
  if ((happiness >= MAX_HAPPINESS/3) && (studying >= MAX_STUDYING/3) && (health >= MAX_HEALTH/3) && (hunger >= MAX_HUNGER/3)) {
    textSize(45);
    fill(255);
    text("You finished your first semester being: ", width/2, height/3);
    if ((happiness >= MAX_HAPPINESS/2) && (happiness < 2*MAX_HAPPINESS/3)) { //looks at happiness stat
      fill(100, 175, 100);
      text("somewhat happy", width/2, height/2);
    } else if ((happiness >= 2*MAX_HAPPINESS/3) && (happiness < 4*MAX_HAPPINESS/5)) {
      fill(50, 200, 50);
      text("pretty happy", width/2, height/2);
    } else if (happiness >= 4*MAX_HAPPINESS/5) {
      fill(0, 250, 0);
      text("very happy :))", width/2, height/2);
    }
    if ((studying >= MAX_STUDYING/2) && (studying < 2*MAX_STUDYING/3)) { //looks at studying stat
      fill(100, 175, 100);
      text("with passable grades", width/2, 2*height/3);
    } else if ((studying >= 2*MAX_STUDYING/3)  && (studying < 4*MAX_STUDYING/5)) {
      fill(50, 200, 50);
      text("with pretty good", width/2, 2*height/3);
    } else if (studying >= 4*MAX_STUDYING/5) {
      fill(0, 250, 0);
      text("with incredible grades", width/2, 2*height/3);
    }
  } else {
    fill(250, 50, 50);
    textSize(50);
    text("You finished your first semester", width/2, height/2);
    text("unsuccessfully.", width/2, 3*height/5);
    textSize(25);
    text("(try to keep your 3 stats high while frequently attending class)", width/2, 7*height/8);
  }
}



/* function: displays text above buildings, stat bars and time
 ** 
 ** input: none
 ** output: text
 */
void drawText() {
  textAlign(CENTER);
  textSize(20);
  fill(0);
  text("FOOD ROOM", 120, 650);
  text("CLASSROOM", 370, 650);
  text("LEISURE ROOM", 620, 650);
  text("DORM ROOM", 870, 650);
  fill(255);
  textAlign(LEFT);
  textSize(12);
  text("health", 10, 100/3);
  text("happiness", 10, 200/3);
  text("hunger", 10, 300/3);
  int dayNum = int(day) ;
  text("day " + dayNum + ", week " + (dayNum/7), 10, 140);
}


/* function: draws buildings
 ** 
 ** input: none
 ** output: buildings
 */
void drawBuildings() {
  rectMode(CENTER);
  fill(255);
  image(food, 20, 700);
  image(study, 270, 700);
  image(leisure, 520, 700);
  image(dorm, 770, 700);
}

/* function: displays stats as a bar
 ** 
 ** input: none
 ** output: stat bars
 */
void printStats() {
  noStroke();
  rectMode(CORNER);
  fill(0);
  rect(0, 0, width, 150, 10);
  for (int i = 100; i <= 300; i += 100) {
    stroke(255);
    rect(10, i/3, (width - 20), 20);
  }
  fill(255);
  rect(10, 100/3, health, 20);
  rect(10, 200/3, happiness, 20);
  rect(10, 300/3, hunger, 20);
}

/* function: adds/subtracts stats based off of input
 ** 
 ** input: which stat to change and how (+/-)
 ** output: stat variable changes
 */
void changeStats(int stat) { //stats are capped at MAX_
  int delta = int(random(1, 10)); //generates random number to either add or subtract
  if (health < MAX_HEALTH) {
    switch (stat) {
    case 0:
      health += delta;
      break;
    case 1:
      health -= delta;
      break;
    }
  }
  if (hunger < MAX_HUNGER) {  //hunger is changed 
    switch (stat) {
    case 2:
      hunger += 5*delta;
      break;
    case 3:
      hunger -= delta;
      break;
    }
  }
  if (happiness < MAX_HAPPINESS) {
    switch (stat) {
    case 4:
      happiness += delta;
      break;
    case 5:
      happiness -= delta;
      break;
    }
  }
  if (studying < MAX_STUDYING) {
    switch (stat) {
    case 6:
      studying += delta;
      break;
    case 7:
      studying -= delta;
      break;
    }
  }
  println("stat changed by " + delta);
}

/* function: checks if stats fall to or below 0
 ** 
 ** input: none
 ** output: changes activity variables
 */
void checkStats() {
  if ((hunger <= 0) || (happiness <= 0) || (health <= 0) || (studying <= 0)) {
    gameOver = true;
  }
}


/* function: calls timer 
 ** 
 ** input: none
 ** output: timer
 */
void doStudy() { 
  screenTimer();
}


/* function: displays words and definitions
 ** 
 ** input: none
 ** output: w o r d s
 */
void studyText() {
  textSize(20);
  textAlign(CENTER);
  text("memorize these four words", width/2, height/2);
  for (int i = 0; i <= 3; i++) { 
    textAlign(LEFT);
    fill(random(150, 220), random(150, 220), random(150, 220));
    text(vocab[vocabSelected[i]].getWord(), 10, (i * 250) +100);
    textAlign(RIGHT);
    text(vocab[vocabSelected[i]].getDef(), width-10, (i * 250) + 100);
  }
}

/* function: assigns variables a word and definition
 ** 
 ** input: none
 ** output: stat bars
 */
void assignVocabWords() {
  Definitions word1 = new Definitions("application", "program dedicated to a specific task");
  Definitions word2 = new Definitions("hieroglyphic", "designating or pertaining to a pictographic script");
  Definitions word3 = new Definitions("peripheral", "equipment linked to a computer");
  Definitions word4 = new Definitions("coadjutor", "an assistant to a bishop");
  Definitions word5 = new Definitions("valediction", "a farewell oration");
  Definitions word6 = new Definitions("Adversity", "a state or instance of serious or continued difficulty or misfortune.");
  Definitions word7 = new Definitions("bit", "binary digit, the basic binary unit for storing data, either 0 or 1");
  Definitions word8 = new Definitions("tokens", "The basic component of source code");
  Definitions word9 = new Definitions("lexeme", "A sequence of alphanumeric characters in a token");
  Definitions word10 = new Definitions("syntax", "the rules governing the structure of a programming language");
  Definitions word11 = new Definitions("source code", "the text of a program");
  Definitions word12 = new Definitions("edifice", "a large, elaborate structure; an imposing building");
  Definitions word13 = new Definitions("physignomies", "facial feature or expression");
  Definitions word14 = new Definitions("visage", "the appearance conveyed by a person's face");
  Definitions word15 = new Definitions("efficacy", "power to produce desired effect");
  vocab = new Definitions[] {word1, word2, word3, word4, word5, word6, word7, word8, word9, word10, word11, word12, word13, word14, word15};
  for (int i = 0; i <= 3; i++) {
    boolean dupe = false;
    int x = int(random(0, vocabMax));  
    for (int w = 0; w <= 3; w++) {
      if (vocabSelected[w] == x) {
        i--;
        dupe = true;
      }
    }
    if (dupe == false) {
      vocabSelected[i] = x;
    }
  }
}

/* function: calls display quiz things
 ** 
 ** input: none
 ** output: quiz
 */
void studyQuiz() {
  background(0);
  quizText();
  quizButtons();
  mouseHover();
  answerCheck();
}

/* function: displays question
 ** 
 ** input: none
 ** output: words on screen
 */
void quizText() {
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text("what does the word '" + vocab[vocabSelected[question]].getWord() + "' mean?", width/2, height/4);
  for (int i = 0; i <= 3; i++) {
    textAlign(LEFT);
    textSize(20);
    text(vocab[vocabSelected[i]].getDef(), 85, (i * 150) + 430);
  }
}

/* function: checks what answer player chooses
 ** 
 ** input: none
 ** output: n/a
 */
void mouseHover() {
  for (int i = 2; i <= 5; i++) {
    float dist = sqrt((40 - mouseX) * (40 - mouseX) + (((i * 150) + 125) - mouseY) * (((i * 150) + 125) - mouseY));
    if (dist <= 20) {
      if ((mouseY >= (2 * 150) + 105) && (mouseY <= (2 * 150) + 145)) {
        answer = 0;
      } else if ((mouseY >= (3 * 150) + 105) && (mouseY <= (3 * 150) + 145)) {
        answer = 1;
      } else if ((mouseY >= (4 * 150) + 105) && (mouseY <= (4 * 150) + 145)) {
        answer = 2;
      } else if ((mouseY >= (5 * 150) + 105) && (mouseY <= (5 * 150) + 145)) {
        answer = 3;
      }
    }
  }
}

/* function: checks answer if correct
 ** 
 ** input: none
 ** output: none
 */
void answerCheck() {
  if ((mousePressed) || (clicked)) {
    clicked = true;
    if (answer == question) {
      activityOver(3, true);
    } else {
      activityOver(3, false);
    }
  }
}


/* function: displays buttons
 ** 
 ** input: none
 ** output: circles
 */
void quizButtons() {
  shapeMode(CENTER);
  for (int i = 2; i <= 5; i++) {

    fill(255);

    circle(40, (i * 150) + 125, 40);
  }
}


/* function: draws a line where mouse is dragged during game
 ** 
 ** input: mouse button and movement
 ** output: line
 */
void mouseDragged() {
  if (inClass == true) {
    fill(0);
    noStroke();    
    circle(mouseX, mouseY, 5);
    noteAmount += 1;
  }
}

/* function: calls other functions for class minigame
 ** 
 ** input: none
 ** output: class
 */
void doClass() {
  classTutorial();
  screenTimer();
  classCheck();
}

/* function: displays text during class minigame
 ** 
 ** input: none
 ** output: text
 */
void classTutorial() {
  textSize(32);
  textAlign(CENTER);
  text("take notes by dragging the mouse", width/2, height/4);
  fill(0);
  textSize(15);
  textAlign(LEFT);
  text("time remaining", 0, 35);
}

/* function: checks for class minigame gameover condition
 ** 
 ** input: none
 ** output: calls the end of game functions
 */
void classCheck() {
  if (noteAmount >= noteMax) {
    activityOver(0, true);
  }
}

/* function: displays a shrinking rectangle
 ** 
 ** input: none
 ** output: rectangle
 */
void screenTimer() {
  noStroke();
  rectMode(CORNER);
  fill(255);
  rect(0, 0, width, 20);
  fill(0);
  rect(0, 0, (width - (millis() - time)/10), 20);
  if (millis() >=  time + 10000) {
    if (inClass) {
      activityOver(0, false);
    } else if (inStudy) {
      quiz = true;
    }
  }
}

/* function: changes stats 
 ** 
 ** input: none
 ** output: stat changes
 */
void studyOver(boolean win) {
  if (win == true) {
    changeStats(3);
    changeStats(6);
  }
  if (win == false) {
    changeStats(5);
    changeStats(7);
  }
}

/* function: changes stat variables
 ** 
 ** input: whether win or loss
 ** output: calls change stat function
 */
void classOver(boolean win) {
  if (win == true) {
    changeStats(3);
    changeStats(6);
  }
  if (win == false) {
    changeStats(5);
    changeStats(7);
  }
}

/* function: calls change stat function
 ** 
 ** input: none
 ** output: callsl change stat function
 */
void eatOver() {
  changeStats(2);
  changeStats(4);
}

/* function: resets game back to main menu and changes stats
 ** 
 ** input: which task, win or lose
 ** output: calls ___Over functions and resets things
 */
void activityOver(int task, boolean win) {
  background(0);
  textSize(32);
  textAlign(CENTER);
  fill(204, 255, 233);
  text("activity over", (width/2), (height/3));
  if (win == true) {
    text("you have successfully completed the task", (width/2), (height/2));
  }
  if (win == false) {
    text("you have unsuccessfully completed the task", (width/2), (height/2));
  }
  text("press 'control' to exit", (width/2), (3*height/4));
  if (keyPressed == true) {
    println("keypressed");
    if (keyCode == CONTROL) {
      if (task == 0) {
        if (win == true) { //class over win
          classOver(true);
        }
        if (win == false) { //class over lose 
          classOver(false);
        }
        drawBackground = true;
      } else if (task == 1) { //eat over
        eatOver();
        numOfburgRemaining = numberOfburgers;
        points = 0;
        drawBackground = true;
      }    
      if (task == 2) {
        if (win == true) {
          changeStats(4);
        } else if (win == false) {
          changeStats(5);
        }
        score = 1;
        speed=1;                 
        xDir=1;                
        score=1;                  
        lives=5;
        drawBackground = true;
      } else if (task == 3) {
        if (win == true) { //class over win
          studyOver(true);
        }
        if (win == false) { //class over lose 
          studyOver(false);
        }
        drawBackground = true;
      }
      overWorld = true;
      inClass = false;
      inEat = false;
      inStudy = false;
      quiz = false;
      clicked = false;
      inLeisure= false;
    }
    day += 1/doPerDay;
    changeStats(3);
    println("day added, day = " + day);
  }
  avatarX = 5;
  avatarY = 780;
}

/* function: checks for how many days have passed
 ** 
 ** input: none
 ** output: changes activity variables
 */
void checkWeeks() {
  if (int(day/7) == 15) {
    gameOver = true;
  }
}
