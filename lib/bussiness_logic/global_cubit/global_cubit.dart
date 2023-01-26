import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:meta/meta.dart';
import 'package:video2/core/strings.dart';
import 'package:video2/data/local/cache_helper.dart';
import 'package:video2/data/model/request/request_image_model.dart';
import 'package:video2/data/model/request/request_message_model.dart';
import 'package:video2/data/model/response/response_image_model.dart';
import 'package:video2/data/model/response/response_message_model.dart';
import 'package:video2/data/remote/dio_helper.dart';
import 'package:video2/presentation/screens/taps/ai_chat/ai_chat_screen.dart';
import 'package:video2/presentation/screens/taps/conference/conference_meeting_screen.dart';
import 'package:video2/presentation/screens/taps/setting_screen.dart';

import '../../presentation/screens/taps/search/search_screen.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());
  static GlobalCubit get(context) => BlocProvider.of(context);
  List screen = const [
    ConferenceMeetingScreen(),
    SearchScreen(),
    AiChatScreen(),
    SettingsScreen(),
  ];
  List iconHome = [
    Icons.personal_video_outlined,
    Icons.search,
    Icons.wechat_outlined,
    Icons.settings_suggest_outlined,
  ];
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationSuccessState());
  }

  void login(
      {required String name, required String bio, required bool status}) {
    CacheHelper.saveDataSharedPreference(key: "name", value: name)
        .then((value) {
      CacheHelper.saveDataSharedPreference(key: "bio", value: bio);
      CacheHelper.saveDataSharedPreference(key: "status", value: status);
      emit(
        LoginSuccess(
          message: "message_login".tr(),
        ),
      );
    }).catchError((error) {
      print(error.toString());
    });
  }

  void logOut() {
    CacheHelper.removeData(key: "name").then((value) {
      CacheHelper.removeData(key: "bio");
      CacheHelper.removeData(key: "status");
      emit(SignOutSuccess(message: "message_logout".tr()));
    }).catchError((error) {
      print(error.toString());
    });
  }

  bool currentSwitchMale = false;
  void changeSwitchMale(bool value) {
    currentSwitchMale = value;
    emit(ChangeSwitchMale());
  }

  String? getUserName() {
    var userName = CacheHelper.getDataFromSharedPreference(key: "name");
    emit(GetUserNameState());
    return userName;
  }

  String? getBio() {
    var bio = CacheHelper.getDataFromSharedPreference(key: "bio");
    emit(GetBioState());
    return bio;
  }

  bool? getStatus() {
    var status = CacheHelper.getDataFromSharedPreference(key: "status");
    emit(GetStatusState());
    return status;
  }

  List<String> dropListSizes = [
    "small".tr(),
    "medium".tr(),
    "large".tr(),
  ];
  List<String> dropListValues = [
    "25x256",
    "512x512",
    "1024x1024",
  ];
  String currentDropList = "select_size".tr();
  void changeItemDropList(value) {
    currentDropList = value;
    emit(ChangeDropListState());
  }

  List<ResponseImageModel> imageData = [];
  void generateImage(
      {required String prompt, required int n, required String size}) {
    imageData = [];
    emit(LoadingGenerateImageState());
    DioHelper.postData(
            url: "images/generations",
            body: RequestImageModel(prompt: prompt, n: n, size: size).toMap())
        .then((value) {
      emit(SuccessGenerateImageState());
      value.data['data'].forEach((e) {
        imageData.add(ResponseImageModel(image: e['url']));
      });
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGenerateImageState());
    });
  }

  List<ResponseMessageModel> messagesData = [];
  Future<dynamic> generateMessage(String text) async {
    emit(LoadingGenerateMessageState());
    await DioHelper.postData(
      url: "completions",
      body: RequestMessageModel(
        model: "text-davinci-003",
        prompt: text,
        temperature: 0.6,
        max_tokens: 150,
        top_p: 1,
        frequency_penalty: 1,
        presence_penalty: 1,
      ).toJson(),
    ).then((value) {
      emit(SuccessGenerateMessageState());
      messagesData.add(ResponseMessageModel(
          message: value.data['choices'][0]["text"], type: "bot"));
    }).catchError((error) {
      print(error.toString());

      emit(ErrorGenerateMessageState());
    });
  }

  //////change microphone
  bool valMic = true;
  void changeMicrophone() {
    valMic = !valMic;
    emit(ChangeMicrophoneState());
  }

  //////change video
  bool valVid = true;
  void changeVideo() {
    valVid = !valVid;
    emit(ChangeVideoState());
  }
}
