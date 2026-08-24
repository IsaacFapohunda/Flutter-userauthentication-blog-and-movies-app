import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/strings.dart';
import '../../model/gen/assets.gen.dart';
import '../../model/internet/internet.dart';



class NoInternetWidget extends ConsumerStatefulWidget {
  const NoInternetWidget({super.key});

  @override
  ConsumerState<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends ConsumerState<NoInternetWidget> {
  bool _isLoading = false;
  bool isConnected = false;
  @override

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final internetState =  ref.watch(internetProvider);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         // Assets.pngs.autoLayoutHorizontal.image(),

          SvgPicture.asset(
            Assets.svgs.icons.noConnection,
            height: 100,
            width: 100,
          ),
          Text(
            CustomStrings.noInternet1,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          Text(
            CustomStrings.noInternet2,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          const SizedBox(
            height: 20,
          ),
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
              onPressed: () async{
                await ref.read(internetProvider.notifier).checkConnectivity();
               Future.delayed(const Duration(seconds: 1), () {
                    if(internetState.status == ConnectivityStatus.connected){
                      if (kDebugMode) {
                        print("connected");
                      }
                      setState((){
                        isConnected = true;
                        _isLoading = false;
                      });

                    } else if(internetState.status == ConnectivityStatus.disconnected){
                      if (kDebugMode) {
                        print("disconnected");
                      }
                      setState(() {
                        isConnected = false;
                        _isLoading = true;
                      });
                    }
               });
              },
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}