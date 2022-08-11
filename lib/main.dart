import 'package:flutter/material.dart';
// 引入下载的库
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // 列表保存即将生成的单词对
  final _suggestions = <WordPair>[];
  // 存储收藏的单词对
  final _saved = <WordPair>{};
  // 字体大小
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Name Generator"),
      ),
      body: _buildSuggestion(),
    );
  }
    Widget _buildSuggestion() {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 每个建议的单词都会调用一次 itemBuilder, 然后将单词对添加到 ListTile 行中
        // 在奇数行, 返回一个分割线, 在偶数行该函数会为单词对添加一个 ListTile 行.
        itemBuilder: (context, i) {
          // 奇数行
          // 在 ListView 的每一行之前, 添加一个一像素高度的分隔线
          if (i.isOdd) return const Divider();

          // 偶数行
          // i ~/ 2: 表示 i 除以 2. 返回值为整型, 向下取整. 计算 ListView 中减去分隔线后实际的单词对数量
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            // 如果是建议列表中最后一个单词对, 接着再生成 10 个单词对, 然后添加到建议列表.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        },
      );
    }

    // 构建单元格
    Widget _buildRow(WordPair pair) {
      final bool alreadySaved = _saved.contains(pair);

      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        // 右侧加上指定的 Icon 图标, 判断 是否保存显示不同的颜色.
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
      );
    }
}
