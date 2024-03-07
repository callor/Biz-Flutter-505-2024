import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.onChange});
  final Function(String) onChange;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SettingsList(
      sections: [
        SettingsSection(
          title: const Text("타이머설정"),
          tiles: [
            SettingsTile(
              leading: const Icon(Icons.timer_outlined),
              title: TextField(
                onChanged: (value) => widget.onChange(value),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "일할시간",
                    contentPadding: EdgeInsets.all(0),
                    hintText: "타이머 작동시간을 입력하세요",
                    hintStyle: TextStyle(
                      color: Colors.blue,
                    )),
              ),
            ),
            SettingsTile(
              leading: const Icon(Icons.timer_outlined),
              title: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "휴식시간",
                ),
              ),
            ),
            SettingsTile(
              leading: const Icon(Icons.timer_outlined),
              title: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "반복횟수",
                ),
              ),
            ),
            SettingsTile.switchTile(
              initialValue: true,
              onToggle: (value) => {},
              title: const Text("알람"),
            )
          ],
        ),
      ],
    ));
  }
}
