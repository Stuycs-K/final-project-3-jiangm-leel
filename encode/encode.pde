void setup(){
  size(0,0);
  String mess = "READYFORACTIONNOWSTOPCONFIRMGOAHEADASPLANNEDBYBROADCASTINGTHEAGREEDMESSAGEVIARADIOORANGESTOPWAITINGFORFURTHERINSTRUCTIONSSTOP";  
  encode_message(mess); 
  
}

void encode_message(String message){
    message = message.replaceAll("\\s", "");
    message = message.replaceAll("\\.", "STOP");
  //  System.out.println(message);
    
    //String callsign = "";
    //for (int i = 0; i < 3; i++){
    //  String letter = Character.toString((char) int(random(65, 91)));
    //  callsign = callsign + letter;
    //}
    String callsign = "UXV";
    message = message + callsign;
    
    //String extra = "";
    //for (int i = 0; i < message.length()%5; i++){
    //  String letter = Character.toString((char) int(random(65, 91)));
    //  extra = extra + letter;
    //}
    
    String extra = "QW";
    message = extra + message;
    message = message.toUpperCase();
    //print(message.toUpperCase());
    
    String alpha = "";// = //alpha
    for(int i = 65; i < 91; i++){
       alpha = alpha + (Character.toString((char)int(i)));
    }


    
    println(alpha);
    //println(message);
    
    String[] poem_array = loadStrings("poem.txt");
    String poem = "";

    for (int i = 0 ; i < poem_array.length; i++) {
      poem = poem + poem_array[i];
    }
    
    poem = poem.toUpperCase();
    String[] poem_words = poem.split("\\s");
    //print(poem_words[0]);
    
    String key = poem_words[1] + poem_words[5] + poem_words[10] + poem_words[14];
    //print(key.length());
    
    //print(message.length());
    //print(key.length());
    //print();
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
            if (x > 129) {break;}
            grid[i][j] = message.substring(x, x+1);
            x++;
            //print(x);
 
        }
      }
    }
    
    for (int i = 0 ; i <grid.length; i++){
      for(int j = 0; j < grid[i].length; j++){
        if ( j ==0) {
          print("\n");
        }
        System.out.print(grid[i][j] + " ");
      }
    }
  
    int count = 1;
    while(count < (key.length()+1)){
     // print("y");
      for (int i = 0; i < alpha.length(); i++){
        for(int j = 0; j < key.length(); j++){
          //print(alpha.substring(i,i+1));
          print(grid[0][j]);
          if (true){
       //     print("x");
            grid[1][j] = str(count);
            
            print(count);
            count = count + 1;
            print(count < (key.length()+1));
            //print(key.length());
          }
        }
      }
    }
    print("@@@@@@@@@@@@@@@@@@");
    for (int i = 0 ; i <grid.length; i++){
      for(int j = 0; j < grid[i].length; j++){
        if ( j ==0) {
          print("\n");
        }
        System.out.print(grid[i][j] + " ");
      }
    }
}
