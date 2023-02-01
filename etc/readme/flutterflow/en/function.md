# Functions

## Country Code

- You can display a list of favorite countries on top with divider.
  - For favorites, you can add dial_code or country name in the list. And the country name in favotes is case sensitive.


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-dial-code-picker-code-expression.jpg?raw=true "Country Dial Code Picker")


# Testing

The current version of fireflow has no backend. ([The previous version of fireflow](https://github.com/thruthesky/fireflow_202211/tree/main/functions/src) was developed heavily based on Cloud Functions.) Now in this version, it simply works as a custom action and the most of the complicated logic goes under the scene. Yes, we need tests to give some trust on our code. And it's a bit different from the standard Flutter test.

- [Firestore security rule - unit test](https://github.com/withcenter/fireflow/blob/main/firebase/firestore/tests/test.spec.js).
- [Unit test and Widget test](https://github.com/withcenter/fireflow/tree/main/test).
  - These unit tests and widget tests follow the [flutter standart testing](https://docs.flutter.dev/cookbook/testing/widget/introduction) mechanism.
  - To run the test, simply run the `flutter test` command.
- Fireflow has its own unit test to make it easy for running the test on the real servers. It's called [fireflow real test](#fireflow-real-test).

## Fireflow real test

- Fireflow needs the tests run in the full functional app features and servers. The Integration test is too slow and I cannot work with it. So, I made one by myself. The test runs after boot or by manual trigger. And it does not report the test result. So, it's not fit for the test in CI/CD pipeline. But will do the unit test.
- See [the source code for fireflow real test](https://github.com/withcenter/fireflow/blob/main/example/lib/test.dart).
- To make it run,
  - You may need to set the `key.dart` file for the keys that you are going to test. (You may probably not need it)
  - Hot restart after updating the code.

# Developer coding guide


## Developing with Fireflow

If you want to update/improve the fireflow or if you want to work on your project other with fireflow, then follow the steps below.

1. Fork fireflow.
2. Clone fireflow from the fork.
3. Create your own branch.
4. Clone your project under `<fireflow>/apps` folder.
5. Change the path of fireflow package to `path: ../..` in the pubspec.yaml of your project.
6. One you have updated fireflow, create PR.

