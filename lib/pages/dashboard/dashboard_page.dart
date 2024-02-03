import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final dataRecord = [
    (Icons.people, "ユーザー数", 33),
    (Icons.account_balance, "売上", 1000000),
    (Icons.comment, "コメント数", 4000),
    (Icons.star, "評価", 4.5),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  "ダッシュボード",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dataRecord.length, // リストのアイテム数
                itemBuilder: (context, index) {
                  // itemBuilderで各アイテムを定義
                  final record = dataRecord[index];
                  return Card(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: SizedBox(
                      height: 200,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(record.$1, // レコードのアイコン
                                size: 50,
                                color: Theme.of(context).colorScheme.secondary),
                            Text(
                              record.$2, // レコードのテキスト1
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              record.$3.toString(), // レコードのテキスト2
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal, // 水平方向にスクロール
              ),
            ),
          ],
        ),
      ),
    );
  }
}
