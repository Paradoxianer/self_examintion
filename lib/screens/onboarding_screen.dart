import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/local_storage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    
    final List<OnboardingContent> _content = [
      OnboardingContent(
        title: localization.onboarding1Title,
        description: localization.onboarding1Description,
        assetPath: "assets/onboarding/step1.png",
        icon: Icons.start,
      ),
      OnboardingContent(
        title: localization.onboarding2Title,
        description: localization.onboarding2Description,
        assetPath: "assets/onboarding/step2.png",
        icon: Icons.edit_note,
      ),
      OnboardingContent(
        title: localization.onboarding3Title,
        description: localization.onboarding3Description,
        assetPath: "assets/onboarding/step3.png",
        icon: Icons.query_stats,
      ),
      OnboardingContent(
        title: localization.onboarding4Title,
        description: localization.onboarding4Description,
        assetPath: "assets/onboarding/step4.png",
        icon: Icons.filter_alt,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _content.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return _buildPage(_content[index]);
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: Text(localization.onboardingSkip, style: const TextStyle(color: Colors.grey)),
                  ),
                  Row(
                    children: List.generate(
                      _content.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _content.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _finishOnboarding();
                      }
                    },
                    child: Text(_currentPage == _content.length - 1
                        ? localization.onboardingStart
                        : localization.onboardingNext),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingContent item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            item.description,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                item.assetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 120, color: Colors.grey.shade300),
                        const SizedBox(height: 10),
                        Text(
                          "(Image missing: ${item.assetPath})",
                          style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  void _finishOnboarding() {
    LocalStorage().setBool('onboardingCompleted', true);
    Navigator.of(context).pop();
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final String assetPath;
  final IconData icon;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.assetPath,
    required this.icon,
  });
}
