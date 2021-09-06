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
  factory Lottery.fromJson(Map<String, dynamic> jsonMap) {
    return Lottery(
      id: jsonMap['id'] as int,
      lotteryCode: jsonMap['lottery_code'] as String,
      type: jsonMap['type'] as String,
      lotDay: jsonMap['lot_day'] as String,
      prize: jsonMap['prize'] as double,
      minPlayerLimitNotMet: jsonMap['mminPlayerLimitNotMet'] as bool,
      drawn: jsonMap['drawn'] as bool,
      scheduled: jsonMap['scheduled'] as bool,
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

  factory Ticket.fromJson(Map<String, dynamic> jsonMap) {
    return Ticket(
      id: jsonMap['id'] as int,
      loto_number: jsonMap['loto_number'] as String,
      ticket_number: jsonMap['ticket_number'] as String,
      cost: jsonMap['cost'] as int,
      user: User.fromJson(jsonMap['user']),
      lottery: Lottery.fromJson(jsonMap['lottery']),
      thirdWinner: jsonMap['thirdWinner'] as bool,
      secondWinner: jsonMap['secondWinner'] as bool,
      firstWinner: jsonMap['firstWinner'] as bool,
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
  factory User.fromJson(Map<String, dynamic> jsonMap) {
    return User(
      id: jsonMap['id'] as int,
      username: jsonMap['username'] as String,
      email: jsonMap['email'] as String,
      name: jsonMap['name'] as String,
      gender: jsonMap['gender'] as String,
      dob: jsonMap['dob'] as String,
      balance: jsonMap['balance'] as double,
      region: jsonMap['region'] as String,
      zone_subscity: jsonMap['zone_subscity'] as String,
      woreda: jsonMap['woreda'] as String,
      kebele: jsonMap['kebele'] as String,
      house_no: jsonMap['house_no'] as String,
      user_code: jsonMap['user_code'] as String,
      cellphone: jsonMap['cellphone'] as String,
      homephone: jsonMap['homephone'] as String,
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

class LotteryOrder {
  String type;
  String lot_day;
  int prize;
  LotteryOrder({this.type, this.lot_day, this.prize});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["type"] = type;
    data["lot_day"] = lot_day;
    data["prize"] = prize;

    return data;
  }
}

class Winners {
  final int id;
  final String winners_number;
  final Lottery lottery;
  final Winner first_winner;
  final Winner second_winner;
  final Winner third_winner;

  Winners(
      {this.id,
      this.winners_number,
      this.lottery,
      this.first_winner,
      this.second_winner,
      this.third_winner});
  factory Winners.fromJson(Map<String, dynamic> jsonMap) {
    return Winners(
        id: jsonMap['id'] as int,
        winners_number: jsonMap['winners_number'] as String,
        lottery: Lottery.fromJson(jsonMap['lottery']),
        first_winner: Winner.fromJson(jsonMap['first_winner']),
        second_winner: Winner.fromJson(jsonMap['second_winner']),
        third_winner: Winner.fromJson(jsonMap['third_winner']));
  }
}

class Winner {
  final int id;
  final String loto_number;
  final String ticket_number;
  final int cost;
  final User user;
  final Lottery lottery;
  final bool firstWinner;
  final bool secondWinner;
  final bool thirdWinner;

  Winner(
      {this.id,
      this.loto_number,
      this.ticket_number,
      this.cost,
      this.user,
      this.lottery,
      this.firstWinner,
      this.secondWinner,
      this.thirdWinner});
  factory Winner.fromJson(Map<String, dynamic> jsonMap) {
    return Winner(
      id: jsonMap['id'] as int,
      loto_number: jsonMap['loto_number'] as String,
      ticket_number: jsonMap['ticket_number'] as String,
      cost: jsonMap['cost'] as int,
      user: User.fromJson(jsonMap['user']),
      lottery: Lottery.fromJson(jsonMap['lottery']),
      firstWinner: jsonMap['firstWinner'] as bool,
      secondWinner: jsonMap['secondWinner'] as bool,
      thirdWinner: jsonMap['thirdWinner'] as bool,
    );
  }
}
