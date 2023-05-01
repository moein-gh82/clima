import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class Errormessage extends StatelessWidget {
  final String title, message;
  const Errormessage({super.key, required this.message, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_rounded,
              size: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: detailstextstyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              message,
              style: locationtextstyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
