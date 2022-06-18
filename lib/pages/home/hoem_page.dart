import 'dart:io';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _resultText = "123"; // 结果文本
  String _inputText = "123"; // 输入的文本
  TextEditingController _unameController = TextEditingController(); // 输入框控制器

  onClear () {
    print('onClear');
    setState(() {
      _resultText = "";
    });
  }
  changeValue (value) {
    print('changeValue');
    setState(() {
      _resultText = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
        title: Text('中文翻译'),
        subtitle: Text('内容'),
        trailing: Icon(Icons.translate),
      ),
      Card(
        margin: EdgeInsets.all(10.0),
        elevation: 10.0,
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(boxShadow: [MyBoxShadow(), MyBoxShadow()]),
          child: Column(
            children: <Widget>[MyFiled(_inputText, _unameController)],
          ),
        ),
      ),
      MyButtons(_unameController,changeValue),
      // 结果
      Result(_resultText)
    ]);
  }
}

// 按钮组
Widget MyButtons ( TextEditingController controller,changeValue) {
  // @override
  // Widget build(BuildContext context) {
    return  Row(
      children: [
        TextButton(
          child: Text("翻译"),
          onPressed: () {
           var result =  controller.text;
           print('result' + result);
           changeValue(result);
          },
        ),
        TextButton(
          child: Text("清空"),
          onPressed: () {
            controller.clear();
          },
        )
      ],
    );
  // }

}

// 输入框
Widget MyFiled( String text, controller) {
  return TextField(
      autofocus: false,
      minLines: 5,
      maxLines: 10,
      controller: controller,
      decoration: InputDecoration(
        labelText: "请输入翻译内容",
      ),
      onChanged: (v) {
        print("onChange: $v");
        // onChangeInput('$v');
      });
}

// 阴影效果
BoxShadow MyBoxShadow() {
  return BoxShadow(
      color: Colors.white10,
      offset: Offset(5.0, 5.0),
      // blurStyle: BlurStyle.inner,
      blurRadius: 10.0);
}

Widget Result (resultText) {
  return Card(
    elevation: 10.0,
    margin: EdgeInsets.all(10.0),
    child: Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$resultText"),
        ],
      ),
    ),
  );
}

// http请求
getResult() {
  HttpClient httpClient = HttpClient();
}

