part of artoo_common;

/**
 * A "lightweight" device resolver algorithm based on Wordpress's Mobile pack. Detects the
 * presence of a mobile device and works for a large percentage of mobile browsers. Does
 * not perform any device capability mapping, if you need that consider WURFL.
 * 
 * The code is based primarily on a list of approximately 90 well-known mobile browser UA
 * string snippets, with a couple of special cases for Opera Mini, the W3C default
 * delivery context and certain other Windows browsers. The code also looks to see if the
 * browser advertises WAP capabilities as a hint.
 * 
 * Tablet resolution is also performed based on known tablet browser UA strings. Android
 * tablets are detected based on <a href=
 * "http://googlewebmastercentral.blogspot.com/2011/03/mo-better-to-also-detect-mobile-user.html"
 * >Google's recommendations</a>.
 */
class LiteDeviceResolver implements DeviceResolver {

  final List<String> mobileUserAgentPrefixes = new List<String>();

  final List<String> mobileUserAgentKeywords = new List<String>();

  final List<String> tabletUserAgentKeywords = new List<String>();

  final List<String> normalUserAgentKeywords = new List<String>();

  LiteDeviceResolver({List<String> normalUserAgentKeywords}) {
    init();
    if (normalUserAgentKeywords!=null) {
      this.normalUserAgentKeywords.addAll(normalUserAgentKeywords);
    }
  }

  Device resolveDevice(String userAgent, Map<String, List<String>> headers) {
    // UserAgent keyword detection of Normal devices
    Device device = new Device(false, false, true);
    if (userAgent != null) {
      userAgent = userAgent.toLowerCase();
      for (String keyword in normalUserAgentKeywords) {
        if (userAgent.contains(keyword)) {
          device = new Device(false, false, true);
        }
      }
    }
    // UserAgent keyword detection of Tablet devices
    if (userAgent != null) {
      userAgent = userAgent.toLowerCase();
      // Android special case
      if (userAgent.contains("android") && !userAgent.contains("mobile")) {
        return new Device(false, true, false);
      }
      // Kindle Fire special case
      if (userAgent.contains("silk") && !userAgent.contains("mobile")) {
        return new Device(false, true, false);
      }
      for (String keyword in tabletUserAgentKeywords) {
        if (userAgent.contains(keyword)) {
          return new Device(false, true, false);
        }
      }
    }
    // UAProf detection
    if (headers.containsKey("x-wap-profile")
        || headers.containsKey("Profile")) {
      return new Device(true, false, false);
    }
    // User-Agent prefix detection
    if (userAgent != null && userAgent.length >= 4) {
      String prefix = userAgent.substring(0, 4).toLowerCase();
      if (mobileUserAgentPrefixes.contains(prefix)) {
        return new Device(true, false, false);
      }
    }
    // Accept-header based detection
    List lstAccept = headers["Accept"];
    if (lstAccept != null) {
      String accept = lstAccept.first;
      if (accept != null && accept.contains("wap")) {
        return new Device(true, false, false);
      }
    }
    // UserAgent keyword detection for Mobile devices
    if (userAgent != null) {
      for (String keyword in mobileUserAgentKeywords) {
        if (userAgent.contains(keyword)) {
          return new Device(true, false, false);
        }
      }
    }
    
    return device;
  }

  /**
   * List of user agent prefixes that identify mobile devices. Used primarily to match
   * by operator or handset manufacturer.
   */
  List<String> getMobileUserAgentPrefixes() {
    return mobileUserAgentPrefixes;
  }

  /**
   * List of user agent keywords that identify mobile devices. Used primarily to match
   * by mobile platform or operating system.
   */
  List<String> getMobileUserAgentKeywords() {
    return mobileUserAgentKeywords;
  }

  /**
   * List of user agent keywords that identify tablet devices. Used primarily to match
   * by tablet platform or operating system.
   */
  List<String> getTabletUserAgentKeywords() {
    return tabletUserAgentKeywords;
  }

  /**
   * List of user agent keywords that identify normal devices. Any items in this list
   * take precedence over the mobile and tablet user agent keywords, effectively
   * overriding those.
   */
  List<String> getNormalUserAgentKeywords() {
    return normalUserAgentKeywords;
  }

  /**
   * Initialize this device resolver implementation. Registers the known set of device
   * signature strings. Subclasses may override to register additional strings.
   */
  void init() {
    getMobileUserAgentPrefixes().addAll(KNOWN_MOBILE_USER_AGENT_PREFIXES);
    getMobileUserAgentKeywords().addAll(KNOWN_MOBILE_USER_AGENT_KEYWORDS);
    getTabletUserAgentKeywords().addAll(KNOWN_TABLET_USER_AGENT_KEYWORDS);
  }

  // internal helpers
  static final List KNOWN_MOBILE_USER_AGENT_PREFIXES = [
      "w3c ", "w3c-", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq",
      "bird", "blac", "blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco",
      "eric", "hipt", "htc_", "inno", "ipaq", "ipod", "jigs", "kddi", "keji",
      "leno", "lg-c", "lg-d", "lg-g", "lge-", "lg/u", "maui", "maxo", "midp",
      "mits", "mmef", "mobi", "mot-", "moto", "mwbp", "nec-", "newt", "noki",
      "palm", "pana", "pant", "phil", "play", "port", "prox", "qwap", "sage",
      "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-",
      "siem", "smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-",
      "tosh", "tsm-", "upg1", "upsi", "vk-v", "voda", "wap-", "wapa", "wapi",
      "wapp", "wapr", "webc", "winw", "winw", "xda ", "xda-"];

  static final List KNOWN_MOBILE_USER_AGENT_KEYWORDS = [
      "blackberry", "webos", "ipod", "lge vx", "midp", "maemo", "mmp", "mobile",
      "netfront", "hiptop", "nintendo DS", "novarra", "openweb", "opera mobi",
      "opera mini", "palm", "psp", "phone", "smartphone", "symbian", "up.browser",
      "up.link", "wap", "windows ce"];

  static final List KNOWN_TABLET_USER_AGENT_KEYWORDS = [
      "ipad", "playbook", "hp-tablet", "kindle"];

}
