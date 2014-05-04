part of artoo_server;

class ServerDetectDevice extends DeviceFace {
  
  String _user_agent;
  
  ServerDetectDevice(HttpRequest req) {
    _user_agent = req.headers.value("User-Agent");
  }
  
  String userAgent() {
    return _user_agent;
  }
  
}