part of artoo_client;

class ClientDetectDevice extends DeviceFace {
  
  String _user_agent;
  
  ClientDetectDevice({DeviceResolver deviceResolver}) {
    _user_agent = window.navigator.userAgent;
    
    this.init(_user_agent, new Map(), deviceResolver: deviceResolver);
  }
  
  String userAgent() {
    return _user_agent;
  }
  
}