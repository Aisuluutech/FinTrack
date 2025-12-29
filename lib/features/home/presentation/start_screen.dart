import 'package:fintrack/features/home/presentation/dashboard.dart';
import 'package:fintrack/features/home/widgets/background_container.dart';
import 'package:fintrack/providers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationService = ref.read(navigationProvider);

    return Scaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Welcome',
                    style: GoogleFonts.dancingScript(
                      textStyle: TextStyle(fontSize: 40),
                     color: const Color.fromARGB(255, 24, 12, 12),
                    ),
                  ),
                ),
                Text(
                  'Track. Control. Save',
                  style: GoogleFonts.dancingScript(
                    textStyle: TextStyle(fontSize: 36),
                    color: const Color.fromARGB(255, 24, 12, 12),
                  ),
                ),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    navigationService.push(Dashboard());
                  },
                  child: Text(
                    'Start',
                    style: GoogleFonts.dancingScript(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                     color: const Color.fromARGB(255, 24, 12, 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
