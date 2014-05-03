part of artoo_client;

class ClientDevice extends DeviceFace {
  
  String _user_agent;
  
  ClientDevice() {
    _user_agent = window.navigator.userAgent;
  }
  
  String userAgent() {
    return _user_agent;
  }
  
}