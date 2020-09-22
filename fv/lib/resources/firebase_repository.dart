import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fv/models/message.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/txtOrder.dart';
import 'package:fv/models/user.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:fv/resources/firebase_methods.dart';
import 'package:meta/meta.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseMethods.signIn();

  Future<User> getUserDetails() => _firebaseMethods.getUserDetails();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(FirebaseUser user) =>
      _firebaseMethods.addDataToDb(user);

  Future<void> fetchLoggedUser(FirebaseUser user) =>
      _firebaseMethods.fetchLoggedUser(user);

  Future<void> updateProfiletoDb(
          FirebaseUser user,
          String name,
          String email,
          String username,
          String status,
          int state,
          String profilePhoto,
          int answerPrice1,
          int answerPrice2,
          int answerPrice3,
          int answerDuration,
          String bio,
          bool isInfCert,
          int maxQuestionCharcount,
          int rating,
          String category,
          int reviews,
          int infWorth,
          int infSent,
          int infReceived,
          bool isInfluencer,
          String hashtags,
          Map timeSlots) =>
      _firebaseMethods.updateProfiletoDb(
          user,
          name,
          email,
          username,
          status,
          state,
          profilePhoto,
          answerPrice1,
          answerPrice2,
          answerPrice3,
          answerDuration,
          bio,
          isInfCert,
          maxQuestionCharcount,
          rating,
          category,
          reviews,
          infWorth,
          infSent,
          infReceived,
          isInfluencer,
          hashtags,
          timeSlots);

  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<User>> fetchAllUsers(FirebaseUser user) =>
      _firebaseMethods.fetchAllUsers(user);

  Future<List<Order>> fetchBuyerOrders(String loggedUserId) =>
      _firebaseMethods.fetchBuyerOrders(loggedUserId);

  Future<List<TxtOrder>> fetchBuyerTxtOrders(String loggedUserId) =>
      _firebaseMethods.fetchBuyerTxtOrders(loggedUserId);

  Future<List<Order>> fetchSellerOrders(String loggedUserId) =>
      _firebaseMethods.fetchSellerOrders(loggedUserId);

  Future<List<TxtOrder>> fetchSellerTxtOrders(String loggedUserId) =>
      _firebaseMethods.fetchSellerTxtOrders(loggedUserId);

  Future<List<String>> fetchFvCodes() => _firebaseMethods.fetchFvCodes();

  Future<List<User>> fetchAllInfluencers(FirebaseUser user) =>
      _firebaseMethods.fetchAllInfluencers(user);
  Future<List<User>> fetchFeaturedInfluencers(FirebaseUser user) =>
      _firebaseMethods.fetchFeaturedInfluencers(user);
  Future<List<User>> fetchTrendingInfluencers(FirebaseUser user) =>
      _firebaseMethods.fetchTrendingInfluencers(user);
  Future<List<User>> fetchNewInfluencers(FirebaseUser user) =>
      _firebaseMethods.fetchNewInfluencers(user);
  Future<List<User>> fetchMostActiveInfluencers(FirebaseUser user) =>
      _firebaseMethods.fetchMostActiveInfluencers(user);

  Future<void> addMessageToDb(Message message, User sender, User receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);

  Future<String> uploadImageToStorage(File imageFile) =>
      _firebaseMethods.uploadImageToStorage(imageFile);

  // void showLoading(String receiverId, String senderId) =>
  //     _firebaseMethods.showLoading(receiverId, senderId);

  // void hideLoading(String receiverId, String senderId) =>
  //     _firebaseMethods.hideLoading(receiverId, senderId);

  void uploadImageMsgToDb(String url, String receiverId, String senderId) =>
      _firebaseMethods.setImageMsg(url, receiverId, senderId);

  void uploadImage(
          {@required File image,
          @required String receiverId,
          @required String senderId,
          @required ImageUploadProvider imageUploadProvider}) =>
      _firebaseMethods.uploadImage(
          image, receiverId, senderId, imageUploadProvider);

  void uploadVideo(
          {@required File video,
          @required String receiverId,
          @required String senderId,
          @required ImageUploadProvider imageUploadProvider}) =>
      _firebaseMethods.uploadVideo(
          video, receiverId, senderId, imageUploadProvider);

  void changeProfilePhoto(
          {@required File image,
          @required ImageUploadProvider imageUploadProvider,
          @required FirebaseUser currentUser}) =>
      _firebaseMethods.changeProfilePhoto(
          image, imageUploadProvider, currentUser);
}
