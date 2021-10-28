class Wine {
  String note;
  String imageUrl;
  String type;
  String buyDt;
  String evaluation;
  String openDt;
  bool emptyYn;
  bool haveYn;
  num score;
  num abv;
  String name;
  String cask;
  num buyPrice;
  String db;
  String drinkDt;
  String id;

  Wine(
      {this.note,
        this.imageUrl,
        this.type,
        this.buyDt,
        this.evaluation,
        this.openDt,
        this.emptyYn,
        this.haveYn,
        this.score,
        this.abv,
        this.name,
        this.cask,
        this.buyPrice,
        this.db,
        this.drinkDt,
        this.id});

  Wine.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    imageUrl = json['image_url'];
    type = json['type'];
    buyDt = json['buy_dt'];
    evaluation = json['evaluation'];
    openDt = json['open_dt'];
    emptyYn = json['empty_yn'];
    haveYn = json['have_yn'];
    score = json['score'];
    abv = json['abv'];
    name = json['name'];
    cask = json['cask'];
    buyPrice = json['buy_price'];
    db = json['db'];
    drinkDt = json['drink_dt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['image_url'] = this.imageUrl;
    data['type'] = this.type;
    data['buy_dt'] = this.buyDt;
    data['evaluation'] = this.evaluation;
    data['open_dt'] = this.openDt;
    data['empty_yn'] = this.emptyYn;
    data['have_yn'] = this.haveYn;
    data['score'] = this.score;
    data['abv'] = this.abv;
    data['name'] = this.name;
    data['cask'] = this.cask;
    data['buy_price'] = this.buyPrice;
    data['db'] = this.db;
    data['drink_dt'] = this.drinkDt;
    data['id'] = this.id;
    return data;
  }
}