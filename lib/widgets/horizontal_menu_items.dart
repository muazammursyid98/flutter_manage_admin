import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';
import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const HorizontalMenuItem(
      {Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child:
            // Obx makes its observable
            Obx(() => Container(
                  // color of container with submenu item,if hovered grey, if not transparent
                  color: menuController.isHovering(itemName)
                      ? lightGrey.withOpacity(.1)
                      : Colors.transparent,
                  child: Row(
                    children: [
                      Visibility(
                        visible: menuController.isHovering(itemName) ||
                            menuController.isActive(itemName),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child:
                            // small bar at the edge which is displayed when hovering
                            Container(
                          width: 6,
                          height: 40,
                          color: dark,
                        ),
                      ),
                      SizedBox(width: _width / 88),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: menuController.returnIconFor(itemName),
                      ),

                      //maintains color if widget is active, if not active changes from grey to dark

                      if (!menuController.isActive(itemName))
                        Flexible(
                            child: CustomText(
                          text: itemName,
                          color: menuController.isHovering(itemName)
                              ? dark
                              : lightGrey,
                        ))
                      else
                        Flexible(
                            child: CustomText(
                          text: itemName,
                          color: dark,
                          size: 18,
                          weight: FontWeight.bold,
                        ))
                    ],
                  ),
                )));
  }
}
