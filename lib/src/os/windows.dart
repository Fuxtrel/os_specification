import 'dart:convert';
import 'dart:io';
import 'os_spec.dart';
import 'package:win_api/win_api.dart';

class Windows extends OsSpecifications {
  late final WinApi winApi;
  String? dllLibPath;

  Windows({this.dllLibPath}) {
    String result = getAppLocation();
    if (result.isNotEmpty) {
      appDirPath = result;
      winApi = WinApi(pathToWinApiDll: (dllLibPath == null) ? '${appDirPath}lib_win_api.dll' : dllLibPath);
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
      return "${Directory.current.path}${Platform.pathSeparator}";
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
      case 'all_keeper':
        winApi.startProcess('${appDirPath}start_keeper.exe', args);
        break;
    }
  }

  @override
  int registerAppInOs(String appDirPath) {
    var result = Process.runSync(
        'start',
        '/min C:${Platform.pathSeparator}temp${Platform.pathSeparator}StorageUp${Platform.pathSeparator}install.bat'
                ' $appDirPath${Platform.pathSeparator}StorageUp${Platform.pathSeparator}'
            .split(' '),
        runInShell: true);
    appDirPath = getAppLocation();
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
  bool setKeeperHash(String mail, String hash) {
    try {
      var file = File('${appDirPath}hash');
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
