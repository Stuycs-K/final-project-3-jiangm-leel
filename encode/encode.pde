<<<<<<< Updated upstream
import java.util.Arrays;
import java.util.Random;

void setup(){
  size(0,0);
  String mess = "THISISANIMPORTANTMESSAGE";
  print(encode_message(mess));
  
  
}

String encode_message(String message){
    Random rand = new Random();
    // Clean up message string
    message = message.replaceAll("\\s", "");
    message = message.replaceAll("\\.", "STOP");
  //  System.out.println(message);
    
    //String callsign = "";
    //for (int i = 0; i < 3; i++){
    //  String letter = Character.toString((char) int(random(65, 91)));
    //  callsign = callsign + letter;
    //}
    
    //add extra letters to back and front
    String callsign = "UXV";
    message = message + callsign;
    
    //String extra = "";
    //for (int i = 0; i < message.length()%5; i++){
    //  String letter = Character.toString((char) int(random(65, 91)));
    //  extra = extra + letter;
    //}
    
    String extra = "QXV";
    message = extra + message;
    message = message.toUpperCase();
    //print(message.toUpperCase());
    
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
    
    int[] position = new int[4];
    String key = "";
    for(int i = 0; i < 4 ; i++){
      int k = rand.nextInt(20);
      position[i] = k;
      key = key + poem_words[k];
    }
    //String key = poem_words[1] + poem_words[5] + poem_words[10] + poem_words[14];
    //print(key.length());
    
    //print(message.length());
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
    
    
    int[] secret = {5,8,2,6,5};
     String[] alphabet = new String[26];
    for(int i =0; i <26;i++){
      alphabet[i] = alpha.substring(i,i+1);
    }
    
    int[] num_ind = new int[secret.length];
    if (position.length < secret.length){
      //int[] num = new int[secret.length];
      for(int i = 0; i < secret.length-position.length; i++){
        num_ind[i] = secret[i];
      }
      for(int i = 0; i < position.length; i++){
        num_ind[secret.length-1-i] = position[position.length-1-i]+secret[secret.length-1-i];
      }
      //encrypted = encrypted + " ";
      for(int i = 0; i <num_ind.length;i++){
        if (num_ind[i] > 16){
          encrypted = encrypted + alphabet[num_ind[i]-1-10];
        }
        else{
          encrypted = encrypted + alphabet[num_ind[i]-1+10];
        }
      }
      
      encrypted = " " + encrypted;
      for(int i = 0; i <num_ind.length;i++){
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
    
    
  
 
    
    return(encrypted);

}
=======
import java.util.Arrays;
import java.util.Random;

void setup(){
  size(0,0);
  String mess = "THISISANIMPORTANTMESSAGE";
  print(encode_message(mess));
  
  
}

String encode_message(String message){
    Random rand = new Random();
    // Clean up message string
    message = message.replaceAll("\\s", "");
    message = message.replaceAll("\\.", "STOP");
  //  System.out.println(message);
    
    //String callsign = "";
    //for (int i = 0; i < 3; i++){
    //  String letter = Character.toString((char) int(random(65, 91)));
    //  callsign = callsign + letter;
    //}
    
    //add extra letters to back and front
    String callsign = "UXV";
    message = message + callsign;
    
    //String extra = "";
    //for (int i = 0; i < message.length()%5; i++){
    //  String letter = Character.toString((char) int(random(65, 91)));
    //  extra = extra + letter;
    //}
    
    String extra = "QXV";
    message = extra + message;
    message = message.toUpperCase();
    //print(message.toUpperCase());
    
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
    
    String key = "";
    for(int i = 0; i < 4 ; i++){
      key = key + poem_words[rand.nextInt(20)];
    }
    //String key = poem_words[1] + poem_words[5] + poem_words[10] + poem_words[14];
    //print(key.length());
    
    //print(message.length());
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


    for (int i = 0 ; i <grid.length; i++){
      for(int j = 0; j < grid[i].length; j++){
        if ( j ==0) {
          print("\n");
        }
        System.out.print(grid[i][j] + " ");
      }
    }
    
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
    
    int[] position = {2,6,11,15};
    int[] secret = {5,8,2,6,5};
     String[] alphabet = new String[26];
    for(int i =0; i <26;i++){
      alphabet[i] = alpha.substring(i,i+1);
    }
    
    int[] num_ind = new int[secret.length];
    if (position.length < secret.length){
      //int[] num = new int[secret.length];
      for(int i = 0; i < secret.length-position.length; i++){
        num_ind[i] = secret[i];
      }
      for(int i = 0; i < position.length; i++){
        num_ind[secret.length-1-i] = position[position.length-1-i]+secret[secret.length-1-i];
      }
      encrypted = encrypted + " ";
      for(int i = 0; i <num_ind.length;i++){
        if (num_ind[i] > 16){
          encrypted = encrypted + alphabet[num_ind[i]-1-10];
        }
        else{
          encrypted = encrypted + alphabet[num_ind[i]-1+10];
        }
      }
      
      encrypted = " " + encrypted;
      for(int i = 0; i <num_ind.length;i++){
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
       encrypted = encrypted + " ";
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
    
    
  
 
    
    return(encrypted);

}
>>>>>>> Stashed changes
