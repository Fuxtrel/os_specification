import 'dart:io';
import 'os_spec.dart';
import 'package:win_api/win_api.dart';

class Windows extends OsSpecifications {
  static const String keeperName = 'keeper.exe';
  static const String hideKeeperName = 'start_keeper.exe';
  static const String storageupName = 'storageup.exe';
  static const String updateName = 'ups_update.exe';
  static const String hideUpdateName = 'start_ups_update.vbs';

  var win_api = WinApi();

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
    var result = Process.runSync('reg', 'query HKCU${Platform.pathSeparator}Software${Platform.pathSeparator}StorageUp /v DirPath'.split(' '));
    if (result.exitCode == 0) {
      String dirPath = result.stdout.split(' ').last;
      return dirPath.substring(0, dirPath.length - 4);
    } else {
      return '';
    }
  }

  @override
  String setVersion(String version, String filePath) {
    Process.runSync('reg', 'add HKCU${Platform.pathSeparator}Software${Platform.pathSeparator}StorageUp /v DisplayVersion /t REG_SZ /d $version /f'.split(' '));
    Process.runSync(
        'reg',
        'add HKCU${Platform.pathSeparator}SOFTWARE${Platform.pathSeparator}Microsoft${Platform.pathSeparator}Windows${Platform.pathSeparator}CurrentVersion${Platform.pathSeparator}Uninstall${Platform.pathSeparator}StorageUp /v DisplayVersion /t REG_SZ /d $version /f'
            .split(' '));
    File(filePath).writeAsString(version);
    return version;
  }

  @override
  void startProcess(String processName, [List<String> args = const []]) async {
    switch(processName){
      case 'update':
        win_api.startProcess('${appDirPath}ups_update.exe', args);
        break;
      case 'keeper':
        win_api.startProcess('${appDirPath}keeper.exe', args);
        break;
      case 'storageup':
        win_api.startProcess('${appDirPath}storageup.exe', args);
        break;
    }
  }

  @override
  int registerAppInOs(String appDirPath) {
    var result = Process.runSync(
        'start',
        '/min C:${Platform.pathSeparator}temp${Platform.pathSeparator}StorageUp${Platform.pathSeparator}install.bat $appDirPath${Platform.pathSeparator}StorageUp${Platform.pathSeparator}'
            .split(' '),
        runInShell: true);
    return result.exitCode;
  }

  @override
  int createShortcuts(String appDirPath) {
    var result = Process.runSync('start /min cscript',
        ['C:${Platform.pathSeparator}temp${Platform.pathSeparator}StorageUp${Platform.pathSeparator}create_shortcuts.vbs', '$appDirPath${Platform.pathSeparator}StorageUp'],
        runInShell: true);
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
