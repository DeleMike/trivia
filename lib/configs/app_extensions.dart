/// App's String methods
extension StringExtension on String {
  ///Capitalize first letter of String
  ///```
  /// var str = 'boy';
  /// print(str.capitalize);
  /// // Output: 'Boy'
  ///```
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Remove all values before the colon in category name
  String removeColon() {
    return substring(indexOf(':') + 1);
  }

  bool isNumeric() {
    print('$this is a valid number =  ${double.tryParse(this) != null}');
    return int.tryParse(this) != null;
  }
}

extension NumExtension on num {}
