
import 'dynamic_ui_executor_platform_interface.dart';

class DynamicUiExecutor {
  Future<String?> getPlatformVersion() {
    return DynamicUiExecutorPlatform.instance.getPlatformVersion();
  }
}
