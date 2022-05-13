import 'dart:io';
import 'package:win_api/win_api.dart';
import 'package:os_specification/os_specification.dart';

abstract class OsSpecifications {
  String appDirPath = '';

  int killProcess(String processName);

  void startProcess(String processName, [List<String> args = const []]);

  String getAppLocation();

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
}

OsSpecifications getOs(){
  return Platform.isWindows ? Windows() : Linux();
}