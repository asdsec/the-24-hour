enum NetworkPaths {
  delete(_accounts),
  signInWithPassword(_accounts),
  signUp(_accounts);

  const NetworkPaths(this._prePath);

  final String _prePath;
  final String _version = '/v1/';
  static const String _accounts = 'accounts:';
  // TODO(sametdmr): the secret key might bbe given here

  String get rawValue => _version + _prePath + name;
}
