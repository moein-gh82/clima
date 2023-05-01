import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class DetailsWidget extends StatelessWidget {
  final String title, value;
  const DetailsWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Text(
              value,
              style: detailstextstyle,
            ),
            Visibility(
                visible: title == 'WIND' ? true : false,
                child: Text(
                  ' km/h',
                  style: GoogleFonts.monda(fontSize: 12, color: midnightcolor),
                ))
          ],
        ),
        Text(
          title,
          style: detailtitletextstyle,
        )
      ],
    );
  }
}
