enum SubscriptionTier {
  free,
  vip;

  bool get isVip => this == SubscriptionTier.vip;
}
