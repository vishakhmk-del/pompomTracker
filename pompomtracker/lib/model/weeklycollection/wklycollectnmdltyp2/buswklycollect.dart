class Buswklycollectlist {
  String? amount;
  String? paydate;
  Buswklycollectlist({this.amount, this.paydate});
  static Buswklycollectlist fromMap(Map<String, dynamic> map) {
    final amount = map['amount'] as String;
    final paydate = map['pay_date'] as String;
    return Buswklycollectlist(
      amount: amount,
      paydate: paydate,
    );
  }

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "pay_date": paydate,
      };
}
