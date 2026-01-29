class LearningProgressModel {
  final String id;
  final String userId;
  final int totalAnswered;
  final int totalCorrect;
  final double accuracyRate;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastAnsweredAt;

  const LearningProgressModel({
    required this.id,
    required this.userId,
    required this.totalAnswered,
    required this.totalCorrect,
    required this.accuracyRate,
    required this.currentStreak,
    required this.longestStreak,
    this.lastAnsweredAt,
  });

  factory LearningProgressModel.fromJson(Map<String, dynamic> json) {
    return LearningProgressModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      totalAnswered: json['totalAnswered'] as int? ?? 0,
      totalCorrect: json['totalCorrect'] as int? ?? 0,
      accuracyRate: (json['accuracyRate'] as num?)?.toDouble() ?? 0.0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastAnsweredAt: json['lastAnsweredAt'] != null
          ? DateTime.parse(json['lastAnsweredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'totalAnswered': totalAnswered,
      'totalCorrect': totalCorrect,
      'accuracyRate': accuracyRate,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastAnsweredAt': lastAnsweredAt?.toIso8601String(),
    };
  }

  LearningProgressModel copyWith({
    String? id,
    String? userId,
    int? totalAnswered,
    int? totalCorrect,
    double? accuracyRate,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastAnsweredAt,
  }) {
    return LearningProgressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalAnswered: totalAnswered ?? this.totalAnswered,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      accuracyRate: accuracyRate ?? this.accuracyRate,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastAnsweredAt: lastAnsweredAt ?? this.lastAnsweredAt,
    );
  }

  String get accuracyPercentage =>
      '${(accuracyRate * 100).toStringAsFixed(1)}%';
}
