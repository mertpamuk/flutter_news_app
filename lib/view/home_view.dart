import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<NewsModel>? _items;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // fetchNews();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchNews() async {
    try {
      final response = await Dio().get(
          'https://api.thenewsapi.com/v1/news/all?api_token=Up3ck9GEnYJrqsdNykjm3sv1uSkIfNdIMhEOA5aO&language');
      if (response.statusCode == 200) {
        final _datas = response.data["data"];
        if (_datas is List) {
          setState(() {
            _items = _datas.map((e) => NewsModel.fromJson(e)).toList();
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void sendCountryQueryParameters() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _items?.length ?? 0,
        itemBuilder: ((context, index) {
          return _newsCard(newsModel: _items?[index]);
        }),
      ),
      drawer: _newsDraver(),
      floatingActionButton: FloatingActionButton(onPressed: () => fetchNews()),
    );
  }
}

class _newsDraver extends StatelessWidget {
  const _newsDraver({
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
            const SizedBox(height: 30),
            Text(
              _newsModel?.title ?? "Unknown Title",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(_newsModel?.description ?? "Unknown Description"),
          ],
        ),
      ),
    );
  }
}
