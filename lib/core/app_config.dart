// App-wide configuration constants and settings
class AppConfig {
  static const String appName = 'Fitness App';
  static const String appVersion = '1.0.0';
  
  // API configurations
  static const String apiBaseUrl = 'https://api.example.com';
  
  // Feature flags
  static const bool isDarkModeEnabled = true;
  static const bool isDebugMode = true;
  
  // Timeout configurations
  static const int timeoutDuration = 30; // in seconds
  
  // Cache configurations
  static const int maxCacheAge = 7; // in days
  
  private AppConfig._();
}