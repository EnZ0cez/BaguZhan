import 'question_model.dart';

class WrongBookModel {
  final String id;
  final String userId;
  final String questionId;
  final QuestionModel? question;
  final int wrongCount;
  final DateTime lastWrongAt;
  final bool isMastered;
  final DateTime? masteredAt;

  const WrongBookModel({
    required this.id,
    required this.userId,
    required this.questionId,
    this.question,
    required this.wrongCount,
    required this.lastWrongAt,
    required this.isMastered,
    this.masteredAt,
  });

  factory WrongBookModel.fromJson(Map<String, dynamic> json) {
    return WrongBookModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      questionId: json['questionId'] as String,
      question: json['question'] != null
          ? QuestionModel.fromJson(json['question'] as Map<String, dynamic>)
          : null,
      wrongCount: json['wrongCount'] as int? ?? 1,
      lastWrongAt: DateTime.parse(json['lastWrongAt'] as String),
      isMastered: json['isMastered'] as bool? ?? false,
      masteredAt: json['masteredAt'] != null
          ? DateTime.parse(json['masteredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'questionId': questionId,
      'question': question?.toJson(),
      'wrongCount': wrongCount,
      'lastWrongAt': lastWrongAt.toIso8601String(),
      'isMastered': isMastered,
      'masteredAt': masteredAt?.toIso8601String(),
    };
  }

  WrongBookModel copyWith({
    String? id,
    String? userId,
    String? questionId,
    QuestionModel? question,
    int? wrongCount,
    DateTime? lastWrongAt,
    bool? isMastered,
    DateTime? masteredAt,
  }) {
    return WrongBookModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      questionId: questionId ?? this.questionId,
      question: question ?? this.question,
      wrongCount: wrongCount ?? this.wrongCount,
      lastWrongAt: lastWrongAt ?? this.lastWrongAt,
      isMastered: isMastered ?? this.isMastered,
      masteredAt: masteredAt ?? this.masteredAt,
    );
  }
}
