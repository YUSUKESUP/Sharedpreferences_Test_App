import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_test_app/text_set.dart';

import 'SwitchListTile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 初期値を表示するための変数
  String textInit = "初期値";

  // 値を入力するための変数
  final TextEditingController _nameController = TextEditingController();

  // ドキュメント通りに、prefs.setStringで、String型のデータを保存
  _saveData() async {
    // _nameControllerを代入する
    String nameValue = _nameController.text;
    final prefs = await SharedPreferences.getInstance();
    // nameValueを"name"がキーのprefs.setStringで使う。
    await prefs.setString("name", nameValue);
  }

  // ドキュメント通りに、prefs.getStringでString型のデータを取得
  _getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      textInit = prefs.getString("name") ?? "値が入っていない!";
    });
  }

  // ドキュメント通りに、prefs.remove("keyの名前")で、ローカルのデータを削除
  // 今回だと、("name")がkeyのデータを削除する
  _removeData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    setState(() {
      textInit = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("ローカルにデータを保存"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              textInit,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "お名前を入力してください"),
              controller: _nameController,
            ),
            Row(
              children: [
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _saveData,
                  child: const Text('保存'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _getData,
                  child: const Text('表示'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _removeData,
                  child: const Text('削除'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TextSet()));
              },
              child: const Text('テキスト保存ページに遷移'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NextPage()));
              },
              child: const Text('スイッチ保存ページに遷移'),
            ),
          ],
        ),
      ),
    );
  }
}
