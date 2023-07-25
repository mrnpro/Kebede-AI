import 'package:flutter/material.dart';

import 'core/constants/colors.dart';
import 'di/injection_container.dart';
import 'modules/Prompt/presentation/Screens/prompt_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  configureDependencies();
  await getIt.allReady().then((value) {
    runApp(
      DevicePreview(
        enabled: false,
        //enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kebede AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, background: kPrimaryColor),
        useMaterial3: true,
      ),
      home: const PromptScreen(),
    );
  }
}
