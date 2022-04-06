import 'package:bitcoin_app/Controller/buy_controller.dart';
import 'package:bitcoin_app/Model/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('kullanıcı ekranı')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 8,
                child: Column(children: <Widget>[
                  takeUserDetail(),
                ]),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: DataControl.btcs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.black26,
                    child: Column(
                      children: [
                        takeImage(index),
                        Text(DataControl.btcs[index].name +
                            " " +
                            DataControl.btcs[index].price),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
                child: Card(
                    elevation: 8,
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(DataControl.btcToplamfiyat().toString()))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget takeUserDetail() {
    if (userDetail.isNotEmpty) {
      return Column(
        children: [
          Text(userDetail.first.birthPlace),
          Text(userDetail.first.birthDate),
          Text(userDetail.first.name)
        ],
      );
    } else if (userDetail.isEmpty) {
      return const Center(child: Text("KULLANICI BİLGİSİ BULUNAMADI"));
    } else {
      return Container();
    }
  }

  Widget takeImage(int index) {
    if (DataControl.btcs[index].logoUrl.contains(".jpg") ||
        DataControl.btcs[index].logoUrl.contains(".png")) {
      return CachedNetworkImage(
        imageUrl: DataControl.btcs[index].logoUrl,
        height: 120,
        width: 120,
        placeholder: (context, url) => const CircularProgressIndicator(),
        fit: BoxFit.cover,
      );
    } else {
      return SvgPicture.network(
        DataControl.btcs[index].logoUrl,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      );
    }
  }
}
