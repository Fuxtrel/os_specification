import 'dart:io';
import 'package:win_api/win_api.dart';
import 'package:os_specification/os_specification.dart';

abstract class OsSpecifications {
  String appDirPath = '';
  static String supportDir = '';

  int killProcess(String processName);

  void startProcess(String processName, [List<String> args = const []]);

  String getAppLocation();

  bool setKeeperHash(String hash);

  String getKeeperHash();

  String setVersion(String version, String filePath);

  int registerAppInOs(String appDirPath);

  int createShortCut(
      String pathToExe,
      String pathToShortcut,
      {
        List<String> args = const [],
        String description = '',
        int showMode = ShowMode.NORMAL,
        String workingDir = '',
        String iconPath = '',
        int iconIndex = 0,
      }
  );

  void enableAutoBoot(String processName);

  static OsSpecifications getOs({String? dllLibPath}){
    return Platform.isWindows ? Windows(dllLibPath: dllLibPath) : Linux();
  }
}

