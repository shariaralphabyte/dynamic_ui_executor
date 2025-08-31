import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dynamic_ui_executor_platform_interface.dart';

/// An implementation of [DynamicUiExecutorPlatform] that uses method channels.
class MethodChannelDynamicUiExecutor extends DynamicUiExecutorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dynamic_ui_executor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
