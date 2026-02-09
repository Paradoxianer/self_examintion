# Flutter wrapper rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# local_auth plugin specific rules
-keep class com.baseflow.localauth.** { *; }
-keep class androidx.biometric.** { *; }

# FIX: Missing Play Store SplitInstall classes
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Prevent obfuscation of specialized classes
-keepattributes Signature
-keepattributes *Annotation*
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
