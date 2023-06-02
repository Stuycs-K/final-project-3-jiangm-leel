import java.util.*;
import java.util.Random;
int STEP = 1;
String STEP_1;
String STEP_2;
String[] POEM;
int[] POSITIONS;
String[][] GRID;
int[] SECRET;
int[] INDICATOR;
String[] aINDICATOR = new String[200];
String[] CHECK = new String[200];
String ENCRYPTED;

void setup(){
  size(800,800);
  background(255);
  String message = loadStrings("message.txt")[0].toString();
  STEP_1 = message;
  String secretNum = loadStrings("secretNum.txt")[0];
  int[] secret = new int[5];
  SECRET = secret;
  //{5,8,2,6,5};
  for(int i = 0; i < secretNum.length(); i++){
    secret[i] = int(secretNum.substring(i, i+1));
    print(secret[i]);
  }
  println();
  Random rand = new Random();
  // Clean up message string
  message = message.replaceAll("\\s", "");
  message = message.replaceAll("\\.", "STOP");
  //System.out.println(message);
  
  String callsign = "";
  for (int i = 0; i < 3; i++){
    String letter = Character.toString((char) int(random(65, 91)));
    callsign = callsign + letter;
  }
   
  //add extra letters to back and front
  //String callsign = "UXV";
  message = message + callsign;
  //println(callsign);
  
  String extra = "";
  for (int i = 0; i < 5 - message.length()%5; i++){
    String letter = Character.toString((char) int(random(65, 91)));
    extra = extra + letter;
  }
  
  //println(extra);
  //String extra = "QXV";
  message = extra + message;
  message = message.toUpperCase();
  //print(message.length());
  
  STEP_2 = message;
  
  //get alphabet for later
  String alpha = "";// = //alpha
  for(int i = 65; i < 91; i++){
     alpha = alpha + (Character.toString((char)int(i)));
  }


  
  //println(alpha);
  //println(message);
  
  //get poem + clean
  String[] poem_array = loadStrings("poem.txt");
  String poem = "";

  for (int i = 0 ; i < poem_array.length; i++) {
    poem = poem + poem_array[i];
  }
  
  poem = poem.toUpperCase();
  String[] poem_words = poem.split("\\s");
  //print(poem_words[0]);
  POEM = poem_words;
  int[] position = new int[4];
  String key = "";
  for(int i = 0; i < 4 ; i++){
    int k = rand.nextInt(18);
    position[i] = k+1;
    //println(position[i]);
    //println(poem_words[k]);
    key = key + poem_words[k];
  }
  POSITIONS = position;
  //String key = poem_words[1] + poem_words[5] + poem_words[10] + poem_words[14];
  //print(key.length());
  
  println(message.length());
  //print(key.length());
  //print();
  //create grid for mapping message
  int x = 0;
  String[][] grid = new String[ceil( (float) message.length() / (float)key.length()) + 2][key.length()];
  for (int i = 0; i < ceil( (float) message.length() / (float)key.length()) + 2; i++){
    for (int j = 0 ; j < key.length(); j++){
      if (i == 0){
        grid[i][j] = key.substring(j,j+1);
        //print(key.substring(j,j+1));
      }
      else if (i == 1) {
        grid[i][j] = "x";
      }
      else{
          if (x >= message.length()) {break;}
          grid[i][j] = message.substring(x, x+1);
          x++;
          //print(x);
 
      }
    }
  }
  
  //number the columns alphabetically
  int count = 1;
  //while(true){
   // print("y");
    for (int i = 0; i < alpha.length(); i++){
      for(int j = 0; j < key.length(); j++){
        //print(alpha.substring(i,i+1));
        //print(grid[0][j]);
        if (grid[0][j].equals(alpha.substring(i,i+1)) && grid[1][j]=="x"){
     //     print("x");
          grid[1][j] = str(count);
          
          //print(count);
          count = count + 1;
          if (count > key.length()+1){
            break;
          }
          //print(count < (key.length()+1));
          //print(key.length());
        }
      }
    }
  //}
  GRID = grid;

  //for (int i = 0 ; i <grid.length; i++){
  //  for(int j = 0; j < grid[i].length; j++){
  //    if ( j ==0) {
  //      print("\n");
  //    }
  //    System.out.print(grid[i][j] + " ");
  //  }
  //}
  
  //sort based on numbers
  String[][] sortedGrid = new String[ceil( (float) message.length() / (float)key.length()) + 2][key.length()];
  for (int i = 1; i <key.length()+1; i++){
    for (int k = 0; k<ceil( (float) message.length() / (float)key.length()) + 2; k++){
      sortedGrid[k][i-1] = grid[k][Arrays.asList(grid[1]).indexOf(str(i))];
    }
  }
  //print(Arrays.asList(grid[1]).indexOf(str(11)));
  
  // for (int i = 0 ; i <grid.length; i++){
  //  for(int j = 0; j < grid[i].length; j++){
  //    if ( j ==0) {
  //      print("\n");
  //    }
  //    System.out.print(sortedGrid[i][j] + " ");
  //  }
  //}
  
  //get string
  int counter = 0;
  String encrypted = "";
  for(int k =0; k <grid[0].length; k++){
    for (int i = 2; i < grid.length; ++i){
      if (sortedGrid[i][k] != null){
        counter = counter + 1;
        encrypted = encrypted + sortedGrid[i][k];
      }
      if(counter == 5){
        encrypted = encrypted+" ";
        counter = 0;
      }
    }
  }
  //print(encrypted);
  
  
  
   String[] alphabet = new String[26];
  for(int i =0; i <26;i++){
    alphabet[i] = alpha.substring(i,i+1);
  }
  
  int[] num_ind = new int[secret.length];
  if (position.length < secret.length){
    //int[] num = new int[secret.length];
    for(int i = 0; i < secret.length-position.length; i++){
      num_ind[i] = secret[i];
      //println(i);
      //println(num_ind[i]);
    }
    for(int i = 0; i < position.length; i++){
      num_ind[secret.length-1-i] = position[position.length-1-i]+secret[secret.length-1-i];
     //println("x");
     // println(secret.length-1-i);
     //println(num_ind[secret.length-1-i]);
    }
    INDICATOR = num_ind;
    //encrypted = encrypted + " ";
    for(int i = 0; i <num_ind.length;i++){
      if (num_ind[i] > 10 && num_ind[i] < 21){
        CHECK[i] = alphabet[num_ind[i]-1-10];
        encrypted = encrypted + alphabet[num_ind[i]-1-10];
      }
      else if(num_ind[i] < 11){
        CHECK[i] = alphabet[num_ind[i]-1+10];
        encrypted = encrypted + alphabet[num_ind[i]-1+10];
      }
      else{
        CHECK[i] = alphabet[num_ind[i]-1];
        encrypted = encrypted + alphabet[num_ind[i]-1];
      }
    }
    //for(int i = 0; i < num_ind.length; i++){
    //  println(num_ind[i]);
    //}
    
    encrypted = " " + encrypted;
    for(int i = 0; i <num_ind.length;i++){
      //println("check");
      //println(i);
      //println(num_ind.length-1-i);
      //println(num_ind[num_ind.length-1-i]-1);
      aINDICATOR[i] = alphabet[num_ind[num_ind.length-1-i]-1];
      encrypted = alphabet[num_ind[num_ind.length-1-i]-1] + encrypted;
    }
  }
  
  int[] num_pos = new int[position.length];
  if (position.length > secret.length){
    //int[] num = new int[secret.length];
    for(int i = 0; i < secret.length-position.length; i++){
      num_pos[i] = secret[i];
    }
    for(int i = 0; i < position.length; i++){
      num_pos[secret.length-1-i] = position[position.length-1-i]+secret[secret.length-1-i];
    }
    //encrypted = encrypted + " ";
    for(int i = 0; i <num_pos.length;i++){
      if (num_pos[i] > 16){
        encrypted = encrypted + alphabet[num_pos[i]-1-10];
      }
      else{
        encrypted = encrypted + alphabet[num_pos[i]-1+10];
      }
    }
    encrypted = " " + encrypted;
    for(int i = 0; i <num_pos.length;i++){
      encrypted = alphabet[num_pos[num_pos.length-1-i]-1] + encrypted;
    }
  }
  ENCRYPTED = encrypted;
  print(encrypted);
}

