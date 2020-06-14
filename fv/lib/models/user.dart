class User {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;
  int answerPrice1;
  int answerPrice2;
  int answerPrice3;
  int answerDuration;
  String bio;
  bool isInfCert;
  int maxQuestionCharcount;
  int rating;
  String category;
  int reviews;
  int infWorth;
  int infSent;
  int infReceived;
  bool isInfluencer;
  String hashtags;



  User({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
    this.answerPrice1,
    this.answerPrice2,
    this.answerPrice3,
    this.answerDuration,
    this.bio,
    this.isInfCert,
    this.maxQuestionCharcount,
    this.rating,
    this.category,
    this.reviews,
    this.infWorth,
    this.infSent,
    this.infReceived,
    this.isInfluencer,
    this.hashtags
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["status"] = user.status;
    data["state"] = user.state;
    data["profilePhoto"] = user.profilePhoto;
    data["answerPrice1"] = user.answerPrice1;
    data["answerPrice2"] = user.answerPrice2;
    data["answerPrice3"] = user.answerPrice3;
    data["answerDuration"] = user.answerDuration;
    data["bio"] = user.bio;
    data["isInfCert"] = user.isInfCert;
    data["maxQuestionCharcount"] = user.maxQuestionCharcount;
    data["rating"] = user.rating;
    data["category"] = user.category;
    data["reviews"] = user.reviews;
    data["infWorth"] = user.infWorth;
    data["infSent"] = user.infSent;
    data["infReceived"] = user.infReceived;
    data["isInfluencer"] = user.isInfluencer;
    data["hashtags"] = user.hashtags;
    
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
    this.profilePhoto = mapData['profilePhoto'];
    this.answerPrice1 = mapData['answerPrice1'];
    this.answerPrice2 = mapData['answerPrice2'];
    this.answerPrice3 = mapData['answerPrice3'];
    this.answerDuration = mapData['answerDuration'];
    this.bio = mapData['bio'];
    this.isInfCert = mapData['isInfCert'];
    this.maxQuestionCharcount = mapData['maxQuestionCharcount'];
    this.rating = mapData['rating'];
    this.category = mapData['category'];
    this.reviews = mapData['reviews'];
    this.infWorth = mapData['infWorth'];
    this.infSent = mapData['infSent'];
    this.infReceived = mapData['infReceived'];
    this.isInfluencer = mapData['isInfluencer'];
    this.hashtags = mapData['hashtags'];
  }
}