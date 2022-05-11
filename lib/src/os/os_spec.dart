abstract class OsSpecifications {
  String appDirPath = '';

  int killProcess(String processName);

  void startProcess(String processName, [List<String> args = const []]);

  String getAppLocation();

  String setVersion(String version, String filePath);

  int registerAppInOs(String appDirPath);

  void enableAutoBoot(String processName);
}
