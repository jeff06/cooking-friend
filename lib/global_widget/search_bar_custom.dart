import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SearchBarCustom extends StatefulWidget {
  final Function refreshList;
  final Function updateFilter;
  final TextEditingController searchBarController;
  final Widget? suffixIcon;
  final List<String> enumToDisplay;

  const SearchBarCustom(this.searchBarController, this.refreshList,
      this.updateFilter, this.suffixIcon, this.enumToDisplay,
      {super.key});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  final GlobalKey<FormBuilderState> filterMenuKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextField(
            onChanged: (newVal) async {
              await widget.refreshList();
            },
            style: const TextStyle(color: Colors.white),
            controller: widget.searchBarController,
            decoration: InputDecoration(
              filled: true,
              fillColor: CustomTheme.searchBarBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              hintText: "Search for Items",
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: widget.suffixIcon,
              prefixIconColor: Colors.white,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FormBuilder(
                            key: filterMenuKey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: FormBuilderDropdown(
                                    decoration: const InputDecoration(
                                      labelText: "Order by",
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    name: "orderby",
                                    items: widget.enumToDisplay
                                        .map<DropdownMenuItem<dynamic>>(
                                      (current) {
                                        return DropdownMenuItem(
                                          value: current,
                                          child: Text(current),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                Expanded(
                                  child: FormBuilderDropdown(
                                    decoration: const InputDecoration(
                                      labelText: "direction",
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    name: "direction",
                                    items: OrderByDirection.values
                                        .map<DropdownMenuItem<dynamic>>(
                                      (current) {
                                        return DropdownMenuItem(
                                          value: current.paramName,
                                          child: Text(current.paramName),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('Accept'),
                                onPressed: () {
                                  filterMenuKey.currentState!.saveAndValidate();
                                  String orderBy = filterMenuKey
                                      .currentState?.value["orderby"];
                                  String direction = filterMenuKey
                                      .currentState?.value["direction"];

                                  widget.updateFilter(orderBy, direction);
                                  widget.refreshList();
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.filter_list_alt))
      ],
    );
  }
}
