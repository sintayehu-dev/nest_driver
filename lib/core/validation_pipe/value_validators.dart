import 'package:dartz/dartz.dart';
import 'package:nest_driver/core/value_failures/value_failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  // Trim the input to handle whitespace
  final trimmedInput = input.trim();

  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Please enter your email address',
      ),
    );
  }

  // Check for length constraints
  if (trimmedInput.length > 254) {
    // Maximum length per RFC 5321
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address is too long (maximum 254 characters)',
      ),
    );
  }

  // Check for basic structure
  if (!trimmedInput.contains('@')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address must contain "@" symbol',
      ),
    );
  }

  // Split email into local and domain parts
  final parts = trimmedInput.split('@');
  if (parts.length > 2) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address cannot contain multiple "@" symbols',
      ),
    );
  }

  final localPart = parts[0];
  final domainPart = parts[1];

  // Validate local part
  if (localPart.isEmpty) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Username part before "@" cannot be empty',
      ),
    );
  }

  if (localPart.length > 64) {
    // Maximum length per RFC 5321
    return left(
      const ValueFailure.invalidEmail(
        failedValue:
            'Username part before "@" is too long (maximum 64 characters)',
      ),
    );
  }

  // Check for invalid starting/ending characters in local part
  if (localPart.startsWith('.') || localPart.endsWith('.')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Username part cannot start or end with a dot',
      ),
    );
  }

  // Validate domain part
  if (domainPart.isEmpty) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain part after "@" cannot be empty',
      ),
    );
  }

  if (!domainPart.contains('.')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain must contain a dot (e.g., .com, .net)',
      ),
    );
  }

  if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain cannot start or end with a dot',
      ),
    );
  }

  if (domainPart.startsWith('-') || domainPart.endsWith('-')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain cannot start or end with a hyphen',
      ),
    );
  }

  // Check for consecutive dots
  if (trimmedInput.contains('..')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address cannot contain consecutive dots',
      ),
    );
  }

  // Check for invalid characters
  if (trimmedInput.contains(' ')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address cannot contain spaces',
      ),
    );
  }

  // Final regex check for overall format
  if (RegExp(emailRegex).hasMatch(trimmedInput)) {
    return right(trimmedInput);
  }

  // If all specific checks pass but regex fails, provide a general message
  return left(
    const ValueFailure.invalidEmail(
      failedValue: 'Please enter a valid email address',
    ),
  );
}

Either<ValueFailure<String>, String> validatePhoneNumber(String input) {
  // Trim the input to handle whitespace
  final trimmedInput = input.trim();

  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.empty(
        failedValue: 'Please enter a phone number',
      ),
    );
  }

  // Simple validation for now - check for length and numeric characters
  if (trimmedInput.length < 7) {
    return left(
      const ValueFailure.invalidPhoneNumber(
        failedValue: 'Phone number is too short',
      ),
    );
  }

  if (trimmedInput.length > 15) {
    return left(
      const ValueFailure.invalidPhoneNumber(
        failedValue: 'Phone number is too long',
      ),
    );
  }

  // Check if it contains only digits, plus sign, and parentheses
  if (!RegExp(r'^[0-9\+\(\)\-\s]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidPhoneNumber(
        failedValue: 'Phone number contains invalid characters',
      ),
    );
  }

  return right(trimmedInput);
}
// Only keep Email and PhoneNumber validators

