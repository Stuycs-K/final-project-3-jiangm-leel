void setup(){
  size(900,900);
}

int[] az26(String letters){
  int[] numbers;
  numbers = new int[letters.length()];
  char letter;
  for(int i = 0; i < numbers.length;i++){
    numbers[i] = (int(letters[i].toUpperCase()) - 65) % 26;
  }
  return numbers;
}

void decode(){
  String[] p = loadStrings("poem.txt");
  String[] poem = split(p[0], " ");
  String[] secretNum = loadStrings("secretNum.txt");
  String msgIndicator = poem[0];
  int position[];
  position = new int[msgIndicator.length()];
  for(int i = 0; i< msgIndicator.length();i++){
    //position[i] = 
  }
}
