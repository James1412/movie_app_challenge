import 'package:flutter/material.dart';

class PopularText extends StatelessWidget {
  final String popular;
  const PopularText({super.key, required this.popular});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
      child: Text(
        popular,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
