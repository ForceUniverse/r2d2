part of artoo_common;

abstract class DeviceFace {
  
  String userAgent();
  
  Device device;
  
  void init(String userAgent, Map<String, List<String>> headers, {DeviceResolver deviceResolver}) {
    if (deviceResolver==null) {
        deviceResolver = new LiteDeviceResolver();
    }    
    device = deviceResolver.resolveDevice(userAgent, headers);
  }
  
  bool isMobile() {
     return device.mobile;
  }
  
  bool isTablet() {
     return device.tablet;   
  }
  
  bool isDesktop() {
    return device.desktop;
  }
  
  bool blackberry() {
      return _find('blackberry') || _find('bb10') || _find('rim');
  }

  bool blackberryPhone() {
      return blackberry() && !_find('tablet');
  }

  bool blackberryTablet() {
      return blackberry() && _find('tablet');
  }
  
  bool windows() {
      return _find('windows');
  }

  bool windowsPhone() {
      return windows() && _find('phone');
  }

  bool windowsTablet() {
      return windows() && _find('touch');
  }
  
  bool android() {
    return _find("android");
  }
  
  bool androidPhone() {
    return android() && _find('mobile');
  }
  
  bool androidTablet() {
      return android() && !_find('mobile');
  }
  
  bool _find(needle) {
      return userAgent().indexOf(needle) != -1;
  }
}