// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:package_info_plus/package_info_plus.dart';

class XUpdatePage extends StatefulWidget {
  const XUpdatePage({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<XUpdatePage> {
  final _updateUrl = "http://localhost:5500/xupdate.json";

  late String version = "";
  late String buildNumber = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
          () => setState(
            () {
          initVersionInfo();
        },
      ),
    );
    initXUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('更新提示'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("version: $version"),
            Text("buildNumber: $buildNumber"),
            ElevatedButton(
              onPressed: () {
                FlutterXUpdate.checkUpdate(url: _updateUrl);
              },
              child: const Text('默认更新'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterXUpdate.checkUpdate(
                  url: _updateUrl,
                  supportBackgroundUpdate: true,
                );
              },
              child: const Text('后台更新'),
            ),
          ],
        ),
      ),
    );
  }

  void initVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  //初始化XUpdate
  void initXUpdate() {
    if (Platform.isAndroid) {
      FlutterXUpdate.init(
        //是否输出日志
          debug: true,
          //是否使用post请求
          isPost: false,
          //post请求是否是上传json
          isPostJson: false,
          //请求响应超时时间
          timeout: 25000,
          //是否开启自动模式
          isWifiOnly: false,
          //是否开启自动模式
          isAutoMode: false,
          //需要设置的公共参数
          supportSilentInstall: false,
          //在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
          enableRetry: false)
          .then((value) {
        print("初始化成功: $value");
      }).catchError((error) {
        print(error);
      });

      FlutterXUpdate.setErrorHandler(
          onUpdateError: (Map<String, dynamic>? message) async {
            print(message);
          });
    } else {
      debugPrint("ios暂不支持XUpdate更新");
    }
  }
}