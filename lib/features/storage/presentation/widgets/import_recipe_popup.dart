import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ImportRecipePopup extends StatelessWidget {
  const ImportRecipePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> filterMenuKey =
    GlobalKey<FormBuilderState>();
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
                    child: FormBuilderTextField(
                      decoration: const InputDecoration(
                        labelText: "URL",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      name: "url",
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
                    String url = filterMenuKey.currentState?.value["url"];
                    Navigator.of(context).pop(url);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
