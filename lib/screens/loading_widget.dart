import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadingwidget extends StatelessWidget {
  const Loadingwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitPulse(
              color: Colors.white,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'receiving data...',
              style: TextStyle(color: Colors.white60),
            )
          ],
        ),
      ),
    );
  }
}
