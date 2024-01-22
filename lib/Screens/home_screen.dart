import 'package:flutter/material.dart';

import '../widgets/shimmer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String dummyImageURL = 'assets/shimmer_user.jpg';
  final String dummyName = 'John Doe';
  final int dummyAge = 30;
  final String dummyEmail = 'john.doe@example.com';
  final String dummyMobile = '+1 234 567 890';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isDataLoaded = false; // Flag for data loading state

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.0).animate(_animationController);
    _animationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isDataLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return ScaleTransition(
            scale: _scaleAnimation,
            child: _isDataLoaded
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade200, Colors.teal.shade50],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 100.0,
                                    backgroundImage:
                                        AssetImage(widget.dummyImageURL),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    'Name: ${widget.dummyName}',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text('Age: ${widget.dummyAge}',
                                      style: const TextStyle(fontSize: 24)),
                                  const SizedBox(height: 10.0),
                                  Text('Email: ${widget.dummyEmail}',
                                      style: const TextStyle(fontSize: 24)),
                                  const SizedBox(height: 10.0),
                                  Text('Mobile: ${widget.dummyMobile}',
                                      style: const TextStyle(fontSize: 24)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.share),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const ShimmerWidget(),
          );
        },
      ),
    );
  }
}
