import 'package:flutter/material.dart';

import '../constants';

class BlurryTitle extends StatelessWidget implements PreferredSizeWidget {
  const BlurryTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          fontFamily: "SF UI Display",
          letterSpacing: -0.41,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 32,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}

/*

 Column(
      children: [
        BlurryContainer(
          blur: 10,
          borderRadius: BorderRadius.all(Radius.zero),
          width: double.infinity,
          height: 24,
          elevation: 0,
          color: Colors.transparent,
          padding: const EdgeInsets.all(16),
          child: Container(),
        ),
        BlurryContainer(
          child: Stack(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        title,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "SF UI Display",
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          blur: 10,
          width: double.infinity,
          height: 64,
          borderRadius: BorderRadius.all(Radius.zero),
          elevation: 0,
          color: Colors.transparent,
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
* */
