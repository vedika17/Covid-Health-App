class HealthDataEntry {
  String temprature,
      oxy,
      pulse,
      cough,
      cold,
      lossofTaste,
      lossofSmell,
      other,
      coughSevarity,
      coughType;
  String date;
  DateTime dataTime;

  HealthDataEntry(
      {this.temprature,
      this.oxy,
      this.pulse,
      this.cough,
      this.cold,
      this.lossofSmell,
      this.lossofTaste,
      this.other,
      this.coughSevarity,
      this.coughType,
      this.dataTime,
      this.date});
}
