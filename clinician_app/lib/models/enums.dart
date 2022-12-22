enum ExpectedWearingTime { good, bad }

extension ExpectedWearingTimeWithValues on ExpectedWearingTime {
  int get id {
    switch (this) {
      case ExpectedWearingTime.good:
        return 21;
      case ExpectedWearingTime.bad:
        return 12;
      default:
        return -1;
    }
  }
}
