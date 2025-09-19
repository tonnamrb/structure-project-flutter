enum RegisterChannel {
  email,
  phone,
  google,
  facebook,
}

extension RegisterChannelAsset on RegisterChannel {
  String get assetKey {
    switch (this) {
      case RegisterChannel.email:
        return 'register.email';
      case RegisterChannel.phone:
        return 'register.phone';
      case RegisterChannel.google:
        return 'register.google';
      case RegisterChannel.facebook:
        return 'register.facebook';
    }
  }
}
