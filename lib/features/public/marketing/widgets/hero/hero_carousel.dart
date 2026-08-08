/*
==============================================================================
FILE: hero_carousel.dart
MODULE: Public / Marketing
COMPONENT: Hero Carousel
==============================================================================
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/screens/signup_screen.dart';
import '../../providers/marketing_provider.dart';
import 'hero_indicators.dart';
import 'hero_slide.dart';

final class HeroCarousel extends ConsumerStatefulWidget {
  const HeroCarousel({
    super.key,
  });

  @override
  ConsumerState<HeroCarousel> createState() =>
      _HeroCarouselState();
}

final class _HeroCarouselState
    extends ConsumerState<HeroCarousel> {
  late final PageController _pageController;

  Timer? _timer;

  /// Actual marketing slide index.
  ///
  /// Always ranges from:
  /// 0 ... originalSlides.length - 1
  int _currentIndex = 0;

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 1,
    );

    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  //===========================================================================
  // AUTO PLAY
  //===========================================================================

  void _startAutoPlay() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        if (_isHovering ||
            !_pageController.hasClients) {
          return;
        }

        final slides =
            ref.read(marketingSlidesProvider);

        if (slides.isEmpty) {
          return;
        }

        _pageController.nextPage(
          duration:
              const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }
  //===========================================================================
  // PAGE CHANGE
  //===========================================================================

  void _handlePageChanged(
    int pageIndex,
    int slideCount,
  ) {

    //=======================================================================
    // LAST CLONE
    //=======================================================================

    if (pageIndex == slideCount + 1) {
      setState(() {
        _currentIndex = 0;
      });

      Future.delayed(
        const Duration(milliseconds: 350),
        () {
          if (!_pageController.hasClients) {
            return;
          }

          _pageController.jumpToPage(1);

          if (mounted) {
            setState(() {
              _currentIndex = 0;
            });
          }
        },
      );

      return;
    }

    //=======================================================================
    // FIRST CLONE
    //=======================================================================

    if (pageIndex == 0) {
      final lastRealSlide = slideCount - 1;

      setState(() {
        _currentIndex = lastRealSlide;
      });

      Future.delayed(
        const Duration(milliseconds: 350),
        () {
          if (!_pageController.hasClients) {
            return;
          }

          _pageController.jumpToPage(
            slideCount,
          );

          if (mounted) {
            setState(() {
              _currentIndex = lastRealSlide;
            });
          }
        },
      );

      return;
    }

    //=======================================================================
    // REAL SLIDE
    //=======================================================================

    final realIndex = pageIndex - 1;

    setState(() {
      _currentIndex = realIndex;
    });
  }

  //===========================================================================
  // BUILD
  //===========================================================================

  @override
  Widget build(BuildContext context) {
    final originalSlides =
        ref.watch(marketingSlidesProvider);

    if (originalSlides.isEmpty) {
      return const SizedBox.shrink();
    }

    //=======================================================================
    // CLONED SLIDES
    //
    // [last, slide1, slide2, slide3, ..., last, first]
    //=======================================================================

    final slides = [
      originalSlides.last,
      ...originalSlides,
      originalSlides.first,
    ];

    return MouseRegion(
      onEnter: (_) {
        _isHovering = true;
        _stopAutoPlay();
      },
      onExit: (_) {
        _isHovering = false;
        _startAutoPlay();
      },
      child: SizedBox(
        height:
            MediaQuery.of(context).size.height * 0.70,
        width: double.infinity,
        child: Stack(
          children: [
            //=================================================================
            // SLIDES
            //=================================================================

            PageView.builder(
              controller: _pageController,
              itemCount: slides.length,
              onPageChanged: (pageIndex) {
                _handlePageChanged(
                  pageIndex,
                  originalSlides.length,
                );
              },
              itemBuilder: (context, index) {
                return HeroSlide(
                  slide: slides[index],
                  onGetStarted: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignUpScreen(),
                      ),
                    );
                  },
                  onLearnMore: () {
                    // Destination will be connected later.
                  },
                );
              },
            ),

            //=================================================================
            // INDICATORS
            //=================================================================

            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: HeroIndicators(
                itemCount: originalSlides.length,
                currentIndex: _currentIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}