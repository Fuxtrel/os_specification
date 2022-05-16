import 'package:os_specification/os_specification.dart';
import 'package:os_specification/src/os/os_spec.dart';
import 'package:test/test.dart';

void main() {
  group('Starting processes', () {
    var os = Windows();
    os.appDirPath = 'C:\\StorageUp\\StorageUp\\';
    OsSpecifications OS = Windows();
    setUp(() {});

    // test('Start storageup', () {
    //   os.startProcess('storageup');
    // });

    test('Start storageup', () {
      var os1 = OsSpecifications.getOs();
      os1.startProcess('storageup');
    });

    // test('Start ups_update', () {
    //   os.startProcess('update');
    // });
  });
}
