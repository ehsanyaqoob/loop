import 'package:loop/export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
           

            // Main Content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: context.buttonBackground.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.loop_rounded,
                        size: 60,
                        color: context.icon,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Welcome Message
                    MyText(
                      text: 'Welcome to Loop!',
                      size: 28,
                      weight: FontWeight.w600,
                      color: context.text,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Subtitle
                    MyText(
                      text: 'Ready to connect and share',
                      size: 16,
                      color: context.subtitle,
                    ),
                    
                    const SizedBox(height: 40),
                  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}