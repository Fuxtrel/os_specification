abstract class OsSpecifications {
  String appDirPath = '';

  int killProcess(String processName);

  void startProcess(String processName, bool hide, [List<String> args = const []]);

  String getAppLocation();

  String setVersion(String version, String filePath);

  int registerAppInOs(String appDirPath);

  int createShortcuts(String appDirPath);

  void enableAutoBoot(String processName);
}
