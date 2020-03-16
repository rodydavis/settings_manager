class Test {
  bool testValue;
  Test({this.testValue});

  Test copyWith({
    bool testValue,
  }) {
    return Test(
      testValue: testValue ?? this.testValue,
    );
  }
}
