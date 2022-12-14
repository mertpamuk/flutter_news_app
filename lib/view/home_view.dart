import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<NewsModel>? _items;
  bool _isLoading = false;
  late final NewsService _newsService;

  @override
  void initState() {
    super.initState();
    _newsService = NewsService();
    //_fetchItems();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _fetchItems() async {
    _changeLoading();
    _items = await _newsService.fetchNews();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _items?.length ?? 0,
              itemBuilder: ((context, index) {
                return _newsCard(newsModel: _items?[index]);
              }),
            ),
      drawer: _newsDrawer(),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _fetchItems()),
    );
  }
}

class _newsDrawer extends StatelessWidget {
  const _newsDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.blue),
          child: Text(
            "Countries",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        ListTile(
          title: const Text("Turkey"),
          onTap: () => null,
        ),
        const ListTile(title: Text("England"))
      ]),
    );
  }
}

class _newsCard extends StatelessWidget {
  const _newsCard({
    Key? key,
    required NewsModel? newsModel,
  })  : _newsModel = newsModel,
        super(key: key);

  final NewsModel? _newsModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(_newsModel?.imageUrl ?? ""),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child: Text(
                _newsModel?.title ?? "Unknown Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Text(_newsModel?.description ?? "Unknown Description"),
          ],
        ),
      ),
    );
  }
}
