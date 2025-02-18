import 'package:coffie_decorator/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Beverage? beverage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кофе декоратор')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ваш заказ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              beverage?.description != null ? beverage!.description : 'Сделайте заказ',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            SegmentedButton<String>(
              emptySelectionAllowed: true,
              segments: [
                ButtonSegment(value: 'Espresso', label: Text('Espresso')),
                ButtonSegment(value: 'Cappuccino', label: Text('Cappuccino')),
                ButtonSegment(value: 'Latte', label: Text('Latte')),
              ],
              selected: Set.of([beverage?.composition.first ?? '']),
              onSelectionChanged: (selected) {
                if (selected.contains('Espresso')) {
                  setState(() {
                    beverage = Espresso();
                  });
                } else if (selected.contains('Cappuccino')) {
                  setState(() {
                    beverage = Cappuccino();
                  });
                } else if (selected.contains('Latte')) {
                  setState(() {
                    beverage = Latte();
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Syrup'),
              value: beverage?.composition.contains('Syrup') ?? false,
              enabled: beverage != null,
              onChanged: (value) {
                setState(() {
                  beverage = Syrup(beverage!);
                });
              },
            ),
            CheckboxListTile(
              enabled: beverage != null,
              title: const Text('Milk'),
              value: beverage?.composition.contains('Milk') ?? false,
              onChanged: (bool? value) {
                setState(() {
                  beverage = Milk(beverage!);
                });
              },
            ),
            const Divider(
              color: Colors.grey,
              height: 32,
              thickness: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Итого',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  beverage?.cost().toString() ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Заказ оформлен'),
                      ),
                    );
                  },
                  child: const Text('Заказать'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
