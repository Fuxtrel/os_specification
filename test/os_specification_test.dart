import 'package:os_specification/os_specification.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  // group('Starting processes', () {
  //   var os = Windows();
  //   os.appDirPath = 'C:\\StorageUp\\StorageUp\\';
  //   OsSpecifications OS = Windows();
  //   setUp(() {
  //   });
  //
  //   // test('Start storageup', () {
  //   //   os.startProcess('storageup');
  //   // });
  //
  //   test('Start storageup', () {
  //     var os1 = OsSpecifications.getOs();
  //     os1.startProcess('storageup');
  //   });
  //
  //   // test('Start ups_update', () {
  //   //   os.startProcess('update');
  //   // });
  // });

  group('Set keeper hash', () {
    var os = OsSpecifications.getOs();
    test('register app', () {
      os.registerAppInOs('/Users/${Platform.environment['USER']}/StorageUp/');
    });
    test('set', () {
      os.setKeeperHash('mail', 'hash');
      expect(
          File('/Users/${Platform.environment['USER']}/Library/Containers/com.example.upstorageDesktop/Data/Library/Application Support/com.example.upstorageDesktop/hash')
              .existsSync(),
          true);
    });
    test('get', () {
      var hash = os.getKeeperHash();
      expect(hash, 'hash');
    });
    test('tmp directory', (){
      print(OsSpecifications.tmpDir);
    });
  }, onPlatform: {
    "linux": [Skip('Its windows cases')],
    "windows": [Skip('Its windows cases')],
  });
}