void keyPressed(){
  if(key == 'd'){
    if(STEP < 7){
      STEP++;
      println(STEP);
    }
  }
  if(key == 'a'){
    if(STEP > 1){
      STEP--;
      println(STEP);
    }
  }
}

void draw(){
  background(255);
  fill(0);
  textSize(25);
  if(STEP == 1){
    //print(STEP_1);
    text("STEP 1:",0,20);
    text(STEP_1,0,250);
  }
  if(STEP == 2){
    text("STEP 2:",0,20);
    text(STEP_2,0,250);
  }
  if(STEP == 3){
    text("STEP 3:",0,20);
    int x = 0;
    int y = 200;
    for(int i = 0;i<POEM.length;i++){
      for(int n =0;n<POSITIONS.length;n++){
        if(POSITIONS[n]-1 == i){
          fill(255,0,0);
        }
      }
      text(POEM[i],x,y);
      fill(0);
      x+= textWidth(POEM[i])+10;
      if(x > width){
        x = 0;
        y+= 50;
      }
    }
  }
  if(STEP == 4){
    text("STEP 4:",0,20);
    int x = 0;
    int y = 100;
    for(int i = 0;i<2;i++){
      y += 40;
      x = 0;
      for(int n = 0;n<GRID[i].length;n++){
        if(GRID[i][n] == null){
          break;
        }
        stroke(0);
        fill(255);
        rect(x,y-35,40,40);
        fill(0);
        text(GRID[i][n],x+5,y);
        x+= 40;
      }
    }
  }
  if(STEP == 5){
    text("STEP 5:",0,20);
    int x = 0;
    int y = 100;
    for(int i = 0;i<GRID.length;i++){
      y += 40;
      x = 0;
      for(int n = 0;n<GRID[i].length;n++){
        if(GRID[i][n] == null){
          break;
        }
        stroke(0);
        fill(255);
        rect(x,y-35,40,40);
        fill(0);
        text(GRID[i][n],x+5,y);
        x+= 40;
      }
    }
  }
  if(STEP == 6){
    fill(0);
    text("STEP 6:",0,20);
    int x = 400;
    int y = 150;
    for(int i = POSITIONS.length-1;i>=0;i--){
      text(POSITIONS[i],x,y);
      x-= 40;
    }
    int startX = x;
    y+=40;
    x = 400;
    for(int i = SECRET.length-1;i>=0;i--){
      text(SECRET[i],x,y);
      x-=40;
    }
    line(440,200,startX-40,200);
    line(startX-20,175,startX-20,190);
    line(startX-27,182,startX-13,182);
    y+=40;
    x = 400;
    for(int i = INDICATOR.length-1;i>=0;i--){  
      text(INDICATOR[i],x,y);
      text(aINDICATOR[INDICATOR.length-1-i],x,y+40);
      text(CHECK[i],x,y+80);
      triangle(x+5, y+5, x+15, y+5, x+10, y+10);
      x-=40;
    }
  }
  if(STEP == 7){
    text("Step 7:",0,20);
    text(ENCRYPTED,0,200);
  }
}

