import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/local_storage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    // 3-Screen-Structure based on AppLocalizations
    final List<OnboardingPageData> pages = [
      OnboardingPageData(
        title: localization.onboarding1Title,
        description: localization.onboarding1DescriptionTop,
        steps: [
          OnboardingStep(
            description: localization.onboarding1DescriptionBottom,
            assetPath: "assets/onboarding/select_set.png",
            icon: Icons.auto_awesome,
          ),
        ],
      ),
      OnboardingPageData(
        title: localization.onboarding2Title,
        steps: [
          OnboardingStep(
            title: localization.onboarding2Step1Title,
            description: localization.onboarding2Step1Description,
            assetPath: "assets/onboarding/slider.png",
            icon: Icons.linear_scale,
          ),
          OnboardingStep(
            title: localization.onboarding2Step2Title,
            description: localization.onboarding2Step2Description,
            assetPath: "assets/onboarding/notes.png",
            icon: Icons.note_add_outlined,
          ),
        ],
      ),
      OnboardingPageData(
        title: localization.onboarding3Title,
        steps: [
          OnboardingStep(
            title: localization.onboarding3Step1Title,
            description: localization.onboarding3Step1Description,
            assetPath: "assets/onboarding/swipe.png",
            icon: Icons.swipe,
          ),
          OnboardingStep(
            title: localization.onboarding3Step2Title,
            description: localization.onboarding3Step2Description,
            assetPath: "assets/onboarding/privacy.png",
            icon: Icons.security,
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return _buildPage(pages[index]);
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
                      pages.length,
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
                      if (_currentPage < pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _finishOnboarding();
                      }
                    },
                    child: Text(_currentPage == pages.length - 1
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

  Widget _buildPage(OnboardingPageData page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            page.title,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          if (page.description != null) ...[
            const SizedBox(height: 16),
            Text(
              page.description!,
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: page.steps.map((step) => _buildStep(step)).toList(),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStep(OnboardingStep step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          if (step.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                step.title!,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          Text(
            step.description,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              step.assetPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Icon(step.icon, size: 48, color: Colors.grey.shade300));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _finishOnboarding() {
    LocalStorage().setBool('onboardingCompleted', true);
    Navigator.of(context).pop();
  }
}

class OnboardingPageData {
  final String title;
  final String? description;
  final List<OnboardingStep> steps;
  OnboardingPageData({required this.title, this.description, required this.steps});
}

class OnboardingStep {
  final String? title;
  final String description;
  final String assetPath;
  final IconData icon;

  OnboardingStep({
    this.title,
    required this.description,
    required this.assetPath,
    required this.icon,
  });
}
