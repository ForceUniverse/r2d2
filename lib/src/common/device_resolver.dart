part of artoo_common;

abstract class DeviceResolver {
  
  Device resolveDevice(String userAgent, Map<String, String> headers);
  
}