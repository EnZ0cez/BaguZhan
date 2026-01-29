import 'package:flutter/foundation.dart';

import '../../data/models/wrong_book_model.dart';
import '../../data/repositories/user_progress_repository.dart';
import '../../network/api_exception.dart';

enum WrongBookState { initial, loading, loaded, error }

class WrongBookProvider extends ChangeNotifier {
  WrongBookProvider(this._repository);

  final UserProgressRepository _repository;

  WrongBookState _state = WrongBookState.initial;
  String? _errorMessage;
  List<WrongBookModel> _wrongBooks = [];
  String? _userId;

  WrongBookState get state => _state;
  String? get errorMessage =>
      _state == WrongBookState.error ? _errorMessage : null;
  List<WrongBookModel> get wrongBooks => _wrongBooks;
  List<WrongBookModel> get unmasteredWrongBooks =>
      _wrongBooks.where((wb) => !wb.isMastered).toList();
  List<WrongBookModel> get masteredWrongBooks =>
      _wrongBooks.where((wb) => wb.isMastered).toList();

  bool get isLoading => _state == WrongBookState.loading;
  bool get hasData => _wrongBooks.isNotEmpty;
  int get totalCount => _wrongBooks.length;
  int get unmasteredCount => unmasteredWrongBooks.length;
  int get masteredCount => masteredWrongBooks.length;

  void setUserId(String userId) {
    _userId = userId;
  }

  Future<void> loadWrongBooks() async {
    if (_userId == null) {
      _errorMessage = '用户未登录';
      _state = WrongBookState.error;
      notifyListeners();
      return;
    }

    _state = WrongBookState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _repository.getWrongBooks(userId: _userId!);
      _wrongBooks = data;
      _state = WrongBookState.loaded;
    } catch (error) {
      _errorMessage = _parseError(error);
      _state = WrongBookState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> markAsMastered(String wrongBookId) async {
    try {
      final updated = await _repository.markWrongBookAsMastered(wrongBookId);
      if (updated != null) {
        final index = _wrongBooks.indexWhere((wb) => wb.id == wrongBookId);
        if (index != -1) {
          _wrongBooks[index] = updated;
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (error) {
      _errorMessage = _parseError(error);
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteWrongBook(String wrongBookId) async {
    try {
      await _repository.deleteWrongBook(wrongBookId);
      _wrongBooks.removeWhere((wb) => wb.id == wrongBookId);
      notifyListeners();
      return true;
    } catch (error) {
      _errorMessage = _parseError(error);
      notifyListeners();
      return false;
    }
  }

  Future<void> refresh() async {
    await loadWrongBooks();
  }

  void clear() {
    _wrongBooks = [];
    _state = WrongBookState.initial;
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
