import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      _SettingItem(
        iconData: Icons.update,
        iconColor: Colors.blue,
        title: '检查更新',
        suffix: ElevatedButton(
            child: Text('检查'),
            onPressed: () {
              print('检查');
            }),
      ),
      Divider(),
      _SettingItem(
        iconData: Icons.info,
        iconColor: Colors.green,
        title: '关于',
        suffix: GestureDetector(
          child: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('查看');
          },
        ),
      )
    ]);
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem(
      {required this.iconData,
      required this.iconColor,
      this.title = '',
      this.suffix = const SizedBox()});
  final IconData iconData;
  final Color iconColor;
  final String title;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Icon(iconData, color: iconColor),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Text('$title'),
          ),
          suffix,
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}

class _Suffix extends StatelessWidget {
  final String text;

  const _Suffix({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(color: Colors.grey.withOpacity(.5)),
    );
  }
}
