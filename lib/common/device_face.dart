part of artoo_common;

abstract class DeviceFace {
  
  String userAgent();
  
  bool isMobile() {
     return _find("iphone") || androidPhone() || _find("mobile") || _find("meego") || _find("phone") || blackberryPhone();
  }
  
  bool isTablet() {
     return windowsTablet() || blackberryTablet() || androidTablet() || _find('ipad') || _find('tablet') ;   
  }
  
  bool isDesktop() {
    return !isMobile() || !isTablet();
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
    return android && _find('mobile');
  }
  
  bool androidTablet() {
      return android() && !_find('mobile');
  }
  
  bool _find(needle) {
      return userAgent().indexOf(needle) != -1;
  }
}