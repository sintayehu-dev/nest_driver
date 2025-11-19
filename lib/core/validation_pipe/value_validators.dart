import 'package:dartz/dartz.dart';
import 'package:nest_driver/core/value_failures/value_failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
      
  // Trim the input to handle whitespace
  final trimmedInput = input.trim();
  
  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Please enter your email address',),);
  }
  
  // Check for length constraints
  if (trimmedInput.length > 254) { // Maximum length per RFC 5321
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Email address is too long (maximum 254 characters)',),);
  }
  
  // Check for basic structure
  if (!trimmedInput.contains('@')) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Email address must contain "@" symbol',),);
  }
  
  // Split email into local and domain parts
  final parts = trimmedInput.split('@');
  if (parts.length > 2) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Email address cannot contain multiple "@" symbols',),);
  }
  
  final localPart = parts[0];
  final domainPart = parts[1];
  
  // Validate local part
  if (localPart.isEmpty) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Username part before "@" cannot be empty',),);
  }
  
  if (localPart.length > 64) { // Maximum length per RFC 5321
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Username part before "@" is too long (maximum 64 characters)',),);
  }
  
  // Check for invalid starting/ending characters in local part
  if (localPart.startsWith('.') || localPart.endsWith('.')) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Username part cannot start or end with a dot',),);
  }
  
  // Validate domain part
  if (domainPart.isEmpty) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Domain part after "@" cannot be empty',),);
  }
  
  if (!domainPart.contains('.')) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Domain must contain a dot (e.g., .com, .net)',),);
  }
  
  if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Domain cannot start or end with a dot',),);
  }
  
  if (domainPart.startsWith('-') || domainPart.endsWith('-')) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Domain cannot start or end with a hyphen',),);
  }
  
  // Check for consecutive dots
  if (trimmedInput.contains('..')) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Email address cannot contain consecutive dots',),);
  }
  
  // Check for invalid characters
  if (trimmedInput.contains(' ')) {
    return left(const ValueFailure.invalidEmail(
      failedValue: 'Email address cannot contain spaces',),);
  }
  
  // Final regex check for overall format
  if (RegExp(emailRegex).hasMatch(trimmedInput)) {
    return right(trimmedInput);
  }
  
  // If all specific checks pass but regex fails, provide a general message
  return left(const ValueFailure.invalidEmail(
    failedValue: 'Please enter a valid email address',),);
}

Either<ValueFailure<String>, String> validatePhoneNumber(String input) {
  // Trim the input to handle whitespace
  final trimmedInput = input.trim();
  
  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(const ValueFailure.empty(
      failedValue: 'Please enter a phone number',),);
  }
  
  // Simple validation for now - check for length and numeric characters
  if (trimmedInput.length < 7) {
    return left(const ValueFailure.invalidPhoneNumber(
      failedValue: 'Phone number is too short',),);
  }
  
  if (trimmedInput.length > 15) {
    return left(const ValueFailure.invalidPhoneNumber(
      failedValue: 'Phone number is too long',),);
  }
  
  // Check if it contains only digits, plus sign, and parentheses
  if (!RegExp(r'^[0-9\+\(\)\-\s]+$').hasMatch(trimmedInput)) {
    return left(const ValueFailure.invalidPhoneNumber(
      failedValue: 'Phone number contains invalid characters',),);
  }
  
  return right(trimmedInput);
}
// Only keep Email and PhoneNumber validators

Either<ValueFailure<String>, String> validateFullName(String input) {
  final trimmedInput = input.trim();
  if (trimmedInput.isEmpty) {
    return left(const ValueFailure.invalidFullName(
      failedValue: 'Please enter your full name',),);
  }
  // Reasonable bounds
  if (trimmedInput.length < 2) {
    return left(const ValueFailure.invalidFullName(
      failedValue: 'Full name is too short',),);
  }
  if (trimmedInput.length > 100) {
    return left(const ValueFailure.invalidFullName(
      failedValue: 'Full name is too long',),);
  }
  // Allow letters, spaces, hyphens, apostrophes, and dots
  final nameRegex = RegExp(r"^[A-Za-z\u00C0-\u024F][A-Za-z\u00C0-\u024F\.\'\- ]+$");
  if (!nameRegex.hasMatch(trimmedInput)) {
    return left(const ValueFailure.invalidFullName(
      failedValue: 'Full name contains invalid characters',),);
  }
  // Prevent multiple consecutive spaces
  if (trimmedInput.contains(RegExp(r'\s{2,}'))) {
    return left(const ValueFailure.invalidFullName(
      failedValue: 'Full name has extra spaces',),);
  }
  return right(trimmedInput);
}
