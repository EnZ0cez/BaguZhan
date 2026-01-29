import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/wrong_book_model.dart';
import '../providers/wrong_book_provider.dart';
import '../widgets/duo_card.dart';

class WrongBookPage extends StatefulWidget {
  const WrongBookPage({super.key});

  @override
  State<WrongBookPage> createState() => _WrongBookPageState();
}

class _WrongBookPageState extends State<WrongBookPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WrongBookProvider>().loadWrongBooks();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('错题本'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '未掌握'),
            Tab(text: '已掌握'),
          ],
        ),
      ),
      body: Consumer<WrongBookProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: provider.refresh,
                    child: const Text('重试'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildWrongBookList(provider.unmasteredWrongBooks, provider),
              _buildWrongBookList(provider.masteredWrongBooks, provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWrongBookList(
    List<WrongBookModel> wrongBooks,
    WrongBookProvider provider,
  ) {
    if (wrongBooks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('暂无错题', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.refresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wrongBooks.length,
        itemBuilder: (context, index) {
          final wrongBook = wrongBooks[index];
          return _WrongBookCard(
            wrongBook: wrongBook,
            onTap: () => _navigateToDetail(wrongBook),
            onMarkMastered: wrongBook.isMastered
                ? null
                : () => _markAsMastered(wrongBook.id),
            onDelete: () => _deleteWrongBook(wrongBook.id),
          );
        },
      ),
    );
  }

  void _navigateToDetail(WrongBookModel wrongBook) {
    // TODO: Navigate to wrong book detail
  }

  Future<void> _markAsMastered(String id) async {
    final provider = context.read<WrongBookProvider>();
    final success = await provider.markAsMastered(id);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已标记为掌握')),
      );
    }
  }

  Future<void> _deleteWrongBook(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要从错题本中删除这道题吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final provider = context.read<WrongBookProvider>();
      final success = await provider.deleteWrongBook(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已删除')),
        );
      }
    }
  }
}

class _WrongBookCard extends StatelessWidget {
  const _WrongBookCard({
    required this.wrongBook,
    this.onTap,
    this.onMarkMastered,
    this.onDelete,
  });

  final WrongBookModel wrongBook;
  final VoidCallback? onTap;
  final VoidCallback? onMarkMastered;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final question = wrongBook.question;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: DuoCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(question?.difficulty)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      question?.difficulty ?? '未知',
                      style: TextStyle(
                        fontSize: 12,
                        color: _getDifficultyColor(question?.difficulty),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '错 ${wrongBook.wrongCount} 次',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'master') {
                        onMarkMastered?.call();
                      } else if (value == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (context) => [
                      if (onMarkMastered != null)
                        const PopupMenuItem(
                          value: 'master',
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, size: 20),
                              SizedBox(width: 8),
                              Text('标记为掌握'),
                            ],
                          ),
                        ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline,
                                size: 20, color: Colors.red[400]),
                            const SizedBox(width: 8),
                            Text('删除',
                                style: TextStyle(color: Colors.red[400])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                question?.content ?? '题目内容加载失败',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (question?.topic != null) ...[
                const SizedBox(height: 8),
                Text(
                  question!.topic,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String? difficulty) {
    return switch (difficulty) {
      'easy' => Colors.green,
      'medium' => Colors.orange,
      'hard' => Colors.red,
      _ => Colors.grey,
    };
  }
}
