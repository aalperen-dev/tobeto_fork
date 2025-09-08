import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('de'),
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @assessment_tools_content.
  ///
  /// In en, this message translates to:
  /// **'Technical and competency assessment tools for candidates who want to gain new skills (reskill) or start a new role (upskill).'**
  String get assessment_tools_content;

  /// No description provided for @assessment_tools_header.
  ///
  /// In en, this message translates to:
  /// **'ASSESSMENT TOOLS'**
  String get assessment_tools_header;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @blog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get blog;

  /// No description provided for @bootcamp_content.
  ///
  /// In en, this message translates to:
  /// **'Access to a large pool of evaluated and trained talents, along with assessment, selection, and reporting services.'**
  String get bootcamp_content;

  /// No description provided for @bootcamp_header.
  ///
  /// In en, this message translates to:
  /// **'BOOTCAMP'**
  String get bootcamp_header;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @company_name.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get company_name;

  /// No description provided for @company_title.
  ///
  /// In en, this message translates to:
  /// **'Company Title'**
  String get company_title;

  /// No description provided for @contact_form.
  ///
  /// In en, this message translates to:
  /// **'Contact Form'**
  String get contact_form;

  /// No description provided for @contact_info.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contact_info;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @contact_us_button.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us_button;

  /// No description provided for @contact_us_title.
  ///
  /// In en, this message translates to:
  /// **'Contact us for custom training packages and bootcamp programs for companies'**
  String get contact_us_title;

  /// No description provided for @development_content.
  ///
  /// In en, this message translates to:
  /// **'Support for the development and positioning of the existing talent pool in line with corporate goals.'**
  String get development_content;

  /// No description provided for @development_header.
  ///
  /// In en, this message translates to:
  /// **'DEVELOPMENT'**
  String get development_header;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @evaluation_content.
  ///
  /// In en, this message translates to:
  /// **'Access to a large pool of evaluated and trained talents, along with assessment, selection, and reporting services.'**
  String get evaluation_content;

  /// No description provided for @evaluation_header.
  ///
  /// In en, this message translates to:
  /// **'EVALUATION'**
  String get evaluation_header;

  /// No description provided for @for_companies.
  ///
  /// In en, this message translates to:
  /// **'For Companies'**
  String get for_companies;

  /// No description provided for @for_employees_tobeto.
  ///
  /// In en, this message translates to:
  /// **'Tobeto for Your Employees'**
  String get for_employees_tobeto;

  /// No description provided for @for_individuals.
  ///
  /// In en, this message translates to:
  /// **'For Individuals'**
  String get for_individuals;

  /// No description provided for @get_in_touch.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get get_in_touch;

  /// No description provided for @in_the_press.
  ///
  /// In en, this message translates to:
  /// **'In the Press'**
  String get in_the_press;

  /// No description provided for @matching_content.
  ///
  /// In en, this message translates to:
  /// **'Fast and accurate hiring for flexible, remote, full-time workforce.'**
  String get matching_content;

  /// No description provided for @matching_header.
  ///
  /// In en, this message translates to:
  /// **'MATCHING'**
  String get matching_header;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @name_surname.
  ///
  /// In en, this message translates to:
  /// **'Name Surname'**
  String get name_surname;

  /// No description provided for @our_trainings.
  ///
  /// In en, this message translates to:
  /// **'Our Trainings'**
  String get our_trainings;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @reach_right_talent.
  ///
  /// In en, this message translates to:
  /// **'To Reach the Right Talent'**
  String get reach_right_talent;

  /// No description provided for @ready_candidates.
  ///
  /// In en, this message translates to:
  /// **'Trains candidates ready for employment to meet the changing talent needs of organizations.'**
  String get ready_candidates;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @support_existing_skills.
  ///
  /// In en, this message translates to:
  /// **'Supports updating existing skills or gaining new ones according to the needs of employees.'**
  String get support_existing_skills;

  /// No description provided for @tax_number.
  ///
  /// In en, this message translates to:
  /// **'Tax Number'**
  String get tax_number;

  /// No description provided for @tax_office.
  ///
  /// In en, this message translates to:
  /// **'Tax Office'**
  String get tax_office;

  /// No description provided for @text_message.
  ///
  /// In en, this message translates to:
  /// **'Text a Message'**
  String get text_message;

  /// No description provided for @tobeto_mission.
  ///
  /// In en, this message translates to:
  /// **'Tobeto; discovers talents, develops them, and prepares them for new jobs.'**
  String get tobeto_mission;

  /// No description provided for @training_content.
  ///
  /// In en, this message translates to:
  /// **'Participation in trainings opened according to the needs of gaining new expertise skills and competencies for a new role, and the possibility of opening special classes for the institution.'**
  String get training_content;

  /// No description provided for @training_header.
  ///
  /// In en, this message translates to:
  /// **'TRAINING'**
  String get training_header;

  /// No description provided for @what_we_offer.
  ///
  /// In en, this message translates to:
  /// **'What We Offer?'**
  String get what_we_offer;

  /// No description provided for @whats_happening_at_tobeto.
  ///
  /// In en, this message translates to:
  /// **'What\'s Happening at Tobeto?'**
  String get whats_happening_at_tobeto;

  /// No description provided for @who_we_are.
  ///
  /// In en, this message translates to:
  /// **'Who We Are?'**
  String get who_we_are;
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
      <String>['de', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
