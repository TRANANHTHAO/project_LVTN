import 'package:flutter/material.dart';

class SwitchAdminMode extends StatefulWidget {
  const SwitchAdminMode({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<SwitchAdminMode> createState() => _SwitchAdminModeState();
}

class _SwitchAdminModeState extends State<SwitchAdminMode> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Admin mode', style: TextStyle(
          color: Colors.deepOrange
        ),),
        const SizedBox(width: 10),
        Switch(
          // This bool value toggles the switch.
          value: light,
          activeColor: Colors.red,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            setState(() {
              light = value;
              widget.onChanged(light);
            });
          },
        )
      ],
    );
  }
}
