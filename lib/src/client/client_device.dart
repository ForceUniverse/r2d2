part of artoo_client;

class ClientDetectDevice extends DeviceFace {
  
  String _user_agent;
  
  ClientDetectDevice() {
    _user_agent = window.navigator.userAgent;
  }
  
  String userAgent() {
    return _user_agent;
  }
  
}