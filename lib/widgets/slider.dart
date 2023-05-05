import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderImage extends StatefulWidget {
  @override
  State<SliderImage> createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<Widget> imgList = [
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/images/wisata1.png',
            ),
            fit: BoxFit.cover,
          )),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/images/beranda.png',
            ),
            fit: BoxFit.cover,
          )),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/images/wisata1.png',
            ),
            fit: BoxFit.cover,
          )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          height: MediaQuery.of(context).size.height,
          initialPage: 0,
          enlargeCenterPage: false,
          viewportFraction: 1.0,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          enableInfiniteScroll: true,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        carouselController: _controller,
        items: imgList,
      ),
      Positioned(
        right: 0,
        left: 0,
        bottom: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Theme.of(context).primaryColor : Colors.white.withOpacity(0.5),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
