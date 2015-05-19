import 'package:test/test.dart';
import 'package:r2d2/r2d2_common.dart';

main() {
  // First tests!
  SimpleDevice sd = new SimpleDevice("Mozilla/5.0(iPad; U; CPU iPhone OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B314 Safari/531.21.10");
  test('basic device detection test', () {
      expect(sd.isTablet(), true);
      expect(sd.isMobile(), false);
      expect(sd.isDesktop(), false);
  });

 test('test iphone', () {
    sd.newUserAgent("Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7");
      expect(sd.isTablet(), false);
      expect(sd.isMobile(), true);
      expect(sd.isDesktop(), false);
  });
}
