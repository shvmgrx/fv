import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:fv/enum/user_state.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static String getUsername(String name) {
    int rand = Random().nextInt(999);
    return "$name$rand";
  }

  static String getInitials(String email) {
    List<String> nameSplit = email.split(" ");
    String firstNameInitial = nameSplit[0][0];
    return firstNameInitial;
  }

  static Future<File> pickImage({@required ImageSource source}) async {
    File selectedImage = await ImagePicker.pickImage(source: source);
    //return await compressImage(selectedImage);
    return selectedImage;
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
