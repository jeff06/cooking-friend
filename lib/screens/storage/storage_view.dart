import 'dart:async';

import 'package:cooking_friend/river/models/storage_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../river/services/isar_service.dart';

class StorageView extends StatefulWidget {
  final IsarService service;

  const StorageView(this.service, {super.key});

  @override
  State<StorageView> createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  String currentSearchString = "";
  Future<List<StorageItem?>> storageItemToDisplay =
      Completer<List<StorageItem?>>().future;

  Future<void> refreshList() async {
    setState(() {
      storageItemToDisplay =
          widget.service.getAllStorageItemByFilter(currentSearchString);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        storageItemToDisplay =
            widget.service.getAllStorageItemByFilter(currentSearchString);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/storageAdd");
            },
          )
        ],
        title: const Text(
          "Ingredients",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 52, 52),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (newVal) {
              setState(
                () {
                  currentSearchString = newVal;
                },
              );
              refreshList();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: () => refreshList(),
                  child: FutureBuilder<List<StorageItem?>>(
                    future: storageItemToDisplay,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                String name =
                                    snapshot.data![index]!.name.toString();
                                String date =
                                    snapshot.data![index]!.date.toString();
                                return Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.album),
                                        title: Text(name),
                                        subtitle: Text(date),
                                      ),
                                      /*Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text('BUY TICKETS'),
                                          onPressed: () {
                                            /* ... */
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        TextButton(
                                          child: const Text('LISTEN'),
                                          onPressed: () {
                                            /* ... */
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),*/
                                    ],
                                  ),
                                );
                              }),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
