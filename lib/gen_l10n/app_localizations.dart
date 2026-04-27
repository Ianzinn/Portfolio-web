import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio — Mobile Dev'**
  String get appTitle;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Developer'**
  String get heroTitle;

  /// No description provided for @heroDescription.
  ///
  /// In en, this message translates to:
  /// **'I turn ideas into exceptional mobile applications. Specialized in cross-platform development with Flutter, creating smooth and high-performance experiences for Android and iOS.'**
  String get heroDescription;

  /// No description provided for @heroCtaProjects.
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get heroCtaProjects;

  /// No description provided for @heroCtaDownloadCv.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get heroCtaDownloadCv;

  /// No description provided for @skillsSectionComment.
  ///
  /// In en, this message translates to:
  /// **'Technology Stack'**
  String get skillsSectionComment;

  /// No description provided for @skillsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skillsSectionTitle;

  /// No description provided for @skillsSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Full skill set for end-to-end mobile development'**
  String get skillsSectionSubtitle;

  /// No description provided for @skillsCategoryMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile Development'**
  String get skillsCategoryMobile;

  /// No description provided for @skillsCategoryLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get skillsCategoryLanguages;

  /// No description provided for @skillsCategoryArchitecture.
  ///
  /// In en, this message translates to:
  /// **'Architecture'**
  String get skillsCategoryArchitecture;

  /// No description provided for @skillsCategoryUiUx.
  ///
  /// In en, this message translates to:
  /// **'UI/UX'**
  String get skillsCategoryUiUx;

  /// No description provided for @skillsCategoryBackend.
  ///
  /// In en, this message translates to:
  /// **'Backend & APIs'**
  String get skillsCategoryBackend;

  /// No description provided for @skillsCategoryTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get skillsCategoryTools;

  /// No description provided for @projectsSectionComment.
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get projectsSectionComment;

  /// No description provided for @projectsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get projectsSectionTitle;

  /// No description provided for @projectsSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Some of my most recent work in mobile development'**
  String get projectsSectionSubtitle;

  /// No description provided for @projectsButtonGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get projectsButtonGithub;

  /// No description provided for @projectsButtonDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get projectsButtonDemo;

  /// No description provided for @projectsButtonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get projectsButtonRetry;

  /// No description provided for @experienceSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Professional Experience'**
  String get experienceSectionTitle;

  /// No description provided for @experienceSectionDescription.
  ///
  /// In en, this message translates to:
  /// **'My journey in mobile development'**
  String get experienceSectionDescription;

  /// No description provided for @contactSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get contactSectionTitle;

  /// No description provided for @contactSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Have a project in mind? Let\'s talk'**
  String get contactSectionSubtitle;

  /// No description provided for @contactInfoLocation.
  ///
  /// In en, this message translates to:
  /// **'Belo Horizonte, Brazil'**
  String get contactInfoLocation;

  /// No description provided for @contactFormNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get contactFormNameHint;

  /// No description provided for @contactFormNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get contactFormNameError;

  /// No description provided for @contactFormEmailHint.
  ///
  /// In en, this message translates to:
  /// **'your@email.com'**
  String get contactFormEmailHint;

  /// No description provided for @contactFormEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get contactFormEmailError;

  /// No description provided for @contactFormEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get contactFormEmailInvalid;

  /// No description provided for @contactFormMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Tell me about your project...'**
  String get contactFormMessageHint;

  /// No description provided for @contactFormMessageError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your message'**
  String get contactFormMessageError;

  /// No description provided for @contactFormSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contactFormSendButton;

  /// No description provided for @contactFormSendingButton.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get contactFormSendingButton;

  /// No description provided for @contactSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get contactSuccessTitle;

  /// No description provided for @contactSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Thank you for reaching out. I\'ll get back to you soon.'**
  String get contactSuccessBody;

  /// No description provided for @contactSuccessRetry.
  ///
  /// In en, this message translates to:
  /// **'Send another message'**
  String get contactSuccessRetry;

  /// No description provided for @contactErrorNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No connection. Please try again.'**
  String get contactErrorNoConnection;

  /// No description provided for @footerBuiltWith.
  ///
  /// In en, this message translates to:
  /// **'Built with'**
  String get footerBuiltWith;

  /// No description provided for @footerEof.
  ///
  /// In en, this message translates to:
  /// **'EOF - End of File'**
  String get footerEof;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'Mobile Developer Portfolio'**
  String get footerCopyright;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
