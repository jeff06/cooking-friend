import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_modification_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('modifyLstStorageItemDisplayed', () {
    test('Do nothing', () {
      //arrange
      StorageGetx controller = StorageGetx();
      List<StorageItemModificationEntity> lst = [];
      controller.updateLstStorageItemModification(lst);
      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem.length, 0);
    });

    /*test('Add one', () {
      //arrange
      StorageController controller = StorageController();
      List<StorageItemModification> lst = [];
      StorageItemModification item = StorageItemModification();
      item.id = 0;
      item.action = StorageManagementAction.add;
      item.item = Storage();
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
      Storage itemToRemove = Storage();
      itemToRemove.id = 0;
      controller.lstStorageItem.add(itemToRemove);
      StorageItemModification item = StorageItemModification();
      item.id = 0;
      item.action = StorageManagementAction.delete;
      item.item = Storage();
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
      Storage recipeToEdit = Storage();
      recipeToEdit.id = 0;
      recipeToEdit.name = "storage name";
      controller.lstStorageItem.add(recipeToEdit);
      StorageItemModification item = StorageItemModification();
      item.id = 0;
      item.action = StorageManagementAction.edit;
      item.item = Storage()..name = "modified name";
      lst.add(item);
      controller.updateLstStorageItemModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem[0].name, "modified name");
    });*/
  });
}
