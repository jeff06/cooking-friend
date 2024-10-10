import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_modification_entity.dart';
import 'package:cooking_friend/skeleton/constants.dart';
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

    test('Add one', () {
      //arrange
      StorageGetx controller = StorageGetx();
      List<StorageItemModificationEntity> lst = [];
      StorageItemModificationEntity item = StorageItemModificationEntity();
      item.id = 0;
      item.action = StorageManagementAction.add;
      item.item = StorageEntity(null, null, null, null, null, null);
      lst.add(item);
      controller.updateLstStorageItemModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem.length, 1);
    });

    test('Delete one', () {
      //arrange
      StorageGetx controller = StorageGetx();
      List<StorageItemModificationEntity> lst = [];
      StorageEntity itemToRemove = StorageEntity(null, null, null, null, null, null);
      itemToRemove.id = 0;
      controller.lstStorageItem.add(itemToRemove);
      StorageItemModificationEntity item = StorageItemModificationEntity();
      item.id = 0;
      item.action = StorageManagementAction.delete;
      item.item = StorageEntity(null, null, null, null, null, null);
      lst.add(item);
      controller.updateLstStorageItemModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem.length, 0);
    });

    test('Edit one', () {
      //arrange
      StorageGetx controller = StorageGetx();
      List<StorageItemModificationEntity> lst = [];
      StorageEntity recipeToEdit = StorageEntity(null, null, null, null, null, null);
      recipeToEdit.id = 0;
      recipeToEdit.name = "storage name";
      controller.lstStorageItem.add(recipeToEdit);
      StorageItemModificationEntity item = StorageItemModificationEntity();
      item.id = 0;
      item.action = StorageManagementAction.edit;
      item.item = StorageEntity("modified name", null, null, null, null, null);
      lst.add(item);
      controller.updateLstStorageItemModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstStorageItem[0].name, "modified name");
    });
  });
}
