String formatNumber(int value) {
  if (value >= 10) {
    return '$value';
  }
  return '0$value';
}
