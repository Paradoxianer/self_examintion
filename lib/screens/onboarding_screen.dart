import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final theme = Theme.of(context);

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
            assetPath: "assets/onboarding/charts.png",
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
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                HapticFeedback.selectionClick();
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return _buildPage(pages[index]);
              },
            ),
            Positioned(
              bottom: 20,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: Text(localization.onboardingSkip, 
                        style: TextStyle(color: theme.colorScheme.outline, fontWeight: FontWeight.w500)),
                  ),
                  Row(
                    children: List.generate(
                      pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _currentPage == index
                              ? theme.primaryColor
                              : theme.colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      if (_currentPage < pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                        );
                      } else {
                        _finishOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(_currentPage == pages.length - 1
                        ? localization.onboardingStart
                        : localization.onboardingNext,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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
          const SizedBox(height: 40),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 28, 
              fontWeight: FontWeight.w800, 
              color: Theme.of(context).primaryColor,
              letterSpacing: -0.5
            ),
            textAlign: TextAlign.center,
          ),
          if (page.description != null) ...[
            const SizedBox(height: 16),
            Text(
              page.description!,
              style: TextStyle(
                fontSize: 15, 
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: page.steps.map((step) => _buildStep(step)).toList(),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildStep(OnboardingStep step) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        children: [
          if (step.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                step.title!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          Text(
            step.description,
            style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface, height: 1.4),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              step.assetPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Icon(step.icon, size: 48, color: theme.colorScheme.outlineVariant));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _finishOnboarding() {
    HapticFeedback.mediumImpact();
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
