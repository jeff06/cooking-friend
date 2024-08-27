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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        title: const Text(
          "Details Wishlist",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 52, 52),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<StorageItem?>>(
          future: widget.service.getAllStorageItemByFilter(""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      String name = snapshot.data![index]!.name.toString();
                      String date = snapshot.data![index]!.date.toString();
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
    );
  }
}
