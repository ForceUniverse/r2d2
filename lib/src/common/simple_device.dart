part of artoo_common;

class SimpleDevice extends DeviceFace {
  
  String user_agent;
  
  SimpleDevice(this.user_agent) {
    this.init(user_agent, new Map(), deviceResolver: new LiteDeviceResolver());
  }
  
  void newUserAgent(String user_agent) {
    this.user_agent = user_agent;
    this.init(this.user_agent, new Map(), deviceResolver: new LiteDeviceResolver());
  }
  
  String userAgent() {
    return user_agent;
  }
  
}