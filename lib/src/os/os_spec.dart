import 'dart:io';
import 'package:os_specification/os_specification.dart';

abstract class OsSpecifications {
  String appDirPath = '';
  static String supportDir = '';
  static final Directory tmpDir = (Platform.isWindows)
      ? Directory("C:\\Temp\\StorageUp")
      : Directory('${Directory.systemTemp.path}${Platform.pathSeparator}StorageUp');

  int killProcess(String processName);

  void startProcess(String processName, [List<String> args = const []]);

  String getAppLocation();

  bool setKeeperHash(String hash);

  String getKeeperHash();

  String setVersion(String version, String filePath);

  int registerAppInOs(String appDirPath);

  int createShortCut(
    String pathToExe,
    String pathToShortcut, {
    List<String> args = const [],
    String description = '',
    int showMode = ShowMode.NORMAL,
    String workingDir = '',
    String iconPath = '',
    int iconIndex = 0,
  });

  void enableAutoBoot(String processName);

  static OsSpecifications getOs({String? dllLibPath}) {
    if (Platform.isWindows) {
      return Windows(dllLibPath: dllLibPath ?? "${OsSpecifications.tmpDir.path}\\lib_win_api.dll");
    } else if (Platform.isLinux) {
      return Linux();
    } else if (Platform.isMacOS) {
      return MacOs();
    } else {
      throw Exception();
    }
  }
}
