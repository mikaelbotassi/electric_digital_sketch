import 'package:electric_digital_sketch/ui/result_page.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/app_bar/undo_redo_button_group_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:electric_digital_sketch/ui/widgets/core/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({required this.controller, this.onReturn, super.key});

  final ElectricSketchController controller;
  final VoidCallback? onReturn;

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.painterController,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          color: Colors.black87,
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onReturn ?? () => Navigator.pop(context),
                  icon: const Icon(
                    TablerIcons.chevronLeft,
                    color: Colors.white,
                  )
                ),
                Row(
                  spacing: 8,
                  children: [
                    IconButtonWidget(
                      icon: TablerIcons.trash,
                      enabled: controller.painterController.value.selectedItem != null,
                      onPressed: controller.removeSelectedItem,
                    ),
                    UndoRedoButtonGroupWidget(controller: controller),
                    PrimaryButton(
                      onPressed: () async {
                        final image = await controller.painterController.renderImage();
                        if (image != null && context.mounted) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (context) => ResultPage(image: image),
                            ),
                          );
                        }
                      },
                      icon: TablerIcons.photo,
                    ),
                  ]
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