//----------------------------------------------------------
//String encode_message(){
//    String message = loadStrings("message.txt")[0].toString();
//    String secretNum = loadStrings("secretNum.txt")[0];
//    int[] secret = new int[5];
//    //{5,8,2,6,5};
//    for(int i = 0; i < secretNum.length(); i++){
//      secret[i] = int(secretNum.substring(i, i+1));
//      print(secret[i]);
//    }
//    println();
//    Random rand = new Random();
//    // Clean up message string
//    message = message.replaceAll("\\s", "");
//    message = message.replaceAll("\\.", "STOP");
//    //System.out.println(message);
    
//    String callsign = "";
//    for (int i = 0; i < 3; i++){
//      String letter = Character.toString((char) int(random(65, 91)));
//      callsign = callsign + letter;
//    }
     
//    //add extra letters to back and front
//    //String callsign = "UXV";
//    message = message + callsign;
//    //println(callsign);
    
//    String extra = "";
//    for (int i = 0; i < 5 - message.length()%5; i++){
//      String letter = Character.toString((char) int(random(65, 91)));
//      extra = extra + letter;
//    }
    
//    //println(extra);
//    //String extra = "QXV";
//    message = extra + message;
//    message = message.toUpperCase();
//    //print(message.length());
    
//    //get alphabet for later
//    String alpha = "";// = //alpha
//    for(int i = 65; i < 91; i++){
//       alpha = alpha + (Character.toString((char)int(i)));
//    }


    
//    //println(alpha);
//    //println(message);
    
