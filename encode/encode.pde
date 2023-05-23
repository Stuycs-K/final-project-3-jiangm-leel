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

    for (int i = 97; i < 123; i++){
      alpha = alpha + (Character.toString((char)int(i)));
    }
    
    println(alpha);
    println(message);
    
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
    
    //print();
    String[message.length() / key.length() + 1][key.length()] grid;
}



//String[] poem_array = loadStrings("poem.txt");

//String poem = "";

//for (int i = 0 ; i < poem_array.length; i++) {
//  poem = poem + poem_array[0];
//}

//System.out.println(poem);
