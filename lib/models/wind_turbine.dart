// model
class WtData {
  String dateUtc;
  double windSpeed;
  double rpmBilah;
  double rpmGenerator;
  double powerWatt;
  double ampereDc;
  double voltDc;

  WtData(
    this.dateUtc,
    this.windSpeed,
    this.rpmBilah,
    this.rpmGenerator,
    this.powerWatt,
    this.ampereDc,
    this.voltDc,
  );
}
