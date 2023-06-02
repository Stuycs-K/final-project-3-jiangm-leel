# Poem Code
By Lauren Lee, Marc Jiang
Period 3

## What is poem code?
Poem code is a method of cryptography used during World War II by the British. The method uses parts of a poem as a key to double transpose a plaintext message. 

We based our project on a version of poem code used by the Dutch Government at the time.

In the front and back of the encoded message, there is a "message indicator" which is used with a secret number that both the reciever and sender know to allow for decoding. 

## The poem
Any poem could be used, but this was one major fault of this method. If the enemy figured out the poem by torturing an agent or even by searching through famous or well-known poems, the secret message could be decoded. This led to agents creating original pieces just to encode a message.

In our example we used a famous Dutch poem:

**Toen onze mop een mopje was het aardig hem te zien nu bromt hy alle dagen en byt nog bovendien**

Each word of the poem is given a number that represents its position in the poem, which will be used later for encoding. 

## How to encode?
1. Inputed message is cleaned by removing spaces and periods
2. Add random three letters at the end of the message as a callsign. Then add more random letters at the beginning of the message so that the total method length is a multiple of five. 
3. Select random four random parts of the poem to use as the key. Take note of the position of the parts of the poem you use in the key. 
4. Create a grid with the same number of columns as the key length. Number the letters of the key by their order in the alphabet. If a letter is repeated twice, number them right after each other. For ex. if the key was "AAB", the first "A" will be give a 1. The second "A" will be given a 2. And "B" will be given a 3.
5. Write down the message from left to write on the grid. Create the encoded message by reading the grid top to bottom in the order of the numbers we established in step 3. Make sure you write the encoded message in groups of five as that is the length of our secret number. 
6. Add up the positions of the poem used in the key with the secret number. Ex. if the positions of the poem used are {2, 6, 11, 14} and the secret number is 58265, the result will be {5, 10, 8, 17, 19}. Convert the resulting numbers into letters based on their position in the alphabet and place those five letters at the front of the encoded message as the message indicator. Create the check group by adding 10 (or subtracting 10 if the number is > 16) to the resulting numbers and converting those numbers to alphabets. Add the check group at the end of the encoded message. 
7. The result is the encoded message with the message indicator at the front and the check group at the back. 

## How to decode?
The reciever should know both the poem used and the secret number. By converting the message indicator to its numbered position in the alphabet and subtracting the secret number from the message indcator, the reciever can determine the parts of the poem that was used. With this information, the reciever can easily recreate the grid to decipher the message. 
