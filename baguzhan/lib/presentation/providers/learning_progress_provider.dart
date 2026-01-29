import 'package:flutter/foundation.dart';

import '../../data/models/learning_progress_model.dart';
import '../../data/repositories/user_progress_repository.dart';
import '../../network/api_exception.dart';

enum LearningProgressState { initial, loading, loaded, error }

class LearningProgressProvider extends ChangeNotifier {
  LearningProgressProvider(this._repository);

  final UserProgressRepository _repository;

  LearningProgressState _state = LearningProgressState.initial;
  String? _errorMessage;
  LearningProgressModel? _progress;
  String? _userId;

  LearningProgressState get state => _state;
  String? get errorMessage =>
      _state == LearningProgressState.error ? _errorMessage : null;
  LearningProgressModel? get progress => _progress;

  bool get isLoading => _state == LearningProgressState.loading;
  bool get hasData => _progress != null;

  // Convenience getters
  int get totalAnswered => _progress?.totalAnswered ?? 0;
  int get totalCorrect => _progress?.totalCorrect ?? 0;
  String get accuracyPercentage => _progress?.accuracyPercentage ?? '0.0%';
  int get currentStreak => _progress?.currentStreak ?? 0;
  int get longestStreak => _progress?.longestStreak ?? 0;

  void setUserId(String userId) {
    _userId = userId;
  }

  Future<void> loadProgress() async {
    if (_userId == null) {
      _errorMessage = '用户未登录';
      _state = LearningProgressState.error;
      notifyListeners();
      return;
    }

    _state = LearningProgressState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _repository.getLearningProgress(_userId!);
      _progress = data;
      _state = LearningProgressState.loaded;
    } catch (error) {
      _errorMessage = _parseError(error);
      _state = LearningProgressState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadProgress();
  }

  void clear() {
    _progress = null;
    _state = LearningProgressState.initial;
    _errorMessage = null;
    notifyListeners();
  }

  String _parseError(Object error) {
    if (error is ApiException) {
      return error.message;
    }
    return '加载失败，请稍后重试';
  }
}
