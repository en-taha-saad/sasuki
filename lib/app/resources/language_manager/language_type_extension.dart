import 'package:sasuki/app/resources/language_manager/language_type.dart';

const String arabic = 'ar';
const String english = 'en';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return arabic;
      case LanguageType.arabic:
        return arabic;
      default:
        return english;
    }
  }
}
