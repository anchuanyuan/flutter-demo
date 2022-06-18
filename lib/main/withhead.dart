import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GetResultLayout getResultLayout;

  void setGetResultLayout(GetResultLayout value) {
    getResultLayout = value;
  }

  CaseNameLay caseNameLay1 = CaseNameLay("");
  CaseNameLay caseNameLay2 = CaseNameLay("");

  void dayin(String s1, String s2) {
    print("dayin!!!!!!!!");
    print(s1);
    print(s2);
    caseNameLay1.reload(s1);
    // caseNameLay2.reload(s2);
  }

  @override
  Widget build(BuildContext context) {
    String conditionName = "";
    int conditionNameLength = 0;
    _MyHomePageState _myHomePageState = this;
    const SEX = ['男', '女', '保密'];
    const icons = [Icons.arrow_back_outlined,Icons.arrow_forward_outlined];
    //
    //




    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: '源'),
                    // 设置默认值
                    value: SEX[0],
                    // 选择回调
                    onChanged: (String? newPosition) {
                      setState(() {});
                    },
                    // 传入可选的数组
                    items: SEX.map((String sex) {
                      return DropdownMenuItem(value: sex, child: Text(sex));
                    }).toList(),
                  )),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                // child: typeList[this.data.caseTypeId],
                child: Icon(
                  icons[1],
                  color: Colors.blue,
                  // semanticLabel: "user",
                  size: 40.0,
                  // textDirection: TextDirection.rtl,
                ),
              ),
              Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: '目的'),
                    // 设置默认值
                    value: SEX[2],
                    // 选择回调
                    onChanged: (String? newPosition) {
                      setState(() {});
                    },
                    // 传入可选的数组
                    items: SEX.map((String sex) {
                      return DropdownMenuItem(value: sex, child: Text(sex));
                    }).toList(),
                  )),

            ]),
            caseNameLay1,
            caseNameLay2,
            TextField(
              maxLines: null,
              controller: TextEditingController(),
              style: const TextStyle(
                  fontSize: 16.0, color: Colors.black), //输入文本的样式
              // controller: passController,
              onChanged: (text) {
                //内容改变的回调
                conditionName = text;
                conditionNameLength = text.length;
              },
            ),
            FlatButton(
              onPressed: () {
                print("点击了");
                conditionNameLength = 10;
                if (conditionNameLength != 0) {
                  // getResultLayout.keyText = conditionName;
                  getResultLayout.reloadUrl(conditionName);
                }
              },
              child: Text("翻译"),
            ),
            Container(
              height: 1,
              width: 4,
              child: GetResult(_myHomePageState),
            ),
          ],
        ),
      ),
    );
  }
}

class GetResult extends StatefulWidget {
  late String nameTmp;
  late _MyHomePageState _myHomePageState;

  GetResult(_MyHomePageState myHomePageState) {
    _myHomePageState = myHomePageState;
  }

  @override
  State<StatefulWidget> createState() {
    return GetResultLayout(_myHomePageState);
  }
}

class GetResultLayout extends State<GetResult> {
  late _MyHomePageState _myHomePageState;

  GetResultLayout(_MyHomePageState myHomePageState) {
    _myHomePageState = myHomePageState;
    _myHomePageState.setGetResultLayout(this);
  }

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  // List<String> strRes = {"", ""} as List<String>;
  String strRes1 = "";
  String strRes2 = "";
  String keyText = "";
  final urlController = TextEditingController();
  //

  void reloadUrl(String keyText) {
    this.keyText = keyText;
    URLRequest request = URLRequest(
      url: Uri.parse(
          "https://translate.google.cn/?sl=auto&tl=en&text=" + keyText),
    );
    webViewController?.loadUrl(urlRequest: request);
    check();
  }

  int getResult(int i) {
    webViewController
        ?.evaluateJavascript(
        source: 'document.getElementsByClassName(\'NqnNQd\')[' +
            i.toString() +
            '].innerHTML;')
        .then((value2) {
      print(value2);
      if (value2 != null) {
        if (i % 2 == 0) {
          strRes1 = strRes1 + value2;
        } else {
          strRes2 = strRes2 + value2;
        }

        getResult(i + 1);
      } else {
        if (i > 1) {
          _myHomePageState.dayin(strRes1, strRes2);
        } else {
          check();
        }
      }
    });

    return -1;
  }

  void check() {
    Stream.fromFuture(Future.delayed(
      const Duration(milliseconds: 500),
    ))
        .listen(
          (event) {},
    )
        .onDone(() {
      //500ms后执行这里
      strRes1 = "";
      strRes2 = "";
      getResult(0);
      // webViewController
      //     ?.evaluateJavascript(
      //         source:
      //             'document.getElementsByClassName(\'NqnNQd\')[0].innerHTML;')
      //     .then((value1) {
      //   if (value1 != null) {
      //     webViewController
      //         ?.evaluateJavascript(
      //             source:
      //                 'document.getElementsByClassName(\'NqnNQd\')[1].innerHTML;')
      //         .then((value2) {
      //       if (value2 != null) {
      //         _myHomePageState.dayin(value1, value2);
      //         // print("null##############################");
      //         // print(value1);
      //         // print(value2);
      //       } else {
      //         check();
      //         // print("null+++222");
      //       }
      //     });
      //   } else {
      //     check();
      //     // print("null+++111");
      //   }
      // });

      // webViewController?.evaluateJavascript(source: 'document.getElementsByClassName(\'NqnNQd\');').then((value2) {
      //   if (value2 != null) {
      //     print("null##############################");
      //     print(value2);
      //   }
      //   else{
      //     print("null+++333");
      //   }
      // });
    });
  }

  Widget build(BuildContext context) {
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(
          url: Uri.parse(
              "https://translate.google.cn/?sl=auto&tl=en&text=" + keyText)),
      onWebViewCreated: (controller) {
        print("onWebViewCreated#########################");
        webViewController = controller;
      },
    );
  }
}

class CaseNameLay extends StatefulWidget {
  late String nameTmp;
  void reload(String name) {
    caseNameLayout.reload(name);
  }

  CaseNameLay(this.nameTmp);

  CaseNameLayout caseNameLayout = CaseNameLayout();

  @override
  State<StatefulWidget> createState() {
    caseNameLayout.setCaseNameTitle(this.nameTmp);
    return caseNameLayout;
  }
}

class CaseNameLayout extends State<CaseNameLay> {
  String caseNameTitle = '';

  void setCaseNameTitle(String name) {
    caseNameTitle = name;
  }

  void reload(String name) {
    caseNameTitle = name;
    setState(() {});
  }

  //
  @override
  Widget build(BuildContext context) {
    return Text(caseNameTitle,
        style: TextStyle(fontSize: 20, decoration: TextDecoration.none));
  }
}
