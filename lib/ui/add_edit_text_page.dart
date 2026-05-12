import 'package:electric_digital_sketch/ui/widgets/add_text_page/add_text_page_bottom.dart';
import 'package:electric_digital_sketch/ui/widgets/add_text_page/add_text_page_header.dart';
import 'package:electric_digital_sketch/ui/widgets/core/text_input.dart';
import 'package:flutter/material.dart';

/// Modal page used to create or edit a text item in the sketch.
class AddEditTextPage extends StatefulWidget {
  const AddEditTextPage({this.defaultText, super.key});

  final String? defaultText;
  @override
  State<AddEditTextPage> createState() => _AddEditTextPageState();
}

class _AddEditTextPageState extends State<AddEditTextPage> {
  TextEditingController textFieldController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController(text: widget.defaultText ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  const AddTextPageHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: TextInput(controller: textFieldController),
                    ),
                  ),
                  AddTextPageBottom(
                    onConfirm: () {
                      Navigator.pop(context, textFieldController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
