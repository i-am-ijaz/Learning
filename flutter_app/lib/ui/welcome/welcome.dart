// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/core/size_config.dart';

import 'bloc/welcome_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _pageCont = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.only(top: 34),
              width: getProportionalScreenWidth(375),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: _pageCont,
                    onPageChanged: (index) {
                      context.read<WelcomeBloc>().add(
                            WelcomeEvent(page: index),
                          );
                    },
                    children: [
                      _WelcomePage(
                        index: 1,
                        btnText: 'Next',
                        title: 'First See Learning',
                        subTitle:
                            'Forget about a for of paper all knowledge in one learning',
                        imagePath: 'assets/images/reading.png',
                        controller: _pageCont,
                      ),
                      _WelcomePage(
                        index: 2,
                        btnText: 'Next',
                        title: 'Connect With Everyone',
                        subTitle:
                            'Always keep in touch with your tutor & friend. Let\'s get connected!',
                        imagePath: 'assets/images/boy.png',
                        controller: _pageCont,
                      ),
                      _WelcomePage(
                        index: 3,
                        btnText: 'Get Started',
                        title: 'Always Fascinated Learning',
                        subTitle:
                            'Anywhere anytime. The time is at your discretion so study whenever you want.',
                        imagePath: 'assets/images/man.png',
                        controller: _pageCont,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: getProportionalScreenHeight(100),
                    child: DotsIndicator(
                      dotsCount: 3,
                      position: state.page,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: const DotsDecorator(
                        color: Colors.grey,
                        activeColor: Colors.blue,
                        size: Size.square(8),
                        activeSize: Size(18, 8),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final int index;
  final String btnText;
  final String title;
  final String subTitle;
  final String imagePath;
  final PageController controller;
  const _WelcomePage({
    Key? key,
    required this.index,
    required this.btnText,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionalScreenWidth(345),
          height: getProportionalScreenHeight(345),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
          },
          child: Container(
            height: getProportionalScreenHeight(50),
            width: getProportionalScreenWidth(375),
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 100,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
