/// 等级计算工具类
class LevelCalculator {
  LevelCalculator._();

  /// 每级所需经验值基数
  static const int baseXpPerLevel = 100;

  /// 等级增长系数
  static const double levelGrowthFactor = 1.2;

  /// 根据总正确答题数计算等级
  static int calculateLevel(int totalCorrect) {
    if (totalCorrect <= 0) return 1;

    int level = 1;
    int xpNeeded = baseXpPerLevel;
    int remainingXp = totalCorrect * 10; // 每道正确题目 = 10 XP

    while (remainingXp >= xpNeeded) {
      remainingXp -= xpNeeded;
      level++;
      xpNeeded = (xpNeeded * levelGrowthFactor).round();
    }

    return level;
  }

  /// 获取当前等级的经验值需求
  static int getXpForLevel(int level) {
    if (level <= 1) return 0;

    int totalXp = 0;
    int xpNeeded = baseXpPerLevel;

    for (int i = 1; i < level; i++) {
      totalXp += xpNeeded;
      xpNeeded = (xpNeeded * levelGrowthFactor).round();
    }

    return totalXp;
  }

  /// 获取升级到下一级所需的经验值
  static int getXpForNextLevel(int currentLevel) {
    int xpNeeded = baseXpPerLevel;
    for (int i = 1; i < currentLevel; i++) {
      xpNeeded = (xpNeeded * levelGrowthFactor).round();
    }
    return xpNeeded;
  }

  /// 获取当前等级的进度 (0.0 - 1.0)
  static double getLevelProgress(int totalCorrect, int currentLevel) {
    final xpForCurrentLevel = getXpForLevel(currentLevel);
    final xpForNextLevel = getXpForLevel(currentLevel + 1);
    final currentXp = totalCorrect * 10;

    if (xpForNextLevel <= xpForCurrentLevel) return 1.0;

    return ((currentXp - xpForCurrentLevel) /
            (xpForNextLevel - xpForCurrentLevel))
        .clamp(0.0, 1.0);
  }

  /// 获取等级称号
  static String getLevelTitle(int level) {
    if (level >= 50) return '传说开发者';
    if (level >= 40) return '架构大师';
    if (level >= 30) return '技术专家';
    if (level >= 20) return '高级工程师';
    if (level >= 10) return '中级开发者';
    if (level >= 5) return '初级开发者';
    return '编程新手';
  }
}

class LearningProgressModel {
  final String id;
  final String userId;
  final int totalAnswered;
  final int totalCorrect;
  final double accuracyRate;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastAnsweredAt;
  final int level;
  final int xp;

  const LearningProgressModel({
    required this.id,
    required this.userId,
    required this.totalAnswered,
    required this.totalCorrect,
    required this.accuracyRate,
    required this.currentStreak,
    required this.longestStreak,
    this.lastAnsweredAt,
    this.level = 1,
    this.xp = 0,
  });

  factory LearningProgressModel.fromJson(Map<String, dynamic> json) {
    final totalCorrect = json['totalCorrect'] as int? ?? 0;
    final calculatedLevel = LevelCalculator.calculateLevel(totalCorrect);

    return LearningProgressModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      totalAnswered: json['totalAnswered'] as int? ?? 0,
      totalCorrect: totalCorrect,
      accuracyRate: (json['accuracyRate'] as num?)?.toDouble() ?? 0.0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastAnsweredAt: json['lastAnsweredAt'] != null
          ? DateTime.parse(json['lastAnsweredAt'] as String)
          : null,
      level: json['level'] as int? ?? calculatedLevel,
      xp: json['xp'] as int? ?? totalCorrect * 10,
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
      'level': level,
      'xp': xp,
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
    int? level,
    int? xp,
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
      level: level ?? this.level,
      xp: xp ?? this.xp,
    );
  }

  /// 获取等级进度百分比 (0.0 - 1.0)
  double get levelProgress =>
      LevelCalculator.getLevelProgress(totalCorrect, level);

  /// 获取当前等级称号
  String get levelTitle => LevelCalculator.getLevelTitle(level);

  /// 获取升级到下一级所需的经验值
  int get xpForNextLevel => LevelCalculator.getXpForNextLevel(level);

  /// 获取当前等级已获得的经验值
  int get xpInCurrentLevel => xp - LevelCalculator.getXpForLevel(level);

  String get accuracyPercentage =>
      '${(accuracyRate * 100).toStringAsFixed(1)}%';
}
