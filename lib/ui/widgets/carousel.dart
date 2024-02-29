import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../pages/common/watch_image_view.dart';


class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;

  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        20.0,
      ),
      child: SizedBox(
        height: 200.0,
        child: PageView.builder(
            itemCount: widget.images.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, pagePosition) {
              bool active = pagePosition == activePage;
              return slider(widget.images, pagePosition, active, context);
            }),
      ),
    );
  }
}

AnimatedContainer slider(images, pagePosition, active, context) {
  double margin = active ? 5 : 10;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 800),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WatchImageView(image: images[pagePosition],),
          ),
        );
      },
      child: CachedNetworkImage(
        placeholder: (context, url) => const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        imageUrl: images[pagePosition],
        imageBuilder: (context, imageProvider) => Container(
          width: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
  );
}
