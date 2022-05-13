import 'package:os_specification/os_specification.dart';
import 'package:test/test.dart';

void main() {
  group('Starting processes', () {
    var os = Windows();
    os.appDirPath = 'C:\\StorageUp\\StorageUp\\';

    setUp(() {});

    test('Start storageup', () {
      os.startProcess('storageup');
    });
    //
    // test('Start ups_update', () {
    //   os.startProcess('update');
    // });
  });
}
