enum NetworkUrls {
  auth('https://identitytoolkit.googleapis.com'),
  token('https://securetoken.googleapis.com');

  const NetworkUrls(this.url);
  final String url;
}
