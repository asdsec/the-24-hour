enum NetworkPaths {
  signInWithPassword(_accounts),
  signUp(_accounts);

  const NetworkPaths(this._prePath);

  final String _prePath;
  final String _version = '/v1/';
  static const String _accounts = 'accounts:';

  String get rawValue => _version + _prePath + name;
}
