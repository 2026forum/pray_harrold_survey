import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../models/item.dart';
import '../../../util/firebase/firebase_providers.dart';
import '../../../util/type_defs.dart';

const kIssueAlreadyExists = "That is already on the board!";

final itemsFeedProvider = StreamProvider.autoDispose<List<Item>>((ref) {
  final itemsReaper = ref.watch(itemsRepositoryProvider);
  return itemsReaper.itemsFeed;
});

final itemsRepositoryProvider = Provider<ItemsRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return ItemsRepository(firestore: firestore);
});

class ItemsRepository {
  final FirebaseFirestore _firestore;
  // final
  ItemsRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _items => _firestore.collection('items');

  Stream<List<Item>> get itemsFeed =>
      _items.snapshots().map((event) => event.docs.map((e) => Item.fromMap(e.data() as Map<String, dynamic>)).toList());

  // bool _isDocumentExist(DocumentSnapshot document) {
  //   if (document.exists) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  FutureEitherFailureOr<void> postItem(Item item) async {
    try {
      // final document = await _items.doc("sam").snapshots().first;
      final document2 = await _items.doc("issueId").snapshots().first;
      print(document2);
      // if (_isDocumentExist(document)) {
      //   return left(Failure(kIssueAlreadyExists));
      // }
      await _items.doc("john").set(item.toMap());
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void agree(String itemId, String userId) async {
    await _items.doc(itemId).update({
      'agreement': FieldValue.arrayUnion([userId]),
    });
  }

  void unAgree(String itemId, String userId) async {
    await _items.doc(itemId).update({
      'agreement': FieldValue.arrayRemove([userId]),
    });
  }

  void disagree(String itemId, String userId) async {
    await _items.doc(itemId).update({
      'disagreement': FieldValue.arrayUnion([userId]),
    });
  }

  void unDisagree(String itemId, String userId) async {
    await _items.doc(itemId).update({
      'disagreement': FieldValue.arrayRemove([userId]),
    });
  }

  void delete(String itemId) async {
    await _items.doc(itemId).update({'comments': FieldValue.delete()});
    await _items.doc(itemId).delete();
  }
}
