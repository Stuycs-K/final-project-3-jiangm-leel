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
      String letter = (char) int(random(65, 91)).toString();
      callsign = callsign + letter;
    }
    
    print(callsign);
}



//String[] poem_array = loadStrings("poem.txt");

//String poem = "";

//for (int i = 0 ; i < poem_array.length; i++) {
//  poem = poem + poem_array[0];
//}

//System.out.println(poem);
