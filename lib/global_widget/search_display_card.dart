import 'package:flutter/material.dart';

class SearchDisplayCard extends StatefulWidget {
  final Function inkWellFunction;
  final Widget listTileElement;

  const SearchDisplayCard(this.inkWellFunction, this.listTileElement,
      {super.key});

  @override
  State<SearchDisplayCard> createState() => _SearchDisplayCardState();
}

class _SearchDisplayCardState extends State<SearchDisplayCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: InkWell(
        onTap: () async {
          await widget.inkWellFunction();
        },
        child: widget.listTileElement,
      ),
    );
  }
}
