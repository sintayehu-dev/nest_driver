import 'package:dartz/dartz.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/features/auth/domain/entities/otplogin/otp_login_request.dart';
import 'package:nest_driver/features/auth/domain/entities/otplogin/otp_login_response.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_request.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_response.dart';
import 'package:nest_driver/features/auth/domain/entities/profile_update/profile_update_request.dart';
import 'package:nest_driver/features/auth/domain/entities/profile_update/profile_update_response.dart';

abstract class AuthRepository {
  Future<Either<NetworkExceptions, OtpLoginResponse>> requestOtpLogin( OtpLoginRequest request);
  Future<Either<NetworkExceptions, OtpVerifyResponse>> verifyLoginOtp( OtpVerifyRequest request);
  Future<Either<NetworkExceptions, ProfileUpdateResponse>> updateProfile(ProfileUpdateRequest request);
 
} 