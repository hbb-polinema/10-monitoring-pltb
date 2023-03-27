class RealtimeEnergy {
  String dateUtc;
  double windSpeed;
  double rpmBilah;
  double rpmGenerator;
  double powerAc;
  double powerDc;

  double powerSp;
  double powerDiesel;
  double solarRad;
  double bbm;
  RealtimeEnergy(
    this.dateUtc,
    this.windSpeed,
    this.rpmBilah,
    this.rpmGenerator,
    this.powerAc,
    this.powerDc,
    this.powerSp,
    this.powerDiesel,
    this.solarRad,
    this.bbm,
  );
}
