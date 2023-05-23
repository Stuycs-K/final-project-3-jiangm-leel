void setup(){
  size(900,900);
}

void decode(){
  String[] p = loadStrings("poem.txt");
  String[] poem = split(p[0], " ");
  String[] secretNum = loadStrings("secretNum.txt");
  String msgIndicator = poem[0];
  for(int i = 0; i< msgIndicator.length();i++){
  
  }
}
