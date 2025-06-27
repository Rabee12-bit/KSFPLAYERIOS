import 'package:flutter/material.dart';
import 'services/activation_service.dart';
import 'screens/activation_screen.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isActivated = await ActivationService.isActivated();
  runApp(KSFPlayerApp(isActivated: isActivated));
}

class KSFPlayerApp extends StatelessWidget {
  final bool isActivated;
  const KSFPlayerApp({required this.isActivated, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KSF Player iOS',
      theme: darkTheme,
      home: isActivated ? HomeScreen() : ActivationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