//    //get poem + clean
//    String[] poem_array = loadStrings("poem.txt");
//    String poem = "";

//    for (int i = 0 ; i < poem_array.length; i++) {
//      poem = poem + poem_array[i];
//    }
    
//    poem = poem.toUpperCase();
//    String[] poem_words = poem.split("\\s");
//    //print(poem_words[0]);
    
//    int[] position = new int[4];
//    String key = "";
//    for(int i = 0; i < 4 ; i++){
//      int k = rand.nextInt(18);
//      position[i] = k+1;
//      //println(k+1);
//      //println(poem_words[k]);
//      key = key + poem_words[k];
//    }
//    //String key = poem_words[1] + poem_words[5] + poem_words[10] + poem_words[14];
//    //print(key.length());
    
//    println(message.length());
//    //print(key.length());
//    //print();
//    //create grid for mapping message
//    int x = 0;
//    String[][] grid = new String[ceil( (float) message.length() / (float)key.length()) + 2][key.length()];
//    for (int i = 0; i < ceil( (float) message.length() / (float)key.length()) + 2; i++){
//      for (int j = 0 ; j < key.length(); j++){
//        if (i == 0){
//          grid[i][j] = key.substring(j,j+1);
//          //print(key.substring(j,j+1));
//        }
//        else if (i == 1) {
//          grid[i][j] = "x";
//        }
//        else{
//            if (x >= message.length()) {break;}
//            grid[i][j] = message.substring(x, x+1);
//            x++;
//            //print(x);
 
//        }
//      }
//    }
    
//    //number the columns alphabetically
//    int count = 1;
//    //while(true){
//     // print("y");
//      for (int i = 0; i < alpha.length(); i++){
//        for(int j = 0; j < key.length(); j++){
//          //print(alpha.substring(i,i+1));
//          //print(grid[0][j]);
//          if (grid[0][j].equals(alpha.substring(i,i+1)) && grid[1][j]=="x"){
//       //     print("x");
//            grid[1][j] = str(count);
            
//            //print(count);
//            count = count + 1;
//            if (count > key.length()+1){
//              break;
//            }
//            //print(count < (key.length()+1));
//            //print(key.length());
//          }
//        }
//      }
//    //}


//    //for (int i = 0 ; i <grid.length; i++){
//    //  for(int j = 0; j < grid[i].length; j++){
//    //    if ( j ==0) {
//    //      print("\n");
//    //    }
//    //    System.out.print(grid[i][j] + " ");
//    //  }
//    //}
    