Either<ValueFailure<String>, String> validateFullName(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidFullName(
        failedValue: 'Please enter your full name',
      ),
    );
  }
  // Reasonable bounds
  if (trimmedInput.length < 2) {
    return left(
      const ValueFailure.invalidFullName(
        failedValue: 'Full name is too short',
      ),
    );
  }
  if (trimmedInput.length > 100) {
    return left(
      const ValueFailure.invalidFullName(
        failedValue: 'Full name is too long',
      ),
    );
  }
  // Allow letters, spaces, hyphens, apostrophes, and dots
  final nameRegex =
      RegExp(r"^[A-Za-z\u00C0-\u024F][A-Za-z\u00C0-\u024F\.\'\- ]+$");
  if (!nameRegex.hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidFullName(
        failedValue: 'Full name contains invalid characters',
      ),
    );
  }
  // Prevent multiple consecutive spaces
  if (trimmedInput.contains(RegExp(r'\s{2,}'))) {
    return left(
      const ValueFailure.invalidFullName(
        failedValue: 'Full name has extra spaces',
      ),
    );
  }
  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validateFinNumber(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidFinNumber(
        failedValue: 'Please enter FIN number',
      ),
    );
  }
  if (trimmedInput.length < 5) {
    return left(
      const ValueFailure.invalidFinNumber(
        failedValue: 'FIN number is too short',
      ),
    );
  }
  if (trimmedInput.length > 20) {
    return left(
      const ValueFailure.invalidFinNumber(
        failedValue: 'FIN number is too long',
      ),
    );
  }
  // Allow alphanumeric characters and hyphens
  if (!RegExp(r'^[A-Za-z0-9\-]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidFinNumber(
        failedValue: 'FIN number contains invalid characters',
      ),
    );
  }
  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validateCarMake(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidCarMake(
        failedValue: 'Please enter car make',
      ),
    );
  }
  if (trimmedInput.length < 2) {
    return left(
      const ValueFailure.invalidCarMake(
        failedValue: 'Car make is too short',
      ),
    );
  }
  if (trimmedInput.length > 50) {
    return left(
      const ValueFailure.invalidCarMake(
        failedValue: 'Car make is too long',
      ),
    );
  }
  // Allow letters, numbers, spaces, and hyphens
  if (!RegExp(r'^[A-Za-z0-9\s\-]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidCarMake(
        failedValue: 'Car make contains invalid characters',
      ),
    );
  }
  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validateCarModel(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidCarModel(
        failedValue: 'Please enter car model',
      ),
    );
  }
  if (trimmedInput.length < 1) {
    return left(
      const ValueFailure.invalidCarModel(
        failedValue: 'Car model is too short',
      ),
    );
  }
  if (trimmedInput.length > 50) {
    return left(
      const ValueFailure.invalidCarModel(
        failedValue: 'Car model is too long',
      ),
    );
  }
  // Allow letters, numbers, spaces, hyphens, and common symbols
  if (!RegExp(r'^[A-Za-z0-9\s\-\.\/]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidCarModel(
        failedValue: 'Car model contains invalid characters',
      ),
    );
  }
  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validatePlateNumber(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidPlateNumber(
        failedValue: 'Please enter plate number',
      ),
    );
  }
  if (trimmedInput.length < 3) {
    return left(
      const ValueFailure.invalidPlateNumber(
        failedValue: 'Plate number is too short',
      ),
    );
  }
  if (trimmedInput.length > 15) {
    return left(
      const ValueFailure.invalidPlateNumber(
        failedValue: 'Plate number is too long',
      ),
    );
  }
  // Allow alphanumeric characters, spaces, and hyphens
  if (!RegExp(r'^[A-Za-z0-9\s\-]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidPlateNumber(
        failedValue: 'Plate number contains invalid characters',
      ),
    );
  }
  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validateColor(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidColor(
        failedValue: 'Please enter vehicle color',
      ),
    );
  }
  if (trimmedInput.length < 3) {
    return left(
      const ValueFailure.invalidColor(
        failedValue: 'Color name is too short',
      ),
    );
  }
  if (trimmedInput.length > 30) {
    return left(
      const ValueFailure.invalidColor(
        failedValue: 'Color name is too long',
      ),
    );
  }
  // Allow letters, spaces, and hyphens
  if (!RegExp(r'^[A-Za-z\s\-]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidColor(
        failedValue: 'Color contains invalid characters',
      ),
    );
  }
  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validateVehicleType(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidVehicleType(
        failedValue: 'Please select vehicle type',
      ),
    );
  }
  if (trimmedInput.length < 3) {
    return left(
      const ValueFailure.invalidVehicleType(
        failedValue: 'Vehicle type is too short',
      ),
    );
  }
  if (trimmedInput.length > 30) {
    return left(
      const ValueFailure.invalidVehicleType(
        failedValue: 'Vehicle type is too long',
      ),
    );
  }
  // Allow letters, numbers, spaces, and hyphens
  if (!RegExp(r'^[A-Za-z0-9\s\-]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidVehicleType(
        failedValue: 'Vehicle type contains invalid characters',
      ),
    );
  }
  return right(trimmedInput);
}

Either<ValueFailure<int>, int> validateYearOfManufacture(int input) {
  final currentYear = DateTime.now().year;
  if (input < 1900) {
    return left(
      ValueFailure.invalidYear(
        failedValue: input,
      ),
    );
  }
  if (input > currentYear + 1) {
    return left(
      ValueFailure.invalidYear(
        failedValue: input,
      ),
    );
  }
  return right(input);
}

Either<ValueFailure<int>, int> validateCapacity(int input) {
  if (input < 1) {
    return left(
      ValueFailure.invalidCapacity(
        failedValue: input,
      ),
    );
  }
  if (input > 50) {
    return left(
      ValueFailure.invalidCapacity(
        failedValue: input,
      ),
    );
  }
  return right(input);
}
