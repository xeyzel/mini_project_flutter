import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/about/about_screen.dart';

class DrawerMax extends StatelessWidget {
  const DrawerMax({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 600),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          child: SizedBox(
            height: 150,
            child: Drawer(
              width: 150,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            backgroundColor: Colors.teal.shade200,
                            context: context,
                            builder: (context) => AboutScreen(),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('ABOUT'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
