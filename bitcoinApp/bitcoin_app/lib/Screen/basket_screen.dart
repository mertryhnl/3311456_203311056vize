import 'package:bitcoin_app/Model/btc_model.dart';
import 'package:bitcoin_app/Screen/buy_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Controller/buy_controller.dart';

class BasketScreen extends StatefulWidget {
  final BtcModel btc;
  const BasketScreen({required this.btc, Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  int satinAlmaAdedi = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basket')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            takeImage(),
            Text('coin adı: ' + widget.btc.name),
            Text('coin fiyatı: ' + widget.btc.price),
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            satinAlmaAdedi++;
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: Text(satinAlmaAdedi.toString())),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          satinAlmaAdedi--;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8,
              color: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_right_alt_outlined),
                onPressed: () {
                  DataControl.addBtc(widget.btc, satinAlmaAdedi);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuyScreen(),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget takeImage() {
    if (widget.btc.logoUrl.contains(".jpg") ||
        widget.btc.logoUrl.contains(".png")) {
      return CachedNetworkImage(
        imageUrl: widget.btc.logoUrl,
        height: 200,
        width: 200,
        placeholder: (context, url) => const CircularProgressIndicator(),
        fit: BoxFit.cover,
      );
    } else {
      return SvgPicture.network(
        widget.btc.logoUrl,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      );
    }
  }
}
