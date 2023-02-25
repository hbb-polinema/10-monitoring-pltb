// model
class WtData {
  String dateUtc;
  double windSpeed;
  String windDir;
  String rpm1;
  String rpm2;
  double voltAc;
  double voltDc;
  double ampereAc;
  double ampereDc;
  double temp1;
  double temp2;
  double vibraVolt1;
  String vibraFreq1;
  double vibraVolt2;
  String vibraFreq2;
  double vibraVolt3;
  String vibraFreq3;
  double vibraVolt4;
  String vibraFreq4;
  double noiseVolt;
  String noiseFreq;
  String velo1;
  String velo2;
  double gyroX;
  double gyroY;
  double gyroZ;
  double power;

  WtData(
    this.dateUtc,
    this.windSpeed,
    this.windDir,
    this.rpm1,
    this.rpm2,
    this.voltAc,
    this.voltDc,
    this.ampereAc,
    this.ampereDc,
    this.temp1,
    this.temp2,
    this.vibraVolt1,
    this.vibraFreq1,
    this.vibraVolt2,
    this.vibraFreq2,
    this.vibraVolt3,
    this.vibraFreq3,
    this.vibraVolt4,
    this.vibraFreq4,
    this.noiseVolt,
    this.noiseFreq,
    this.velo1,
    this.velo2,
    this.gyroX,
    this.gyroY,
    this.gyroZ,
    this.power,
  );
}
