Following the CodeLab for "How to Test a Flutter App": https://codelabs.developers.google.com/codelabs/flutter-app-testing/

To run Widget tests: `flutter test`

To run Integration tests: `flutter drive --driver integration_test/driver.dart --target integration_test/app_test.dart --no-dds`

Note that the `--no-dds` option is not listed in the tutorial, but is required for the scrolling test
when running on a physical device
