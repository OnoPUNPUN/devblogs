int clculateReadingTime(String content) {
  final clean = content.trim();
  if (clean.isEmpty) return 1;
  final wordCount = clean.split(RegExp(r'\s+')).length;
  // Average reading speed: 225 words per minute
  final speed = wordCount / 225;
  return speed.ceil();
}
