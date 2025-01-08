import 'dart:io';
import 'dart:math';

void main() {
  bool shouldContinue = true;
  print('Welcome to the Password Generator');

  // keep running programm while shouldContinue is set to true
  while (shouldContinue) {
    displayMenu();

    int menuChoice = getMenuChoice();

    // generate password
    if(menuChoice == 1) {
      int passwordLength;
      int passwordQuantity;

      // make sure that password length or quantity is not 0 or less
      do {
        stdout.write('Enter password length: ');
        passwordLength = int.parse(stdin.readLineSync()!);

        stdout.write('Password quantity: ');
        passwordQuantity = int.parse(stdin.readLineSync()!);

        if(passwordLength <= 0 || passwordQuantity <= 0) {
          print('Password length or quantity cannot be 0 or less. Please try again');
        }
      } while (passwordLength <= 0 || passwordQuantity <= 0);

      generatePassword(
        passwordQuantity: passwordQuantity, 
        passwordLength: passwordLength);
    } else {
      shouldContinue = false;
    }
  }
}

void displayMenu() {
  print('\nChoose an option: ');
  print('[1] Generate password');
  print('[2] Exit');
}

int getMenuChoice() {
  int? menuChoice;

  // prompt the user to input 1 or 2 to choose between menu actions
  while(menuChoice != 1 && menuChoice != 2) {
    try {
      stdout.write('Enter your choice: ');
      menuChoice = int.parse(stdin.readLineSync()!);
      if(menuChoice != 1 && menuChoice != 2) {
        print('Invalid choice');
      }
    } catch (error) {
      print('Unknown Input. Please enter a valid number');
    }
  }

  return menuChoice!;
}

void generatePassword({
  required int passwordQuantity, 
  required int passwordLength}) {
    Random random = new Random();
    
    const String lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String specialCharacters = '!@#\$%^&*()_+';

    String password = '';

    // password quantity loop
    for(var passwordIndex = 0; passwordIndex < passwordQuantity; passwordIndex++) {
      // password length loop
      for (var charIndex = 0; charIndex < passwordLength; charIndex++) {
        // generate random number to choose between lower/upper case letters,
        // numbers or special characters
        int randomNumber = random.nextInt(4) + 1;

        switch (randomNumber) {
          case 1:
              // append lowercase letter from the String
              password += lowercaseLetters[random.nextInt(lowercaseLetters.length)];
            break;
          case 2:
              // append uppercase letter from the String
              password += uppercaseLetters[random.nextInt(uppercaseLetters.length)];
            break;
          case 3:
              // append number from the String
              password += numbers[random.nextInt(numbers.length)];
            break;
          case 4:
              // append special character from the String
              password += specialCharacters[random.nextInt(specialCharacters.length)];
            break;
          default:
            break;
        }
      }

      printPassword(
        password: password, 
        passwordQuantity: passwordQuantity, 
        passwordIndex: passwordIndex);

      password = '';
    }
}

void printPassword({
  required String password, 
  required int passwordQuantity,
  required int passwordIndex}) {
    if(passwordQuantity == 1) {
      print('Your password is: $password');
    } else {
      print('Password ${passwordIndex + 1}: $password');
    }
}