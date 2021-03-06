import 'dart:io';
import 'package:os_specification/os_specification.dart';

abstract class OsSpecifications {
  String appDirPath = '';
  static String supportDir = '';
  static final Directory tmpDir = (Platform.isWindows)
      ? Directory("C:\\Temp\\StorageUp")
      : Directory(
          '${Directory.systemTemp.path}${Platform.pathSeparator}StorageUp');

  int killProcess(String processName);

  void startProcess(String processName, [List<String> args = const []]);

  String getAppLocation();

  bool setKeeperHash(String mail, String hash);

  String getKeeperHash();

  String setVersion(String version, String filePath);

  int registerAppInOs(String appDirPath);

  String? getKeeperVersion();

  String? getUiVersion();

  double getWinScreenScale({String? pathToDll}) {
    if (Platform.isWindows) {
      return Windows(dllLibPath: pathToDll).winApi.getScreenGian();
    } else {
      Exception("Not correct os to use [getWinScreenScale]");
      return -1;
    }
  }

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
      return Windows(dllLibPath: dllLibPath);
    } else if (Platform.isLinux) {
      return Linux();
    } else if (Platform.isMacOS) {
      return MacOs();
    } else {
      throw Exception();
    }
  }
}
