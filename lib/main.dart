import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

// Обертка для запуска приложения
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(title: 'Пример FutureBuilder'),
    );
  }
}

// Сам виджет MyWidget, к которому относится State
class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.title});

  final String title;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // Поле создается один раз при первом обращении (в build)
  // и больше не пересоздается при перестройках
  late final Future<int> _future = Future.delayed(
    const Duration(seconds: 10), // задержка 2 секунды
    _loadData,                  // функция без стрелки, возвращает 42
  );

  // Отдельный метод вместо стрелочной функции () => 42
  int _loadData() {
    return 42; // результат, который получит FutureBuilder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FutureBuilder<int>(
          future: _future, // готовый Future, создан один раз
          builder: (context, snapshot) {
            // Пока данные не пришли - показываем индикатор
            if (snapshot.hasData == false) {
              return const CircularProgressIndicator();
            }
            // Данные пришли - показываем результат
            return Text('Результат: ${snapshot.data}');
          },
        ),
      ),
    );
  }
}