import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLinks;
  const CarouselImage({
    super.key,
    required this.imageLinks,
  });

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _cuurent = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.imageLinks
                  .map(
                    (link) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Image.network(
                        link,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reson) {
                    _cuurent = index;
                    setState(() {});
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageLinks.asMap().entries.map((e) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(
                      _cuurent == e.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        )
      ],
    );
  }
}
