import 'package:digitalpaca/model/series.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Series> _words = new List.empty(growable: true);
  List<Series> get words => _words;
  List<Series> get id => _words;
  List<int> _ids = new List.empty(growable: true);

  void toggleFavorite(Series word, int id) {
    final isExist = _words.contains(word);
    final isExistId = _ids.contains(id);
    if (isExistId) {
      _words.remove(word);
      _ids.remove(id);
    } else {
      _ids.add(word.id);
      _words.add(word);
    }

    notifyListeners();
  }

  bool isExist(Series word) {
    final isExist = _words.contains(word);
    return isExist;
  }

  bool isExistId(int id) {
    final isExist = _ids.contains(id);
    return isExist;
  }

  void clearFavorite() {
    _words = [];
    _ids = [];
    notifyListeners();
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