//    //sort based on numbers
//    String[][] sortedGrid = new String[ceil( (float) message.length() / (float)key.length()) + 2][key.length()];
//    for (int i = 1; i <key.length()+1; i++){
//      for (int k = 0; k<ceil( (float) message.length() / (float)key.length()) + 2; k++){
//        sortedGrid[k][i-1] = grid[k][Arrays.asList(grid[1]).indexOf(str(i))];
//      }
//    }
//    //print(Arrays.asList(grid[1]).indexOf(str(11)));
    
//    // for (int i = 0 ; i <grid.length; i++){
//    //  for(int j = 0; j < grid[i].length; j++){
//    //    if ( j ==0) {
//    //      print("\n");
//    //    }
//    //    System.out.print(sortedGrid[i][j] + " ");
//    //  }
//    //}
    
//    //get string
//    int counter = 0;
//    String encrypted = "";
//    for(int k =0; k <grid[0].length; k++){
//      for (int i = 2; i < grid.length; ++i){
//        if (sortedGrid[i][k] != null){
//          counter = counter + 1;
//          encrypted = encrypted + sortedGrid[i][k];
//        }
//        if(counter == 5){
//          encrypted = encrypted+" ";
//          counter = 0;
//        }
//      }
//    }
//    //print(encrypted);
    
    
    
//     String[] alphabet = new String[26];
//    for(int i =0; i <26;i++){
//      alphabet[i] = alpha.substring(i,i+1);
//    }
    
//    int[] num_ind = new int[secret.length];
//    if (position.length < secret.length){
//      //int[] num = new int[secret.length];
//      for(int i = 0; i < secret.length-position.length; i++){
//        num_ind[i] = secret[i];
//        //println(i);
//        //println(num_ind[i]);
//      }
//      for(int i = 0; i < position.length; i++){
//        num_ind[secret.length-1-i] = position[position.length-1-i]+secret[secret.length-1-i];
//       //println("x");
//       // println(secret.length-1-i);
//       // println(num_ind[secret.length-1-i]);
//      }
//      //encrypted = encrypted + " ";
//      for(int i = 0; i <num_ind.length;i++){
//        if (num_ind[i] > 16){
//          encrypted = encrypted + alphabet[num_ind[i]-1-10];
//        }
//        else{
//          encrypted = encrypted + alphabet[num_ind[i]-1+10];
//        }
//      }
//      //for(int i = 0; i < num_ind.length; i++){
//      //  println(num_ind[i]);
//      //}
      
//      encrypted = " " + encrypted;
//      for(int i = 0; i <num_ind.length;i++){
//        //println("check");
//        //println(i);
//        //println(num_ind.length-1-i);
//        //println(num_ind[num_ind.length-1-i]-1);
//        encrypted = alphabet[num_ind[num_ind.length-1-i]-1] + encrypted;
//      }
//    }
    
//    int[] num_pos = new int[position.length];
//    if (position.length > secret.length){
//      //int[] num = new int[secret.length];
//      for(int i = 0; i < secret.length-position.length; i++){
//        num_pos[i] = secret[i];
//      }
//      for(int i = 0; i < position.length; i++){
//        num_pos[secret.length-1-i] = position[position.length-1-i]+secret[secret.length-1-i];
//      }
//      //encrypted = encrypted + " ";
//      for(int i = 0; i <num_pos.length;i++){
//        if (num_pos[i] > 16){
//          encrypted = encrypted + alphabet[num_pos[i]-1-10];
//        }
//        else{
//          encrypted = encrypted + alphabet[num_pos[i]-1+10];
//        }
//      }
//      encrypted = " " + encrypted;
//      for(int i = 0; i <num_pos.length;i++){
//        encrypted = alphabet[num_pos[num_pos.length-1-i]-1] + encrypted;
//      }
//    }
    
    
  
 
    
//    return(encrypted);

//}
