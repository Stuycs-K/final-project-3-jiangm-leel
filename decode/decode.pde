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
  String cipher = loadStrings("cipher.txt")[0].toString();
  String[] poem = split(loadStrings("poem.txt")[0], " ");
  String secretNum = loadStrings("secretNum.txt")[0];
  String msgIndicator = cipher.substring(0,5);
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
  //for(int i = 0; i<position.length;i++){
  //  println(position[i]);
  //}
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
  String[] keyArray = new String[Key.length()];
  for(int i = 0; i < Key.length(); i ++ ){
    keyArray[i] = Key.substring(i,i+1);
  }
  cipher = cipher.substring(5,cipher.length()-6);
  cipher = cipher.replaceAll("\\s","");
  //print(cipher);
  
  int lowestChar;
  int lowestIndex=0;
  //int currentIndex = 0;
  int numChars = 0;
  int index = 0;
  for(int i = 0;i < keyArray.length;i++){
    lowestChar = 100;
    for(int n = 0;n < keyArray.length;n++){
      if( (int)keyArray[n].charAt(0) < lowestChar){
        lowestChar = (int)keyArray[n].charAt(0);
        lowestIndex = n;
      }
    }
    if(lowestIndex < (cipher.length() % keyArray.length)){
      numChars = Math.floorDiv(cipher.length(),keyArray.length) + 1;
    }
    else{
      numChars = Math.floorDiv(cipher.length(),keyArray.length);
    }
    keyArray[lowestIndex] = "a" + cipher.substring(index,index+numChars);
    index+= numChars;
  }
  
  String decoded = "";
  for(int i = 1; i < Math.floorDiv(cipher.length(),keyArray.length)+1;i++){
    for(int n = 0; n < keyArray.length;n++){
      decoded += keyArray[n].charAt(i);
    }
  }
  for(int i = 0; i < cipher.length() % keyArray.length;i++){
    decoded += keyArray[i].charAt(keyArray[i].length() - 1);
  }
  print(decoded);
}
