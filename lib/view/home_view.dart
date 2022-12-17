import 'package:flutter/material.dart';
import 'package:news_app/constants/countries.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 1;
  String _langCode = "";
  String _lang = "";
  List<NewsModel>? _items;
  bool _isLoading = false;
  late final NewsService _newsService;

  @override
  void initState() {
    super.initState();
    _newsService = NewsService();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _fetchItems(String lang, int page) async {
    _changeLoading();
    _items = await _newsService.fetchNews(lang, page);
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(),
      drawer: _NewsDrawer(),
      floatingActionButton: _langCode == "" ? null : _floatingActionButtons(),
    );
  }

  ListView _buildBody() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: _items?.length ?? 0,
      itemBuilder: ((context, index) {
        return _newsCard(newsModel: _items?[index]);
      }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 10,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: _langCode == "" ? null : Text("$_lang | Page: $_page"),
          ),
        ),
      ],
      title: const Text("News App"),
      centerTitle: true,
    );
  }

  Row _floatingActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (_page > 1) {
              _page--;
              _fetchItems(_langCode, _page);
            }
          },
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          child: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            _page++;
            _fetchItems(_langCode, _page);
          },
        ),
      ],
    );
  }

  Drawer _NewsDrawer() {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue, boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    "News App",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    "Countries:",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            )),
        Expanded(
          child: ListView.builder(
            itemCount: Country.countryList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(Country.countryList[index].name),
              onTap: () {
                _langCode = Country.countryList[index].code;
                _lang = Country.countryList[index].name;
                _page = 1;
                _fetchItems(_langCode, _page);
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    ));
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
              child: Image.network(_newsModel?.imageUrl ?? "",
                  errorBuilder: (context, error, stackTrace) {
                print(error);
                return const Icon(Icons.error);
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                _newsModel?.title ?? "Unknown Title",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Text(_newsModel?.description ?? "Unknown Description"),
          ],
        ),
      ),
    );
  }
}
