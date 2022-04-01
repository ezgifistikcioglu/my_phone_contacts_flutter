import 'package:flexidate/flexidate.dart';

extension FlexiDateFormat on FlexiDate {
  String format() {
    return [year, month, day].where((d) => d != null).join('-');
  }
}

extension DateTimeFormatExt on DateTime {
  String format() {
    return toIso8601String();
  }
}

/// The platforms that a [_Phonenumber] may be available on.
/// Either the number is available for [textCall] or [whatsapp].
enum ContactPlatform { textCall, whatsapp }

/// Extra methods attached to [ContactPlatform].
extension PlatformShortString on ContactPlatform {
  /// The default toString for enums creates a string in the format EnumName.value.
  /// This method creates a string with the value only.
  String toShortString() {
    return toString().split('.').last;
  }
}

/// The different types of [Contact]s.
///
/// A [Contact] can be an [emergency] contact,
/// an [office], [facultyStaff], or faculty wide or uncategorized as [other].
enum ContactType { emergency, office, facultyStaff, other }

/// Extra methods attached to [ContactType].
extension ContactTypeShortString on ContactType {
  /// The default toString for enums creates a string in the format EnumName.value.
  /// This method creates a string with the value only.
  String toShortString() {
    return toString().split('.').last;
  }
}
