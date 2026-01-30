/// 单元进度数据模型
///
/// 定义学习单元和章节的进度信息
class UnitProgressModel {
  final String id;
  final String userId;
  final int unitNumber;
  final String unitName;
  final String unitTitle;
  final int totalParts;
  final int completedParts;
  final bool isCompleted;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final List<PartProgressModel> parts;
  final bool isLocked;

  const UnitProgressModel({
    required this.id,
    required this.userId,
    required this.unitNumber,
    required this.unitName,
    required this.unitTitle,
    required this.totalParts,
    this.completedParts = 0,
    this.isCompleted = false,
    this.isLocked = false,
    this.startedAt,
    this.completedAt,
    this.parts = const [],
  });

  factory UnitProgressModel.fromJson(Map<String, dynamic> json) {
    return UnitProgressModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      unitNumber: json['unitNumber'] as int,
      unitName: json['unitName'] as String,
      unitTitle: json['unitTitle'] as String,
      totalParts: json['totalParts'] as int,
      completedParts: json['completedParts'] as int? ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      parts: (json['parts'] as List<dynamic>?)
              ?.map(
                  (e) => PartProgressModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'unitNumber': unitNumber,
      'unitName': unitName,
      'unitTitle': unitTitle,
      'totalParts': totalParts,
      'completedParts': completedParts,
      'isCompleted': isCompleted,
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'parts': parts.map((e) => e.toJson()).toList(),
    };
  }

  UnitProgressModel copyWith({
    String? id,
    String? userId,
    int? unitNumber,
    String? unitName,
    String? unitTitle,
    int? totalParts,
    int? completedParts,
    bool? isCompleted,
    bool? isLocked,
    DateTime? startedAt,
    DateTime? completedAt,
    List<PartProgressModel>? parts,
  }) {
    return UnitProgressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      unitNumber: unitNumber ?? this.unitNumber,
      unitName: unitName ?? this.unitName,
      unitTitle: unitTitle ?? this.unitTitle,
      totalParts: totalParts ?? this.totalParts,
      completedParts: completedParts ?? this.completedParts,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      parts: parts ?? this.parts,
    );
  }

  /// 获取完成百分比
  double get completionPercent =>
      totalParts > 0 ? completedParts / totalParts : 0.0;

  /// 获取当前进行中的 Part
  PartProgressModel? get currentPart {
    if (parts.isEmpty) return null;
    return parts.firstWhere(
      (p) => !p.isCompleted,
      orElse: () => parts.last,
    );
  }

  /// 获取当前 Part 编号
  int get currentPartNumber {
    final part = currentPart;
    return part?.partNumber ?? 1;
  }
}

/// 章节进度数据模型
class PartProgressModel {
  final String id;
  final int partNumber;
  final String partName;
  final String topic;
  final int totalQuestions;
  final int answeredQuestions;
  final int correctAnswers;
  final bool isCompleted;
  final bool isLocked;
  final DateTime? startedAt;
  final DateTime? completedAt;

  const PartProgressModel({
    required this.id,
    required this.partNumber,
    required this.partName,
    required this.topic,
    required this.totalQuestions,
    this.answeredQuestions = 0,
    this.correctAnswers = 0,
    this.isCompleted = false,
    this.isLocked = false,
    this.startedAt,
    this.completedAt,
  });

  factory PartProgressModel.fromJson(Map<String, dynamic> json) {
    return PartProgressModel(
      id: json['id'] as String,
      partNumber: json['partNumber'] as int,
      partName: json['partName'] as String,
      topic: json['topic'] as String,
      totalQuestions: json['totalQuestions'] as int,
      answeredQuestions: json['answeredQuestions'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isLocked: json['isLocked'] as bool? ?? false,
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partNumber': partNumber,
      'partName': partName,
      'topic': topic,
      'totalQuestions': totalQuestions,
      'answeredQuestions': answeredQuestions,
      'correctAnswers': correctAnswers,
      'isCompleted': isCompleted,
      'isLocked': isLocked,
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  PartProgressModel copyWith({
    String? id,
    int? partNumber,
    String? partName,
    String? topic,
    int? totalQuestions,
    int? answeredQuestions,
    int? correctAnswers,
    bool? isCompleted,
    bool? isLocked,
    DateTime? startedAt,
    DateTime? completedAt,
  }) {
    return PartProgressModel(
      id: id ?? this.id,
      partNumber: partNumber ?? this.partNumber,
      partName: partName ?? this.partName,
      topic: topic ?? this.topic,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// 获取完成百分比
  double get completionPercent =>
      totalQuestions > 0 ? answeredQuestions / totalQuestions : 0.0;

  /// 获取正确率
  double get accuracyRate =>
      answeredQuestions > 0 ? correctAnswers / answeredQuestions : 0.0;

  /// 获取正确率百分比文本
  String get accuracyPercentage =>
      '${(accuracyRate * 100).toStringAsFixed(0)}%';
}

/// 预定义单元数据
class DefaultUnits {
  DefaultUnits._();

  /// 获取示例单元数据
  static List<UnitProgressModel> getSampleUnits(String userId) {
    return [
      UnitProgressModel(
        id: 'unit_1_$userId',
        userId: userId,
        unitNumber: 1,
        unitName: 'JavaScript 基础',
        unitTitle: 'Unit 1',
        totalParts: 10,
        completedParts: 7,
        startedAt: DateTime.now().subtract(const Duration(days: 30)),
        parts: _generateParts(1, 10, 7),
      ),
      UnitProgressModel(
        id: 'unit_2_$userId',
        userId: userId,
        unitNumber: 2,
        unitName: 'React 核心概念',
        unitTitle: 'Unit 2',
        totalParts: 8,
        completedParts: 0,
        isLocked: true,
        parts: _generateParts(2, 8, 0),
      ),
      UnitProgressModel(
        id: 'unit_3_$userId',
        userId: userId,
        unitNumber: 3,
        unitName: 'TypeScript 进阶',
        unitTitle: 'Unit 3',
        totalParts: 12,
        completedParts: 0,
        isLocked: true,
        parts: _generateParts(3, 12, 0),
      ),
    ];
  }

  static List<PartProgressModel> _generateParts(
    int unitNumber,
    int totalParts,
    int completedParts,
  ) {
    final topics = [
      '变量与作用域',
      '数据类型',
      '函数与闭包',
      '原型链',
      '异步编程',
      'ES6+ 特性',
      '事件循环',
      '模块化',
      '错误处理',
      '性能优化',
    ];

    return List.generate(totalParts, (index) {
      final isCompleted = index < completedParts;
      final isLocked = index > completedParts;

      return PartProgressModel(
        id: 'unit_${unitNumber}_part_${index + 1}',
        partNumber: index + 1,
        partName: 'Part ${index + 1}',
        topic: topics[index % topics.length],
        totalQuestions: 5 + (index % 3) * 2,
        answeredQuestions: isCompleted ? 5 + (index % 3) * 2 : 0,
        correctAnswers: isCompleted ? 4 + (index % 3) * 2 : 0,
        isCompleted: isCompleted,
        isLocked: isLocked,
        startedAt: isCompleted || index == completedParts
            ? DateTime.now().subtract(Duration(days: totalParts - index))
            : null,
        completedAt: isCompleted
            ? DateTime.now().subtract(Duration(days: totalParts - index - 1))
            : null,
      );
    });
  }
}
