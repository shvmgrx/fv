import 'package:fv/models/user.dart';

class Influencer {
  String influencerName;
  int influencerRating;
  String influencerPic;
  String influencerUsername;
  int answerPrice1;
  int answerPrice2;



  Influencer({this.influencerName, this.influencerRating, this.influencerPic,this.influencerUsername, this.answerPrice1,this.answerPrice2});
}


List<User> influencerList;

List allInfluencers = [
  Influencer(
    influencerName: 'Cora Wong',
    influencerRating: 12,
    influencerPic: 'assets/woman1.jpg'
  ),
  Influencer(
    influencerName: 'Charlie Roy',
    influencerRating: 4,
    influencerPic: 'assets/man1.jpg'
  ),
  Influencer(
    influencerName: 'Ruth Norton',
    influencerRating: 7,
    influencerPic: 'assets/woman2.jpg'
  ),
  Influencer(
    influencerName: 'Leah Price',
    influencerRating: 5,
    influencerPic: 'assets/man2.jpg'
  )

];