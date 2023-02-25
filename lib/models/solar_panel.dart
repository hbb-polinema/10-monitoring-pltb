class SpData {
  String dateUtc;
  double solarRad;
  double power;

  SpData(this.dateUtc, this.solarRad, this.power);
}

List<SpData> getSpData() {
  final List<SpData> chartSpData = [
    SpData("00:00", 2, 0),
    SpData("01:00", 2, 0),
    SpData("02:00", 2, 0),
    SpData("03:00", 2, 0),
    SpData("04:00", 2, 0),
    SpData("05:00", 2, 0),
    SpData("06:00", 2, 0),
    SpData("07:00", 2, 0),
    SpData("08:00", 2, 0),
    SpData("09:00", 2, 0),
    SpData("10:00", 2, 0),
    SpData("11:00", 2, 0),
    SpData("12:00", 2, 0),
    SpData("13:00", 2, 0),
    SpData("14:00", 2, 0),
    SpData("15:00", 2, 0),
    SpData("16:00", 2, 0),
    SpData("17:00", 2, 0),
    SpData("18:00", 2, 0),
    SpData("19:00", 2, 0),
    SpData("20:00", 2, 0),
    SpData("21:00", 2, 0),
    SpData("22:00", 2, 0),
    SpData("23:00", 2, 0),
    SpData("24:00", 2, 0),
  ];
  return chartSpData;
}
