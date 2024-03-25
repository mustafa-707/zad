import 'package:cloud_firestore/cloud_firestore.dart';

typedef CollectionType = CollectionReference<Map<String, dynamic>>;

class FirebaseCollections {
  static final _firebase = FirebaseFirestore.instance;

  static const _languages = "languages";
  static const _users = "users";
  static const _categories = "categories";
  static const _articles = "articles";
  static const _banners = "banners";

  static CollectionType get languages => _firebase.collection(
        _languages,
      );

  static CollectionType get users => _firebase.collection(
        _users,
      );

  static CollectionType get categories => _firebase.collection(
        _categories,
      );

  static CollectionType get articles => _firebase.collection(
        _articles,
      );

  static CollectionType get banners => _firebase.collection(
        _banners,
      );
}
