// model
class WtData {
  String dateUtc;
  double windSpeed;
  double rpmBilah;
  double rpmGenerator;
  double powerAc;
  double powerDc;

  WtData(
    this.dateUtc,
    this.windSpeed,
    this.rpmBilah,
    this.rpmGenerator,
    this.powerAc,
    this.powerDc,
  );
}
