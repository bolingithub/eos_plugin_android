import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:eos_plugin_android/eos_plugin_android.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String eosInfo;
    try {
      var eosWallet = await EosPluginAndroid.createEosWallet();
      print("获取到的eos钱包账号是：$eosWallet");
      var pk = await EosPluginAndroid.mnemonicToPrivateKey(eosWallet.mnemonic);
      //var pu = await EosPlugin.mnemonicToPublicKey(eosWallet.mnemonic);
      var pu2 = await EosPluginAndroid.privateKeyToPublicKey(pk);
      eosInfo = eosWallet.toString();
      print("获取到的eos钱包账号是pk：$pk");
      //print("获取到的eos钱包账号是pu：$pu");
      print("获取到的eos钱包账号是pu2：$pu2");
    } on PlatformException {
      eosInfo = 'Failed to get platform version.';
    }

    var quantity = (2.0.toString().split(".")[0] + "." + (2.0.toString().split(".")[1] + "0000").substring(0, 4)) + " EOS";
    var textResult = await EosPluginAndroid.transfer("eosio.token", "http://134.175.121.14:8888", "huangbolinnb", "5HvhDiNmFE8wMnBXbkuCZtiEVfbqRFePf51TzAf8XvX5XZomq4e", "storybankone", quantity, "33");
    print('交易是否成功：$textResult');

    //var quantity = (2.0.toString().split(".")[0] + "." + (2.0.toString().split(".")[1] + "0000").substring(0, 4)) + " EOS";
    //print("quantity -----=  ：$quantity");
    //await EosPluginAndroid.transfer("eosio.token", "http://dev.cryptolions.io:38888", "vo2ye2oxs2qp", "5HvhDiNmFE8wMnBXbkuCZtiEVfbqRFePf51TzAf8XvX5XZomq4e", "wumingdengng", quantity, "33");

    if (!mounted) return;

    setState(() {
      _platformVersion = eosInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
