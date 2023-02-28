import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextSet extends StatefulWidget {
  const TextSet({Key? key}) : super(key: key);

  @override
  State<TextSet> createState() => _TextSetState();
}

class _TextSetState extends State<TextSet> {
  // インスタンスの生成
  final prefs = SharedPreferences.getInstance();
  final controller = TextEditingController();
  String value = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  // 画面起動時に読み込むメソッド
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //　データの読み込み
      value = prefs.getString('text')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('shared_preferences')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            // 保存されたデータが表示される
            Text(value, style: const TextStyle(fontSize: 40.0)),
            TextField(
              controller: controller,
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    //　データの保存
                    prefs.setString('text', controller.text);
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      // データの読み込み
                      value = prefs.getString('text')!;
                    });
                  },
                  child: const Text('Load'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      value = '';
                      controller.text = '';
                      // データの削除
                      prefs.remove('text');
                    });
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
