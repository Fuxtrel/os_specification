import 'dart:io';
import 'os_spec.dart';

class Windows extends OsSpecifications {
  String appDirPath = '';
  static const String keeperName = 'keeper.exe';
  static const String hideKeeperName = 'start_keeper.exe';
  static const String storageupName = 'StorageUp.lnk';
  static const String updateName = 'ups_update.exe';
  static const String hideUpdateName = 'start_ups_update.exe';

  Windows() {
    String result = getAppLocation();
    if (result.isNotEmpty) {
      appDirPath = result;
    }
  }

  String getAppName(String appName, bool hide) {
    switch (appName) {
      case 'keeper':
        if (hide) {
          return hideKeeperName;
        } else {
          return keeperName;
        }
      case 'storageup':
        return storageupName;
      case 'ups_update':
        if (hide) {
          return hideUpdateName;
        } else {
          return updateName;
        }
      default:
        return '';
    }
  }

  @override
  int killProcess(String processName) {
    var result = Process.runSync('Taskkill', ['/IM', processName, '/F']);
    return result.exitCode;
  }

  @override
  String getAppLocation() {
    var result = Process.runSync('reg', [
      'query',
      'HKCU${Platform.pathSeparator}Software${Platform.pathSeparator}StorageUp',
      '/v',
      'DirPath'
    ]);
    if (result.exitCode == 0) {
      String dirPath = result.stdout.split(' ').last;
      return dirPath.substring(0, dirPath.length - 4);
    } else {
      return '';
    }
  }

  @override
  String setVersion(String version) {
    Process.runSync(
        'reg',
        'add HKCU${Platform.pathSeparator}Software${Platform.pathSeparator}StorageUp /v DisplayVersion /t REG_SZ /d $version /f'
            .split(' '));
    Process.runSync(
        'reg',
        'add HKCU${Platform.pathSeparator}SOFTWARE${Platform.pathSeparator}Microsoft${Platform.pathSeparator}Windows${Platform.pathSeparator}CurrentVersion${Platform.pathSeparator}Uninstall${Platform.pathSeparator}StorageUp /v DisplayVersion /t REG_SZ /d $version /f'
            .split(' '));
    File(appDirPath).writeAsString(version);
    return version;
  }

  @override
  void startProcess(String processName, bool hide,
      [List<String> args = const []]) {
    if (processName != 'storageup') {
      Process.runSync(
          'start /min $appDirPath${Platform.pathSeparator}${getAppName(processName, hide)}',
          args, runInShell: true);
    } else {
      Process.run(
          '$appDirPath${Platform.pathSeparator}${getAppName(processName, hide)}',
          args);
    }
  }

  @override
  int registerAppInOs(String appDirPath) {
    var result = Process.runSync('.${Platform.pathSeparator}install.bat', [
      '$appDirPath${Platform.pathSeparator}StorageUp${Platform.pathSeparator}'
    ]);
    return result.exitCode;
  }

  @override
  int createShortcuts(String appDirPath) {
    var result = Process.runSync('powershell.exe', [
      'cscript',
      '.${Platform.pathSeparator}create_shortcuts.vbs',
      '$appDirPath${Platform.pathSeparator}StorageUp'
    ]);
    return result.exitCode;
  }

  @override
  void enableAutoBoot(String processName) {
    Process.runSync(
        'reg',
        'add HKCU${Platform.pathSeparator}SOFTWARE${Platform.pathSeparator}Microsoft${Platform.pathSeparator}Windows${Platform.pathSeparator}CurrentVersion${Platform.pathSeparator}Run /v StorageUpKeeper /t REG_SZ /d $appDirPath$processName /f'
            .split(' '));
  }
}
