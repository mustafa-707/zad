import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/utils/conestants/firebase_collections.dart';

final contentLanguagesProvider =
    FutureProvider<List<QueryDocumentSnapshot<ContentLanguage>>>((ref) async {
  final languages = FirebaseCollections.languages.withConverter<ContentLanguage>(
    fromFirestore: (snapshot, _) => ContentLanguage.fromJson(snapshot.data()!),
    toFirestore: (lang, _) => lang.toJson(),
  );

  return await languages.get().then((value) => value.docs);
});
