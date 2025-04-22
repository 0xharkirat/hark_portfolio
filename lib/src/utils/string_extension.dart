//create a string extension to capitalize the first letter
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  // convert kebab-case to PascalCase
  String kebabToPascalCase() {
    return split('-').map((word) => word.capitalize()).join();
  }
}