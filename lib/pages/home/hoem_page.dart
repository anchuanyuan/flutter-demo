import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _resultText = ""; // 结果文本
  String _inputText = ""; // 输入的文本
  TextEditingController _unameController = TextEditingController(); // 输入框控制器
  String sourceLanguage = "zh"; // 源语言
  String targetLanguage = "en"; // 目标语言

  onClear() {
    print('onClear');
    setState(() {
      _inputText = "";
    });
  }

  afterTranslate(value) {
    print('changeValue');
    setState(() {
      _resultText = value;
    });
  }
  changeSourceLanguage(value) {
    print('changeSourceLanguage');
    setState(() {
      sourceLanguage = value;
    });
  }
  changeTargetLanguage(value) {
    print('changeTargetLanguage');
    setState(() {
      targetLanguage = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
        title: Text('翻译'),
        // subtitle: Text('内容'),
        trailing: Icon(Icons.translate),
      ),
      // 语言设置
      // 下拉框选择语言：
      languageSelector(sourceLanguage,targetLanguage, changeSourceLanguage,changeTargetLanguage),
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
      MyButtons(_unameController, afterTranslate,sourceLanguage,targetLanguage),
      // 结果
      Result(_resultText)
    ]);
  }
}

// 按钮组
Widget MyButtons(TextEditingController controller, afterTranslate,sourceLanguage,targetLanguage) {
  // @override
  // Widget build(BuildContext context) {
  return Row(
    children: [
      TextButton(
        child: Text("翻译"),
        onPressed: () async {
          var res = await getResult(sourceLanguage,targetLanguage,controller.text);
          print ("res ======== ");
          print(res  + " res");
          afterTranslate(res);
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
Widget MyFiled(String text, controller) {
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

Widget Result(resultText) {
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
Widget languageSelector(sourceLanguage, targetLanguage,changeSourceLanguage,changeTargetLanguage) {
  return Row(children: [
    SizedBox(
      width: 10,
    ),
    DropdownButton(
      hint: Text('语言'),
      value: sourceLanguage,
      items: [
        DropdownMenuItem(
          child: Text('中文'),
          value: 'zh',
        ),
        DropdownMenuItem(
          child: Text('英文'),
          value: 'en',
        ),
        DropdownMenuItem(
          child: Text('日文'),
          value: '日文',
        ),
        DropdownMenuItem(
          child: Text('韩文'),
          value: '韩文',
        ),
      ],
      onChanged: (value) {
        changeSourceLanguage(value);
      },
    ),
    SizedBox(
      width: 10,
    ),
    //  置换按钮
    TextButton.icon(
      onPressed: () {
        String temp = sourceLanguage;
        changeSourceLanguage(targetLanguage);
        changeTargetLanguage(temp);
      },
      label: Text(''),
      icon: Icon(Icons.arrow_right_alt_rounded),
    ),
    DropdownButton(
      hint: Text('语言'),
      value: targetLanguage,
      items: [
        DropdownMenuItem(
          child: Text('英文'),
          value: 'en',
        ),
        DropdownMenuItem(
          child: Text('中文'),
          value: 'zh',
        ),
        DropdownMenuItem(
          child: Text('日文'),
          value: '日文',
        ),
        DropdownMenuItem(
          child: Text('韩文'),
          value: '韩文',
        ),
      ],
      onChanged: (value) {
        changeTargetLanguage(value);
      },
    ),
  ]);
}

// http请求
getResult(sourceLanguage,targetLanguage,inputText) async {
  const tokenRul = "https://aip.baidubce.com/oauth/2.0/token";
  const translateUrl = 'https://v2.alapi.cn/api/fanyi';
  Dio dio = Dio();
  // var tokenTesponse = await dio.post(tokenRul, data: {
  //   "grant_type": "client_credentials",
  //   "client_id": "UdKee2QOF7L63zzZwO8nTTZi",
  //   "client_secret": "4mxj8a1n6Vm3SfhRAaRMZBjrrSUDO0qk"
  // }, options: Options(contentType: Headers.formUrlEncodedContentType));
  //
  print("inputText");
  print(inputText);
  var token = "LwExDtUWhF3rH5ib";
  var res = await dio.get(translateUrl, queryParameters: {
    "from": sourceLanguage,
    "to": targetLanguage,
    "q": inputText,
    "token": token
  });
  print(res);
  var respose = json.decode(res.toString());
  print(respose['data']['dst']);
  return respose['data']['dst'];
  print(respose);
}
