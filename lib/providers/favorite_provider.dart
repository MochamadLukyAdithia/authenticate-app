import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteId = [];
  List<String> get favorites => _favoriteId;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FavoriteProvider() {
    loadFavorite();
  }
  void togglerFavorite(DocumentSnapshot lesson) async {
    String lessonId = lesson.id;
    if (_favoriteId.contains(lessonId)) {
      _favoriteId.remove(lessonId);
      await _removeFavorite(lessonId);
    } else {
      _favoriteId.add(lessonId);
      await _addFavorite(lessonId);
    }
    notifyListeners();
  }

  bool isExist(DocumentSnapshot lesson) {
    return _favoriteId.contains(lesson.id);
  }

  Future<void> _addFavorite(String lessonId) async {
    try {
      await firestore
          .collection('favorites')
          .doc(lessonId)
          .set({'isFavorite': true});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _removeFavorite(String lessonId) async {
    try {
      await firestore.collection('favorites').doc(lessonId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadFavorite() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('favorites').get();
      _favoriteId = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
