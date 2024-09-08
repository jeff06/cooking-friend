import 'package:cooking_friend/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  final Function refreshList;
  final TextEditingController searchBarController;
  final Widget? suffixIcon;

  const SearchBarCustom(this.searchBarController, this.refreshList, this.suffixIcon,
      {super.key});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newVal) async {
        await widget.refreshList();
      },
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
    );
  }
}
