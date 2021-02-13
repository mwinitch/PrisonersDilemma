import processing.serial.*;

Serial myPort;
String val;

// Variables used for timing
int time;
int timing = 10;
int updateTime;

// values holds the serialized values
String[] values;
String again = "";

//States for the machine
boolean start = true;
boolean lose = false;
boolean player1 = false;
boolean player2 = false;
boolean terminated;

void setup()
{
  size(200, 200);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  time = millis();
  updateTime = millis();
  text(timing, 20, 20);
  delay(100);
  if (myPort.available() > 0) {
    val = myPort.readString().trim();
    values = val.split(" ");
  }
  again = String.valueOf(values[4].charAt(0));
}

void draw()
{
  background(255);
  
  // Get serial values
  if (myPort.available() > 0) {
    val = myPort.readString().trim();
    values = val.split(" ");
  }
  
  // Checks if game is over
  if (timing <= 0) {
    endingDisplay(values[4]);
    return;
  }
  
  // Calls the state machine on the button clicks
  machine(values[2], values[3]);
  updateTime(Integer.parseInt(values[0]));
  size(200, 200);
  
  // Deducts a second every second
  if (millis() - time >= 1000) {
    timing -= 1;
    time = millis();
  }
  fill(0);
  text(timing, 20, 20);
}


void endingDisplay(String a) {
  // If the reset switch is used
  if (!a.equals(again)) {
    again = String.valueOf(a.charAt(0));;
    timing = 10;
    start = true;
    lose = false;
    player1 = false;
    player2 = false;
    
  }
  else if (start) {
    background(0, 0, 255);
  }
  else if (lose) {
    background(255, 0, 0);
  }
  else if (player1) {
    background(255, 255, 0);
  }
  else if (player2) {
    background(0, 255, 0);
  }
}

// If the joystick updates the time
void updateTime(int value)
{
    if (millis() - updateTime <= 200) {
      return; 
    }
    updateTime = millis();
    if (value == 0) {
     timing += 1;
     delay(10);
   }
   else if (value == 4095) {
     timing -= 1;
     delay(10);
   }
}

// Using the button values and current states, this updates the player states
void machine(String a, String b) {
    if (a.equals("1") && b.equals("1")) {
      return; 
    }
    else if (a.equals("0") && b.equals("0")) {
      System.out.println("Reset");
      start = true;
      lose = false;
      player1 = false;
      player2 = false;
    }
    else if (lose) {
      return;
    }
    else if (a.equals("0")) {
       start = false;
       player1 = true;
       if (player2) {
          lose = true;
          player1 = false;
          System.out.println("Lose 1");
       }
       player2 = false;
       System.out.println("Player 1");
    }
    else if (b.equals("0")) {
       start = false;
       player2 = true;
       if (player1) {
          lose = true;
          player2 = false;
          System.out.println("Lose 2");
       }
       player1 = false;
       System.out.println("Player 2");
    }
}
