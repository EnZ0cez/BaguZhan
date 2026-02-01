/// 成就数据模型
///
/// 定义用户可获得的成就徽章
class AchievementModel {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int requiredValue;
  final AchievementType type;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int currentProgress;

  const AchievementModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.requiredValue,
    required this.type,
    this.isUnlocked = false,
    this.unlockedAt,
    this.currentProgress = 0,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      requiredValue: json['requiredValue'] as int,
      type: AchievementType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AchievementType.streak,
      ),
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'] as String)
          : null,
      currentProgress: json['currentProgress'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'requiredValue': requiredValue,
      'type': type.name,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'currentProgress': currentProgress,
    };
  }

  AchievementModel copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    int? requiredValue,
    AchievementType? type,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? currentProgress,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      requiredValue: requiredValue ?? this.requiredValue,
      type: type ?? this.type,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      currentProgress: currentProgress ?? this.currentProgress,
    );
  }

  /// 获取进度百分比 (0.0 - 1.0)
  double get progressPercent =>
      (currentProgress / requiredValue).clamp(0.0, 1.0);

  /// 获取进度文本，如 "5/10"
  String get progressText => '$currentProgress/$requiredValue';

  /// 获取剩余需要完成的值
  int get remaining =>
      (requiredValue - currentProgress).clamp(0, requiredValue);
}

/// 成就类型枚举
enum AchievementType {
  /// 连续答题相关
  streak,

  /// 答题总数相关
  questions,

  /// 正确率相关
  accuracy,

  /// 等级相关
  level,

  /// 特殊成就
  special,
}

/// 预定义成就列表
class DefaultAchievements {
  DefaultAchievements._();

  /// 连续3天
  static AchievementModel get streak3 => const AchievementModel(
        id: 'streak_3',
        name: '初出茅庐',
        description: '连续学习3天',
        icon: '🔥',
        requiredValue: 3,
        type: AchievementType.streak,
      );

  /// 连续7天
  static AchievementModel get streak7 => const AchievementModel(
        id: 'streak_7',
        name: '坚持不懈',
        description: '连续学习7天',
        icon: '🔥',
        requiredValue: 7,
        type: AchievementType.streak,
      );

  /// 连续30天
  static AchievementModel get streak30 => const AchievementModel(
        id: 'streak_30',
        name: '学习达人',
        description: '连续学习30天',
        icon: '🏆',
        requiredValue: 30,
        type: AchievementType.streak,
      );

  /// 答题100道
  static AchievementModel get questions100 => const AchievementModel(
        id: 'questions_100',
        name: '百题斩',
        description: '累计答题100道',
        icon: '📚',
        requiredValue: 100,
        type: AchievementType.questions,
      );

  /// 答题500道
  static AchievementModel get questions500 => const AchievementModel(
        id: 'questions_500',
        name: '题海战术',
        description: '累计答题500道',
        icon: '📚',
        requiredValue: 500,
        type: AchievementType.questions,
      );

  /// 答题1000道
  static AchievementModel get questions1000 => const AchievementModel(
        id: 'questions_1000',
        name: '千题王',
        description: '累计答题1000道',
        icon: '👑',
        requiredValue: 1000,
        type: AchievementType.questions,
      );

  /// 正确率90%
  static AchievementModel get accuracy90 => const AchievementModel(
        id: 'accuracy_90',
        name: '精准打击',
        description: '正确率达到90%',
        icon: '🎯',
        requiredValue: 90,
        type: AchievementType.accuracy,
      );

  /// 达到5级
  static AchievementModel get level5 => const AchievementModel(
        id: 'level_5',
        name: '进阶开发者',
        description: '达到等级5',
        icon: '⭐',
        requiredValue: 5,
        type: AchievementType.level,
      );

  /// 达到10级
  static AchievementModel get level10 => const AchievementModel(
        id: 'level_10',
        name: '高级工程师',
        description: '达到等级10',
        icon: '🚀',
        requiredValue: 10,
        type: AchievementType.level,
      );

  /// 首次错题复习
  static AchievementModel get firstReview => const AchievementModel(
        id: 'first_review',
        name: '温故知新',
        description: '首次复习错题',
        icon: '🔄',
        requiredValue: 1,
        type: AchievementType.special,
      );

  /// 获得所有默认成就
  static List<AchievementModel> get all => [
        streak3,
        streak7,
        streak30,
        questions100,
        questions500,
        questions1000,
        accuracy90,
        level5,
        level10,
        firstReview,
      ];
}
