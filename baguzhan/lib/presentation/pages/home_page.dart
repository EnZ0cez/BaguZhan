import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const topics = ['JavaScript', 'React', 'Vue'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('八股斩')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('选择主题', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: topics.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/question', arguments: topic);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 4),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            topic,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
