import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/auth/items/items_repository.dart';

import '../../../models/item.dart';
import '../../../util/show_messages.dart';

final itemsControllerProvider = StateNotifierProvider.autoDispose<ItemsController, bool>((ref) {
  final itemsRepository = ref.watch(itemsRepositoryProvider);
  final personalId = ref.read(personProvider)!.uid;
  return ItemsController(itemsRepository: itemsRepository, personalId: personalId);
});

class ItemsController extends StateNotifier<bool> {
  final ItemsRepository _itemsRepository;
  final String _personalId;

  ItemsController({required ItemsRepository itemsRepository, required String personalId}) : _itemsRepository = itemsRepository, _personalId = personalId,super(false);

  Future<void> postItem(String itemName, BuildContext context, String userComment) async {
    state = true;

    final newItem = Item(name: itemName, agreement: [_personalId], disagreement: []);
    final result = await _itemsRepository.postItem(newItem);
    state = false;

    result.fold((l) => showSnackyBar(context, l.message), (r) {
      showSnackyBar(context, 'Thank You!');
    });
  }

  void agree(String itemId) => _itemsRepository.agree(itemId, _personalId);
  void disagree(String itemId) => _itemsRepository.disagree(itemId, _personalId);
  void unAgree(String itemId) => _itemsRepository.unAgree(itemId, _personalId);
  void unDisagree(String itemId) => _itemsRepository.unDisagree(itemId, _personalId);

  void delete(String itemId) => _itemsRepository.delete(itemId);
}
