
import 'dynamic_ui_executor_platform_interface.dart';

export 'src/dynamic_widget_executor.dart';
export 'src/widget_parser.dart';
export 'src/action_handler.dart';
export 'src/theme_parser.dart';
export 'src/validator.dart';

class DynamicUiExecutor {
  Future<String?> getPlatformVersion() {
    return DynamicUiExecutorPlatform.instance.getPlatformVersion();
  }
}
