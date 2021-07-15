# semaphoreci_flutter_demo

[![Build Status](https://semaphore-demos.semaphoreci.com/badges/semaphore-demo-flutter2/branches/master.svg?style=shields)](https://semaphore-demos.semaphoreci.com/projects/semaphore-demo-flutter2) [![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

## Versions

| Name           | Version           |
| -------------- | ----------------- |
| Flutter SDK    | v2.2.2 (stable) |
| Dart SDK       | > 2.12.0        |


## Setup

1. Run diagnostics

Verify installed Flutter SDK version

```
flutter doctor -v
```

2. Clone the project

```
git clone https://github.com/joshuamdeguzman/semaphoreci_flutter_demo
```

3. Install dependencies

```
flutter packages get
```

4. Run the project

```
flutter run
```

5. Run the unit & widget tests

```
flutter test test
```

6. Run the integration tests

For example, adding new item in the list

```
flutter test integration_test/add_new_todo_item_test.dart
```

See [integration_test](https://github.com/joshuamdeguzman/semaphoreci_flutter_demo)s for the list of available integration tests.