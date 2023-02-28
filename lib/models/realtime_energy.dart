class RealtimeEnergy {
  String date;
  double powerWtDc;
  double powerSp;
  double windSpeed;
  double rpmBilah;
  double rpmGenerator;
  double voltDc;
  double voltAc;
  double ampereDc;
  double ampereAc;
  double solarRad;
  String dateCalc;
  double powerCalc;
  RealtimeEnergy(
      this.date, this.powerWtDc, this.powerSp, this.windSpeed, this.rpmBilah, this.rpmGenerator, this.voltDc, this.voltAc, this.ampereDc, this.ampereAc, this.solarRad, this.dateCalc, this.powerCalc);
}
