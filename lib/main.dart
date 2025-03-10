import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yatrigan/controller/auth/auth_ctrl.dart';
import 'package:yatrigan/view/init/init_view.dart';
import 'package:yatrigan/view/init/splash_screen.dart';
import 'package:yatrigan/view/main/home_screen_view.dart';

void main() async {
  runApp(const Yatrigan());
}

class Yatrigan extends StatelessWidget {
  const Yatrigan({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthCtrl(),
      child: MaterialApp(
        title: 'Yatrigan',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (_) => const SplashScreen(),
          InitView.id: (_) => const InitView(),
          HomeScreenView.id: (_) => const HomeScreenView(),
        },
      ),
    );
  }
}
