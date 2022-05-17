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

  group('Set keeper hash', (){
    var os = OsSpecifications.getOs();

    test('register app', (){
      os.registerAppInOs('/home/${Platform.environment['User']}/StorageUp');
    });
    test('set', (){
      os.getKeeperHash();
      expect(File('/home/${Platform.environment['User']}/StorageUp/hash').existsSync(), true);
    });
    test('get', (){
      var hash = os.setKeeperHash('hash');
      expect(hash, 'hash');
    });
  });

}
