import 'dart:io';
import 'dart:math';
//import 'package:image/image.dart' as Im;
import 'package:fv/constants/conStrings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fv/enum/user_state.dart';
import 'package:meta/meta.dart';
//import 'package:path_provider/path_provider.dart';

class Utils {
  static String getUsername(String name) {
    int rand = Random().nextInt(999);
    return "$name$rand";
  }

  static String generateRandomOrderId() {
    int r1 = Random().nextInt(9999);
    var r2 = DateTime.now().hashCode.toRadixString(36);
    int r3 = Random().nextInt(9999);
    var r4 = DateTime.now().hashCode.toRadixString(20);
    int r5 = Random().nextInt(9999);
    var r6 = DateTime.now().hashCode.toRadixString(36);

    return "$r1$r2$r3$r4$r5$r6";
  }

  static String getDuration(int duration) {
    String timeDuration = ConStrings.timeDuration;

    if (duration == 1) {
      timeDuration = ConStrings.timeDuration1;
    }
    if (duration == 2) {
      timeDuration = ConStrings.timeDuration2;
    }
    return timeDuration;
  }

  String randomString() {
    var rand = new Random();
    var codeUnits = new List.generate(9, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  static String getInitials(String email) {
    List<String> nameSplit = email.split(" ");
    String firstNameInitial = nameSplit[0][0];
    return firstNameInitial;
  }

  static Future<File> pickImage({@required ImageSource source}) async {
    //   print("1a");
    File _image;
    final iPicker = ImagePicker();
    //    print("21a");

    final pickedFile = await iPicker.getImage(
        source: ImageSource.gallery, maxWidth: 700.0, maxHeight: 700.0);
    // print("31a");

    _image = File(pickedFile.path);
    //print("4a");
    return _image;
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;

      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
    switch (number) {
      case 0:
        return UserState.Offline;

      case 1:
        return UserState.Online;

      default:
        return UserState.Waiting;
    }
  }
  //   static Future<File> pickVideo({@required ImageSource source}) async {
  //   File selectedImage = await ImagePicker.pickImage(source: source);
  //   //return await compressImage(selectedImage);
  //   return selectedImage;
  // }

  // static Future<File> compressImage(File imageToCompress) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir.path;
  //   int rand = Random().nextInt(99999999999999);

  //   Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
  //   Im.copyResize(image, width: 500, height: 500);

  //   return new File('$path/img_$rand.jpg')
  //     ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  // }
}
