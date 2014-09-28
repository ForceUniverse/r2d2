part of artoo_common;

class SimpleDevice extends DeviceFace {
  
  String user_agent;
  
  SimpleDevice(this.user_agent);
  
  String userAgent() {
    return user_agent;
  }
  
}