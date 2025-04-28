class AuthConfig {
  final String baseUrl;
  final String loginEndpoint;
  final String registerEndpoint;
  final String tokenLoginEndpoint;

  const AuthConfig({
    required this.baseUrl,
    required this.loginEndpoint,
    required this.registerEndpoint,
    required this.tokenLoginEndpoint,
  });
}
