import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/service/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> dayTabs = <Tab>[
    const Tab(text: '월'),
    const Tab(text: '화'),
    const Tab(text: '수'),
    const Tab(text: '목'),
    const Tab(text: '금'),
    const Tab(text: '토'),
    const Tab(text: '일'),
  ];
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 7,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.greenAccent.shade700,
        title: const Text(
          "오늘의 웹툰",
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: dayTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const Center(
            child: Text("It's cloudy here"),
          ),
          const Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: FutureBuilder(
              future: webtoons,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: makeList(snapshot),
                      )
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          const Center(
            child: Text("It's rainy here"),
          ),
          const Center(
            child: Text("It's rainy here"),
          ),
          const Center(
            child: Text("It's rainy here"),
          ),
          const Center(
            child: Text("It's rainy here"),
          ),
        ],
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
    );
  }
}
