import 'dart:math';

double getRandomNumber() {
  Random rand = Random();
  int num = rand.nextInt(5);
  return num + 1;
}
