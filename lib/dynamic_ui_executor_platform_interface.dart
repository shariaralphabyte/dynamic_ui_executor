import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dynamic_ui_executor_method_channel.dart';

abstract class DynamicUiExecutorPlatform extends PlatformInterface {
  /// Constructs a DynamicUiExecutorPlatform.
  DynamicUiExecutorPlatform() : super(token: _token);

  static final Object _token = Object();

  static DynamicUiExecutorPlatform _instance = MethodChannelDynamicUiExecutor();

  /// The default instance of [DynamicUiExecutorPlatform] to use.
  ///
  /// Defaults to [MethodChannelDynamicUiExecutor].
  static DynamicUiExecutorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DynamicUiExecutorPlatform] when
  /// they register themselves.
  static set instance(DynamicUiExecutorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
