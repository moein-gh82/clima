import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const apikey = 'cd3eb0cb32d6de5b2bad99b0372c4f72';

const textfieldstyle = TextStyle(fontSize: 16, color: midnightcolor);

const overlaycolor = Colors.white10;

const darkcolor = Colors.white24;

const midnightcolor = Colors.white60;

var locationtextstyle = GoogleFonts.monda(color: midnightcolor, fontSize: 20);

var temptextstyle = GoogleFonts.daysOne(fontSize: 80);

var detailtitletextstyle = GoogleFonts.monda(fontSize: 16, color: darkcolor);

var detailstextstyle = GoogleFonts.monda(
    color: midnightcolor, fontSize: 20, fontWeight: FontWeight.bold);

const textfielddecoration = InputDecoration(
    fillColor: overlaycolor,
    filled: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none),
    hintText: 'Enter City Name',
    hintStyle: textfieldstyle,
    prefixIcon: Icon(Icons.search));
