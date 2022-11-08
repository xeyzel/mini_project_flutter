import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../sports/sport_type_view_model.dart';

class DetailSportScreen extends StatefulWidget {
  const DetailSportScreen({super.key});

  @override
  State<DetailSportScreen> createState() => _DetailSportScreenState();
}

class _DetailSportScreenState extends State<DetailSportScreen> {
  @override
  Widget build(BuildContext context) {
    final listSport = Provider.of<SportViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(listSport.sport!.strSport),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 230,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: listSport.sport!.strSportThumb,
                errorWidget: (context, url, error) {
                  return Image.asset(
                    'assets/images/image_01.jpg',
                    fit: BoxFit.cover,
                  );
                },
                placeholder: (context, url) {
                  return const CircularProgressIndicator();
                },
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 200),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listSport.sport!.strSport,
                          style: const TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          width: 80,
                          child: Lottie.asset(
                            'assets/icons/education.json',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      listSport.sport!.strSportDescription,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
