import 'dart:io';
import 'package:win_api/win_api.dart';
import 'os_spec.dart';

class Linux extends OsSpecifications {
  Linux() {
    appDirPath = '/usr/local/storageup';
  }

  static const String keeperDirPath = '/var/storageup';
  static const String keeperName = 'keeper.exe';

  @override
  int killProcess(String processName) {
    var result = Process.runSync('killall', [processName]);
    return result.exitCode;
  }

  @override
  String getAppLocation() {
    return appDirPath;
  }

  @override
  String setVersion(String version, String filePath) {
    File(filePath).writeAsString(version);
    return version;
  }

  @override
  void startProcess(String processName, [List<String> args = const []]) {
    //TODO
    // if (hide) {
    //   Process.runSync('nohup', ['$appDirPath${Platform.pathSeparator}$keeperName &']);
    // } else {
    //   Process.runSync('$appDirPath${Platform.pathSeparator}$keeperName', []);
    // }
  }

  //TODO: create method, registers app in linux
  @override
  int registerAppInOs(String appDirPath) {
    return 0;
  }

  @override
  int createShortCut(
    String pathToExe,
    String pathToShortcut, {
    List<String> args = const [],
    String description = '',
    int showMode = ShowMode.NORMAL,
    String workingDir = '',
    String iconPath = '',
    int iconIndex = 0,
  }) {
    // TODO: implement createShortcuts
    throw UnimplementedError();
  }

  @override
  void enableAutoBoot(String processName) {
    // TODO: implement enableAutoBoot
  }
}
