class ModerationItem {
  final String name;
  final String parentName;
  final double confidence;

  ModerationItem({
    required this.name,
    required this.parentName,
    required this.confidence,
  });

  factory ModerationItem.fromJson(Map<String, dynamic> json) {
    return ModerationItem(
      name: json["name"],
      parentName: json["parentName"],
      confidence: (json["confidence"] as num).toDouble(),
    );
  }
}
