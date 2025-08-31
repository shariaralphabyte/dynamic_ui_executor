import 'package:flutter_test/flutter_test.dart';
import 'package:dynamic_ui_executor/dynamic_ui_executor.dart';
import 'package:dynamic_ui_executor/dynamic_ui_executor_platform_interface.dart';
import 'package:dynamic_ui_executor/dynamic_ui_executor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDynamicUiExecutorPlatform
    with MockPlatformInterfaceMixin
    implements DynamicUiExecutorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DynamicUiExecutorPlatform initialPlatform = DynamicUiExecutorPlatform.instance;

  test('$MethodChannelDynamicUiExecutor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDynamicUiExecutor>());
  });

  test('getPlatformVersion', () async {
    DynamicUiExecutor dynamicUiExecutorPlugin = DynamicUiExecutor();
    MockDynamicUiExecutorPlatform fakePlatform = MockDynamicUiExecutorPlatform();
    DynamicUiExecutorPlatform.instance = fakePlatform;

    expect(await dynamicUiExecutorPlugin.getPlatformVersion(), '42');
  });
}
