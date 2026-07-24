import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = dataService.libraryBooks.map((b) => b.category).toSet().toList();
    final books = dataService.libraryBooks.where((b) {
      if (_searchQuery.isNotEmpty && !b.title.toLowerCase().contains(_searchQuery.toLowerCase()) && !b.author.toLowerCase().contains(_searchQuery.toLowerCase())) return false;
      if (_selectedCategory != null && b.category != _selectedCategory) return false;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Library'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'All Books'),
            Tab(text: 'Available'),
            Tab(text: 'Issued'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search books...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.accentGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: true,
                      value: _selectedCategory,
                      hint: const Text('Category', style: TextStyle(fontSize: 11)),
                      icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                      style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
                      items: [null, ...categories].map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c ?? 'All', style: const TextStyle(fontSize: 11)),
                      )).toList(),
                      onChanged: (v) => setState(() => _selectedCategory = v),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookList(books),
                _buildBookList(books.where((b) => b.isAvailable).toList()),
                _buildBookList(books.where((b) => !b.isAvailable).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(List books) {
    if (books.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 80, color: AppColors.dividerGrey),
            SizedBox(height: 16),
            Text('No Books Found', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: books.length,
      itemBuilder: (ctx, i) {
        final book = books[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.menu_book, color: AppColors.primaryRed, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('by ${book.author}', style: AppTextStyles.listItemSubtitle),
                          Text('ISBN: ${book.isbn}', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.linkBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(book.category, style: const TextStyle(fontSize: 10, color: AppColors.linkBlue)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: book.isAvailable ? AppColors.accentGreen.withOpacity(0.1) : AppColors.primaryRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(book.isAvailable ? 'Available' : 'Issued', style: TextStyle(fontSize: 10, color: book.isAvailable ? AppColors.accentGreen : AppColors.primaryRed, fontWeight: FontWeight.w600)),
                    ),
                    if (!book.isAvailable) ...[
                      const SizedBox(width: 8),
                      Text('To: ${book.issuedTo}', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      Text(' Due: ${book.dueDate}', style: const TextStyle(fontSize: 10, color: AppColors.primaryRed)),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
