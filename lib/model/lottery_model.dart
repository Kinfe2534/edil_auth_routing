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

class Ticket {
  final int id;
  final String loto_number;
  final String ticket_number;
  final int cost;
  final User user;
  final Lottery lottery;
  final bool thirdWinner;
  final bool secondWinner;
  final bool firstWinner;
  Ticket({
    this.id,
    this.loto_number,
    this.ticket_number,
    this.cost,
    this.user,
    this.lottery,
    this.thirdWinner,
    this.secondWinner,
    this.firstWinner,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as int,
      loto_number: json['loto_number'] as String,
      ticket_number: json['ticket_number'] as String,
      cost: json['cost'] as int,
      user: User.fromJson(json['user']),
      lottery: Lottery.fromJson(json['lottery']),
      thirdWinner: json['thirdWinner'] as bool,
      secondWinner: json['secondWinner'] as bool,
      firstWinner: json['firstWinner'] as bool,
    );
  }
}

class User {
  final int id;
  final String username;
  final String email;
  final String name;
  final String gender;
  final String dob;
  final double balance;
  final String region;
  final String zone_subscity;
  final String woreda;
  final String kebele;
  final String house_no;
  final String user_code;
  final String cellphone;
  final String homephone;
  User({
    this.id,
    this.username,
    this.email,
    this.name,
    this.gender,
    this.dob,
    this.balance,
    this.region,
    this.zone_subscity,
    this.woreda,
    this.kebele,
    this.house_no,
    this.user_code,
    this.cellphone,
    this.homephone,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String,
      balance: json['balance'] as double,
      region: json['region'] as String,
      zone_subscity: json['zone_subscity'] as String,
      woreda: json['woreda'] as String,
      kebele: json['kebele'] as String,
      house_no: json['house_no'] as String,
      user_code: json['user_code'] as String,
      cellphone: json['cellphone'] as String,
      homephone: json['homephone'] as String,
    );
  }
}

class TicketOrder {
  int cost;
  int lottery_id;
  int user_id;
  String loto_numbers;

  TicketOrder({this.cost, this.lottery_id, this.user_id, this.loto_numbers});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["cost"] = cost;
    data["lottery_id"] = lottery_id;
    data["user_id"] = user_id;
    data["loto_numbers"] = loto_numbers;
    return data;
  }
}
