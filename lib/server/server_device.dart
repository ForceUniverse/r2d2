part of artoo_server;

class ServerDevice extends DeviceFace {
  
  String _user_agent;
  
  ServerDevice(HttpRequest req) {
    _user_agent = req.headers.value("User-Agent");
  }
  
  String userAgent() {
    return _user_agent;
  }
  
}