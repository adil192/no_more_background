import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  generateJniBindings(
    .new(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/compute/root_shell_util.g.dart'),
          structure: .singleFile,
        ),
      ),
      androidSdkConfig: AndroidSdkConfig(addGradleDeps: true),
      sourcePath: [packageRoot.resolve('android/app/src/main/java')],
      classes: [
        'com.otetswoo.app_manager.RootShellUtil',
        'androidx.core.util.Pair',
      ],
    ),
  );
}
