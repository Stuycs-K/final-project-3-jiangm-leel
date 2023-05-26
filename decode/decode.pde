void setup(){
  size(900,900);
  decode();
  //println(az26("EJHQT"));
}

int[] az26(String letters){
  letters = letters.toUpperCase();
  int[] numbers;
  numbers = new int[letters.length()];
  int num = 0;
  for(int i = 0; i < numbers.length;i++){
    num = (int(letters.charAt(i)) - 64) % 26;
    if(num >= 21){
      continue;
    }
    numbers[i] = num;
  }
  return numbers;
}

void decode(){
  String[] cipher = split(loadStrings("cipher.txt")[0], " ");
  String[] poem = split(loadStrings("poem.txt")[0], " ");
  String secretNum = loadStrings("secretNum.txt")[0];
  String msgIndicator = cipher[0];
  //print(msgIndicator);
  int position[] = az26(msgIndicator);
  //println(position);
  //println(secretNum);
  for(int i = secretNum.length()-1;i>-1;i--){
    println(position[i]);
    println(Integer.parseInt(str(secretNum.charAt(i))));
    position[i] = position[i] - Integer.parseInt(str(secretNum.charAt(i)));
  }
  //print(Array.toString(position));
  //print(position);
  for(int i = 0; i<position.length;i++){
    println(position[i]);
  }
  String Key = "";
  for(int i = 0;i<position.length;i++){
    if(position[i] == 0){
      continue;
    }
    Key+= poem[position[i]-1];
    //println(position[i]);
    //println(Key[i]);
  }
  Key = Key.toUpperCase();
  char[] keyArray = Key.toCharArray();
  for(int i=0;i<keyArray.length;i++){
    
  }
}
