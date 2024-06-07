
final emailRegex = RegExp(r'^[a-zA-Z0-9+._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
final passwordRegex = RegExp(r'^.{4,}$');
final usernameRegex = RegExp(r'^.{2,}$');
final digitRegex = RegExp(r'^\d+$');
final cnicRegex = RegExp(r'^\d{13}$');

String? validateEmptyField(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}

String? validateName(String? value) {
  String? emptyFieldError = validateEmptyField(value, 'Name');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }
  if (!usernameRegex.hasMatch(value!)) {
    return 'Min ten characters limit is required';
  }
  return null;
}

String? validateCnic(String? value) {
  if (value == null || value.isEmpty) {
    return 'CNIC is required';
  }
  if (value.length != 13) {
    return 'CNIC must be 13 digits';
  }
  if (!RegExp(r'^[0-9]{13}$').hasMatch(value)) {
    return 'Invalid CNIC format: Enter 13 digits without spaces or dashes';
  }
  return null;
}



String? validateEmail(String? value) {
  String? emptyFieldError = validateEmptyField(value, 'Email');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }
  if (!emailRegex.hasMatch(value!)) {
    return 'Invalid email format';
  }
  return null;
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  if (!RegExp(r'^03[0-9]{9}$').hasMatch(value)) {
    return 'Invalid number format: Must be 03XXXXXXXXX';
  }
  return null; // The number is valid
}

String? validateRaastId(String? value) {
  if (value == null || value.isEmpty) {
    return 'Raast ID is required';
  }
  if (!RegExp(r'^03[0-9]{9}$').hasMatch(value)) {
    return 'Invalid ID format: Must be 03XXXXXXXXX';
  }
  return null; // The number is valid
}


String? validatePasscode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Passcode cannot be empty';
  }
  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
    return 'Passcode must be exactly 4 digits';
  }
  return null;
}

String? validateProfilePassword(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  if (!passwordRegex.hasMatch(value)) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Confirm password cannot be empty';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateIncome(String? value) {
  String? emptyFieldError = validateEmptyField(value, 'Income');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }
  try {
    int income = int.parse(value!);

    if (income <= 10000) {
      return 'Income must be greater than PKR 10000';
    }
  } catch (e) {
    return 'Invalid income format';
  }
  return null;
}

String? validateAddress(String? value) {
  String? emptyFieldError = validateEmptyField(value, 'Address');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }

  if (value!.length > 100) {
    return 'Address should not be more than 100 characters';
  }

  return null;
}

String? validateCardNumber(String? value) {
  String? emptyFieldError = validateEmptyField(value, 'Card Number');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }

  // Remove spaces and non-digit characters
  String cleanedValue = value!.replaceAll(RegExp(r'[^0-9]'), '');

  // Check if the cleaned card number is all digits
  if (!digitRegex.hasMatch(cleanedValue)) {
    return 'Card number must be numeric';
  }

  // Check the length of the card number (specifically 16 digits)
  if (cleanedValue.length != 16) {
    return 'Card number must be 16 digits';
  }

  // Luhn algorithm to validate the card number
  if (!isValidCardNumber(cleanedValue)) {
    return 'Invalid card number';
  }

  return null;
}

bool isValidCardNumber(String number) {
  int sum = 0;
  bool alternate = false;

  for (int i = number.length - 1; i >= 0; i--) {
    int digit = int.parse(number[i]);

    if (alternate) {
      digit *= 2;
      if (digit > 9) {
        digit -= 9;
      }
    }

    sum += digit;
    alternate = !alternate;
  }

  return sum % 10 == 0;
}


String? validateCardName(String? value) {
  // Check if the field is empty
  String? emptyFieldError = validateEmptyField(value, 'Card Name');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }

  // Regular expression for validating name (allowing space and alphabetic characters)
  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');

  // Check if the name contains only letters (and spaces)
  if (!nameRegex.hasMatch(value!)) {
    return 'Name on card must contain only letters and spaces';
  }

  return null;
}

String? validateCardExpiryDate(String? value) {
  String? emptyFieldError = validateEmptyField(value, 'Expiry Date');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }

  // Regular expression to check the format MM/YY
  final expiryDateRegex = RegExp(r'^(0[1-9]|1[0-2])/([0-9]{2})$');

  if (!expiryDateRegex.hasMatch(value!)) {
    return 'Invalid expiry date format. Use MM/YY';
  }

  // Extracting month and year from the value
  List<String> parts = value.split('/');
  int month = int.parse(parts[0]);
  int year = int.parse(parts[1]) + 2000; // Assuming 21st century

  // Creating a DateTime object for the last day of the expiry month
  DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
  DateTime currentDate = DateTime.now();

  if (currentDate.isAfter(lastDayOfMonth)) {
    return 'Card has expired';
  }

  return null;
}

String? validate16DigitField(String? value) {
  String? emptyFieldError = validateEmptyField(value, 'Field');
  if (emptyFieldError != null) {
    return emptyFieldError;
  }

  // Regular expression to check if the input is numeric and 16 digits
  final sixteenDigitRegex = RegExp(r'^\d{16}$');

  if (!sixteenDigitRegex.hasMatch(value!)) {
    return 'Field must be a numeric 16-digit number';
  }

  return null;
}

String? validateCvv(String? value) {
  if (value == null || value.isEmpty) {
    return 'CVV is required';
  }
  if (!RegExp(r'^\d{3}$').hasMatch(value)) {
    return 'CVV must be a 3-digit numeric';
  }
  return null;
}




