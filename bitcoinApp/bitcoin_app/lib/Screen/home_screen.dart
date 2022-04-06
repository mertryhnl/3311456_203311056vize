import 'package:bitcoin_app/Model/btc_model.dart';
import 'package:bitcoin_app/Model/user_model.dart';
import 'package:bitcoin_app/Screen/coin_screen.dart';
import 'package:bitcoin_app/Screen/user_detail_login.dart';
import 'package:bitcoin_app/Screen/user_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _BorsaPageState();
}

class _BorsaPageState extends State<HomeScreen> {
  Future<List<BtcModel>> getBtc() async {
    try {
      var response = await Dio().get(
          "https://api.nomics.com/v1/currencies/ticker?key=20000965822654cedbf1d6d4fed7b0709f848cd9");
      List<BtcModel> _btcList = [];
      if (response.statusCode == 200) {
        var btcList =
            (response.data as List).map((e) => BtcModel.fromMap(e)).toList();
        return btcList;
      }
      return _btcList;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          child: CachedNetworkImage(
            imageUrl:
                "https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg",
            placeholder: (context, url) => const CircularProgressIndicator(),
          ),
          onPressed: () {
            if (userDetail.isEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserDetails(),
                  ));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserScreen(),
                  ));
            }
          },
        ),
        title: const Text(
          'puVog-COiN',
          style: TextStyle(fontSize: 35),
        ),
      ),
      body: Center(
          child: FutureBuilder<List<BtcModel>>(
        future: getBtc(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var btcList = snapshot.data!;
            return ListView.builder(
              itemCount: btcList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                                CoinDetail(btc: btcList[index])));
                  },
                  child: Card(
                    elevation: 20,
                    child: Row(children: [
                      Text(
                        "  " + btcList[index].name + " ->",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '\$ ' + btcList[index].high,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ]),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
