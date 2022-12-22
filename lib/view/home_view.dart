import 'package:flutter/material.dart';
import 'package:news_app/constants/categories.dart';
import 'package:news_app/constants/countries.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_service.dart';

import '../components/news_card.dart';
import '../constants/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 1;
  String _langCode = "en";
  String _lang = "English";
  String _category = "general";
  List<NewsModel>? _items;
  bool _isLoading = false;
  late final NewsService _newsService;

  @override
  void initState() {
    super.initState();
    _newsService = NewsService();
    _fetchItems(_langCode, _page, _category);
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _fetchItems(String lang, int page, String category) async {
    _changeLoading();
    _items = await _newsService.fetchNews(lang, page, category);
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(children: [
        _buildCategoryBar(),
        _buildBody(),
      ]),
      drawer: _NewsDrawer(),
      floatingActionButton: _langCode == "" ? null : _floatingActionButtons(),
    );
  }

  Expanded _buildBody() {
    return Expanded(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: NewsPadding.newsPaddingHorizontalMid,
              itemCount: _items?.length ?? 0,
              itemBuilder: ((context, index) {
                return NewsCard(newsModel: _items?[index]);
              }),
            ),
    );
  }

  SizedBox _buildCategoryBar() {
    return SizedBox(
      height: 40,
      child: Expanded(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: NewsCategories.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: NewsPadding.newsPaddingAllMin,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        BoxDecorationStyles.newsPrimaryColor),
                  ),
                  child: Text(NewsCategories.categories[index]),
                  onPressed: () {
                    _category = NewsCategories.categories[index];
                    _page = 1;
                    _fetchItems(_langCode, _page, _category);
                  },
                ),
              );
            }),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      shape:
          RoundedRectangleBorder(borderRadius: NewsRadius.newsRadiusCircular),
      elevation: 10,
      actions: [
        Padding(
          padding: NewsPadding.newsPaddingAllMid,
          child: Center(
            child: _langCode == ""
                ? null
                : Text("$_lang | $_category | Page: $_page"),
          ),
        ),
      ],
      title: const Text(NewsStrings.appTitle),
    );
  }

  Row _floatingActionButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (_page > 1) {
            _page--;
            _fetchItems(_langCode, _page, _category);
          }
        },
      ),
      NewsSizedBoxes.sizedBox10,
      FloatingActionButton(
        child: const Icon(Icons.arrow_forward_ios),
        onPressed: () {
          _page++;
          _fetchItems(_langCode, _page, _category);
        },
      )
    ]);
  }

  Drawer _NewsDrawer() {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
            decoration: BoxDecorationStyles.boxShadow,
            child: Padding(
              padding: NewsPadding.newsPaddingAllLow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    NewsStrings.appTitle,
                    style: NewsTextStyles.drawerHeaderStyleMid,
                  ),
                  Text(
                    NewsStrings.appLangTitle,
                    style: NewsTextStyles.drawerHeaderStyleLow,
                  ),
                ],
              ),
            )),
        Expanded(
            child: ListView.builder(
          itemCount: Country.countryList.length,
          itemBuilder: (context, index) => ListTile(
            selected: Country.countryList[index].name == _lang ? true : false,
            title: Text(Country.countryList[index].name),
            onTap: () {
              _langCode = Country.countryList[index].code;
              _lang = Country.countryList[index].name;
              _page = 1;
              _fetchItems(_langCode, _page, _category);
              Navigator.of(context).pop();
            },
          ),
        )),
      ]),
    );
  }
}
