void setup(){
  size(900,900);
  String mess = "  instru  ctions.";  
  encode_message(mess); 
  
}

void encode_message(String message){
    message = message.replaceAll("\\s", "");
    message = message.replaceAll("\\.", "STOP");
    System.out.println(message);
    
    String callsign = "";
    for (int i = 0; i < 3; i++){
      String letter = Character.toString((char) int(random(65, 91)));
      callsign = callsign + letter;
    }
    
    message = message + callsign;
    
    String extra = "";
    for (int i = 0; i < message.length()%5; i++){
      String letter = Character.toString((char) int(random(65, 91)));
      extra = extra + letter;
    }
    

    message = extra + message;
    message = String.toUpperCase(message);
    
    String alpha = "";// = //alpha
    for(int i = 65; i < 91; i++){
       alpha = alpha + (Character.toString((char)int(i)));
    }

    for (int i = 97; i < 123; i++){
      alpha = alpha + (Character.toString((char)int(i)));
    }
    
    print(alpha);
    
}



//String[] poem_array = loadStrings("poem.txt");

//String poem = "";

//for (int i = 0 ; i < poem_array.length; i++) {
//  poem = poem + poem_array[0];
//}

//System.out.println(poem);
