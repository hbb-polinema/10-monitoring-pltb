class RealtimeEnergy {
  String date;
  double powerWtDc;
  double powerSp;
  double powerDiesel;
  double windSpeed;
  double rpmBilah;
  double rpmGenerator;
  double voltDc;
  double voltAc;
  double ampereDc;
  double ampereAc;
  double solarRad;
  double bbm;
  String dateCalc;
  double powerCalc;
  RealtimeEnergy(
    this.date,
    this.powerWtDc,
    this.powerSp,
    this.powerDiesel,
    this.windSpeed,
    this.rpmBilah,
    this.rpmGenerator,
    this.voltDc,
    this.voltAc,
    this.ampereDc,
    this.ampereAc,
    this.solarRad,
    this.bbm,
    this.dateCalc,
    this.powerCalc,
  );
}
