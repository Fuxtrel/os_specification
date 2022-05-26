import 'dart:convert';

import 'package:os_specification/os_specification.dart';
import 'dart:io';

class MacOs extends OsSpecifications {
  MacOs() {
    appDirPath =
        '/Users/${Platform.environment['USER']}/Library/Application Support/StorageUp/';
  }

  static String supportDir =
      '/Users/${Platform.environment['USER']}/Library/Containers/com.example.upstorageDesktop/Data/Library/Application Support/com.example.upstorageDesktop/';

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

  @override
  String getKeeperHash() {
    try {
      var file = File('${supportDir}hash');
      if (!file.existsSync()) {
        return '';
      }
      return file.readAsStringSync();
    } catch (e) {
      print(e);
      return '';
    }
  }

  @override
  bool setKeeperHash(String mail, String hash) {
    try {
      var file = File('${supportDir}hash');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsStringSync(json.encode({'hash': hash, 'email': mail}));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
