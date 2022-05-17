import 'dart:io';
import 'package:win_api/win_api.dart';
import 'os_spec.dart';

class Linux extends OsSpecifications {
  Linux() {
    appDirPath = getAppLocation();
    var _registryFile = File(registryFile);
    if(!_registryFile.existsSync()){
      _registryFile.createSync();
    }
  }

  static const String registryFile = '/usr/local/storageup/registry';

  @override
  int killProcess(String processName) {
    var result = Process.runSync('killall', [processName], runInShell: true);
    return result.exitCode;
  }

  @override
  String getAppLocation() {
    return File(registryFile).readAsStringSync().trim();
  }

  @override
  String setVersion(String version, String filePath) {
    File(filePath).writeAsString(version);
    return version;
  }

  @override
  void startProcess(String processName, [List<String> args = const []]) {
    switch (processName) {
      case 'storageup':
        Process.runSync('${appDirPath}/storageup', args);
        break;
      case 'keeper':
        Process.runSync('${appDirPath}/keeper&', args);
        break;
      case 'update':
        Process.runSync('${appDirPath}/ups_update&', args);
        break;
    }
  }

  //TODO: create method, registers app in linux
  @override
  int registerAppInOs(String appDirPath) {
    try {
      var _registry = File(registryFile);
      if (!_registry.existsSync()) {
        _registry.createSync(recursive: true);
      }
      _registry.writeAsStringSync(appDirPath);
      appDirPath = appDirPath;
      return 0;
    } catch (e) {
      return 1;
    }
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
      var file = File('${appDirPath}hash');
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
  bool setKeeperHash(String hash) {
    try {
      var file = File('${appDirPath}hash');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsStringSync(hash);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
