import 'package:nest_driver/app_widget.dart';
import 'package:nest_driver/bootstrap.dart';
import 'package:nest_driver/core/config/environment.dart';

void main() {
   bootstrap(
    () => const AppWidget(),
    environment: AppEnvironment.development,
  );
}
