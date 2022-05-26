import 'dart:io';

import 'package:os_specification/os_specification.dart';
import 'package:test/test.dart';

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
    // var env = Platform.environment;
    test('register app', () {
      os.registerAppInOs('/home/${Platform.environment['USER']}/StorageUp/');
    });
    test('set', () {
      os.setKeeperHash('mail', 'hash');
      expect(
          File('/home/${Platform.environment['USER']}/StorageUp/hash')
              .existsSync(),
          true);
    });
    test('get', () {
      var hash = os.getKeeperHash();
      expect(hash, 'hash');
    });
  });
}
