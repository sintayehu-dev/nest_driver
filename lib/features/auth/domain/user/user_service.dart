import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_response.dart';

abstract class UserService {
  /// Get the current logged in user data
  OtpUser? getCurrentUser();
  // show onboarding screen if user is first time opening the app
  bool isFirstTimeOpeningApp();
  // set the user as first time opening the app
  void setFirstTimeOpeningApp();
  
  /// Check if the user is logged in
  bool isLoggedIn();
  
  /// Logout the user
  Future<void> logout();
}

@Injectable(as: UserService)
class UserServiceImpl implements UserService {

  
  UserServiceImpl();
  
  @override
  OtpUser? getCurrentUser() {
    final userData = LocalStorage.instance.getUserData();
    if (userData == null) {
      return null;
    }
    
    try {
      return OtpUser.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  @override 
  bool isFirstTimeOpeningApp() {
    final isDoneOnboarding = LocalStorage.instance.getIsDoneOnboarding();
    return !isDoneOnboarding;
  }

  @override
  void setFirstTimeOpeningApp() {
    LocalStorage.instance.setIsDoneOnboarding(true);
  }
  
  @override
  bool isLoggedIn() {
    final token = LocalStorage.instance.getAccessToken();
    return token != null && token.isNotEmpty;
  }
  
  @override
  Future<void> logout() async {
    await LocalStorage.instance.clearUserSession();
  }
} 