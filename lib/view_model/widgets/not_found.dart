import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/strings.dart';

class NotFound extends StatefulWidget {
  const NotFound({

    required this.url,
    required this.title1,
    required this.title2,
    super.key,
  });

  final String url;
  final String title1;
  final String title2;

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      // if (mounted) {
      //   if (!context
      //       .read<NavigationBarProvider>()
      //       .animationController
      //       .isAnimating) {
      //     context.read<NavigationBarProvider>().animationController.reverse();
      //   }
      // }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            CustomStrings.pageNotFound1,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 5),
          Text(
            CustomStrings.pageNotFound2,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )
          else
            TextButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).cardColor,
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onPressed: () {
                setState(() => _isLoading = true);

                Future.delayed(const Duration(seconds: 3), () {

                  setState(() => _isLoading = false);
                });
              },
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}