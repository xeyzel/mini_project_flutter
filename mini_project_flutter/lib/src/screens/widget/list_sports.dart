import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/models/sport/sport_model.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_sport_screen.dart';
import 'package:mini_project_flutter/src/screens/sports/sport_type_view_model.dart';
import 'package:provider/provider.dart';

class ListSports extends StatelessWidget {
  final Iterable<SportModel> sports;
  const ListSports({super.key, required this.sports});

  @override
  Widget build(BuildContext context) {
    return Consumer<SportViewModel>(builder: (context, value, child) {
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final sport = sports.elementAt(index);
          return ListTile(
            onTap: () {
              context.read<SportViewModel>().selectedSport(sport);

              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                      ),
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const DetailSportScreen();
                  },
                ),
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl: sport.strSportThumb,
                errorWidget: (context, url, error) {
                  return Image.asset(
                    'assets/image_01.jpg',
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
            title: Text(sport.strSport),
            subtitle: Text(
              sport.strSportDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 12,
              backgroundImage: NetworkImage(
                sport.strSportIconGreen,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 20),
        itemCount: sports.length,
      );
    });
  }
}
