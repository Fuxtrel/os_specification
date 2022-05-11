import 'dart:io';
import 'os_spec.dart';
import 'package:win_api/win_api.dart';

class Windows extends OsSpecifications {
  var winApi = WinApi();

  Windows() {
    String result = getAppLocation();
    if (result.isNotEmpty) {
      appDirPath = result;
    }
  }

  @override
  int killProcess(String processName) {
    var result = Process.runSync('Taskkill', ['/IM', processName, '/F']);
    return result.exitCode;
  }

  @override
  String getAppLocation() {
    var result = Process.runSync(
        'reg', 'query HKCU${Platform.pathSeparator}Software${Platform.pathSeparator}StorageUp /v DirPath'.split(' '));
    if (result.exitCode == 0) {
      String dirPath = result.stdout.split(' ').last;
      return dirPath.trim();
    } else {
      return '';
    }
  }

  @override
  String setVersion(String version, String filePath) {
    Process.runSync(
        'reg',
        'add HKCU${Platform.pathSeparator}Software${Platform.pathSeparator}StorageUp /v DisplayVersion /t REG_SZ /d $version /f'
            .split(' '));
    Process.runSync(
        'reg',
        'add HKCU${Platform.pathSeparator}SOFTWARE${Platform.pathSeparator}Microsoft${Platform.pathSeparator}Windows${Platform.pathSeparator}CurrentVersion${Platform.pathSeparator}Uninstall${Platform.pathSeparator}StorageUp /v DisplayVersion /t REG_SZ /d $version /f'
            .split(' '));
    File(filePath).writeAsString(version);
    return version;
  }

  @override
  void startProcess(String processName, [List<String> args = const []]) async {
    switch (processName) {
      case 'update':
        winApi.startProcess('${appDirPath}ups_update.exe', args);
        break;
      case 'keeper':
        winApi.startProcess('${appDirPath}keeper.exe', args);
        break;
      case 'storageup':
        winApi.startProcess('${appDirPath}storageup.exe', args);
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
    winApi.createShortCut(
      pathToExe,
      pathToShortcut,
      args: args,
      description: description,
      iconIndex: iconIndex,
      iconPath: iconPath,
      showMode: showMode,
      workingDir: workingDir,
    );
    return 0;
  }

  @override
  void enableAutoBoot(String processName) {
    Process.runSync(
        'reg',
        'add HKCU${Platform.pathSeparator}SOFTWARE${Platform.pathSeparator}Microsoft${Platform.pathSeparator}Windows${Platform.pathSeparator}CurrentVersion${Platform.pathSeparator}Run /v StorageUpKeeper /t REG_SZ /d $appDirPath$processName /f'
            .split(' '));
  }
}
