import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/business/use_cases/storage_use_case.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/global_widget/search_display_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorageViewRefresh extends StatefulWidget {
  final Future<void> refreshList;
  final StorageUseCase storageUseCase;
  final List<StorageEntity> currentStorages;
  final StorageGetx storageGetx;

  const StorageViewRefresh(this.refreshList, this.storageUseCase,
      this.currentStorages, this.storageGetx,
      {super.key});

  @override
  State<StorageViewRefresh> createState() => _StorageViewRefreshState();
}

class _StorageViewRefreshState extends State<StorageViewRefresh> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.refreshList,
      child: Obx(
        () {
          widget.storageUseCase.orderBy(widget.currentStorages);
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: widget.storageGetx.lstStorageItem.length,
            itemBuilder: (BuildContext context, int index) {
              String name =
                  widget.storageGetx.lstStorageItem[index].name.toString();
              String date =
                  widget.storageGetx.lstStorageItem[index].date.toString();
              int id = widget.storageGetx.lstStorageItem[index].id!;
              return SearchDisplayCard(
                () async =>
                    await widget.storageUseCase.clickOnCard(id, context),
                ListTile(
                  leading: const Icon(Icons.album),
                  title: ClipRect(
                    child:
                        Text(name, style: const TextStyle(color: Colors.black)),
                  ),
                  subtitle: ClipRect(
                    child: date == "null"
                        ? Container()
                        : Text(date,
                            style: const TextStyle(color: Colors.black)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
