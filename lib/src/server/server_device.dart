part of artoo_server;

class ServerDetectDevice extends DeviceFace {
  
  String _user_agent;
  
  ServerDetectDevice(HttpRequest req, {DeviceResolver deviceResolver}) {
    _user_agent = req.headers.value("User-Agent");
    
    Map<String, List<String>> headers = new Map();
    req.headers.forEach((String key, List<String> values) {
      headers[key] = values;
    });
    
    this.init(_user_agent, headers, deviceResolver: deviceResolver);
  }
  
  String userAgent() {
    return _user_agent;
  }
  
}