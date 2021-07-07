import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

Widget CarouselSlider(items, bool isloading) => SizedBox(
    height: 200,
    child: isloading
        ? Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              height: 200,
              width: double.infinity,
            ),
          )
        : Carousel(
            images: items,
            boxFit: BoxFit.cover,
            dotBgColor: Colors.transparent,
            animationCurve: Curves.easeInOutBack,
            showIndicator: true,
            overlayShadow: true,
            overlayShadowColors: Colors.white,
            overlayShadowSize: 0.7,
          ));
