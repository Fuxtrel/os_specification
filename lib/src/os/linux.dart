import 'dart:io';
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
  int createShortcuts(String appDirPath) {
    // TODO: implement createShortcuts
    throw UnimplementedError();
  }

  @override
  void enableAutoBoot(String processName) {
    // TODO: implement enableAutoBoot
  }
}
