import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/features/storage/data/models/storage_item.dart';
import 'package:cooking_friend/features/storage/data/models/storage_item_modification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('modifyLstStorageItemDisplayed', () {
    test('Do nothing', () {
      //arrange
      StorageController controller = StorageController();
      List<StorageItemModification> lst = [];
      controller.updateLstStorageItemModification(lst);
      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem.length, 0);
    });

    test('Add one', () {
      //arrange
      StorageController controller = StorageController();
      List<StorageItemModification> lst = [];
      StorageItemModification item = StorageItemModification();
      item.id = 0;
      item.action = StorageManagementAction.add;
      item.item = StorageItem();
      lst.add(item);
      controller.updateLstStorageItemModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem.length, 1);
    });

    test('Delete one', (){
      //arrange
      StorageController controller = StorageController();
      List<StorageItemModification> lst = [];
      StorageItem itemToRemove = StorageItem();
      itemToRemove.id = 0;
      controller.lstStorageItem.add(itemToRemove);
      StorageItemModification item = StorageItemModification();
      item.id = 0;
      item.action = StorageManagementAction.delete;
      item.item = StorageItem();
      lst.add(item);
      controller.updateLstStorageItemModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem.length, 0);
    });

    test('Edit one', (){
      //arrange
      StorageController controller = StorageController();
      List<StorageItemModification> lst = [];
      StorageItem recipeToEdit = StorageItem();
      recipeToEdit.id = 0;
      recipeToEdit.name = "storage name";
      controller.lstStorageItem.add(recipeToEdit);
      StorageItemModification item = StorageItemModification();
      item.id = 0;
      item.action = StorageManagementAction.edit;
      item.item = StorageItem()..name = "modified name";
      lst.add(item);
      controller.updateLstStorageItemModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem[0].name, "modified name");
    });
  });
}
