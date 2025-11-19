import 'package:nest_driver/app_widget.dart';
import 'package:nest_driver/bootstrap.dart';
import 'package:nest_driver/core/config/environment.dart';

void main() {
  // Default to development environment
  // Use main_dev.dart, main_staging.dart, or main_prod.dart for specific environments
  bootstrap(
    () => const AppWidget(),
    environment: AppEnvironment.development,
  );
}
