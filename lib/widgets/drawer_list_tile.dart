import 'package:byte_games/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerListTile extends StatefulWidget {
  const DrawerListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPress});

  final IconData icon;
  final String title;
  final Function onPress;

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkConsumer, child) {
      return GestureDetector(
        onTap: () {
          widget.onPress();
        },
        child: Column(
          children: [
            ListTile(
              trailing: Icon(
                widget.icon,
                color: darkConsumer.isDark ? Colors.white60 : Colors.black54,
              ),
              title: Text(widget.title),
            ),
            const Divider(),
          ],
        ),
      );
    });
  }
}
