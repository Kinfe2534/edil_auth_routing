class Lottery {
  final int id;
  final String lotteryCode;
  final String type;
  final String lotDay;
  final double prize;
  final bool minPlayerLimitNotMet;
  final bool drawn;
  final bool scheduled;

  Lottery(
      {this.id,
      this.lotteryCode,
      this.type,
      this.lotDay,
      this.prize,
      this.minPlayerLimitNotMet,
      this.drawn,
      this.scheduled});
  factory Lottery.fromJson(Map<String, dynamic> json) {
    return Lottery(
      id: json['id'] as int,
      lotteryCode: json['lottery_code'] as String,
      type: json['type'] as String,
      lotDay: json['lot_day'] as String,
      prize: json['prize'] as double,
      minPlayerLimitNotMet: json['mminPlayerLimitNotMet'] as bool,
      drawn: json['drawn'] as bool,
      scheduled: json['scheduled'] as bool,
    );
  }
}
