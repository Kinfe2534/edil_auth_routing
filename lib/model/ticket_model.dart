class Ticket {
  int cost;
  int lottery_id;
  int user_id;
  List<dynamic> loto_numbers;

  Ticket({this.cost, this.lottery_id, this.user_id, this.loto_numbers});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["cost"] = cost;
    data["lottery_id"] = lottery_id;
    data["user_id"] = user_id;
    data["loto_numbers"] = loto_numbers;
    return data;
  }
}
