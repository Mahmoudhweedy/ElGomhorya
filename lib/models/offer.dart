class Offers {
  final String startDate, endDate, type;
  final int productId, id;
  final List products;

  Offers({
    this.productId,
    this.startDate,
    this.endDate,
    this.type,
    this.id,
    this.products,
  });
  factory Offers.fromJson(Map json) {
    return Offers(
      id: json['id'],
      type: json['type'],
      productId: json['product_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      products: json["products"],
    );
  }
}

class LatestOffers {
  final List dailyOffers, weeklyOffers, monthlyOffers;

  LatestOffers({
    this.dailyOffers,
    this.weeklyOffers,
    this.monthlyOffers,
  });
  factory LatestOffers.fromJson(Map json) {
    return LatestOffers(
      dailyOffers: json["daily_offers"],
      weeklyOffers: json["weekly_offers"],
      monthlyOffers: json["monthly_offers"],
    );
  }
}

