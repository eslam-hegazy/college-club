import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/home_screen.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

import 'package:video2/constants.dart';
import 'package:video2/presentation/screens/login_screen.dart';

import '../../../style/colors.dart';
import '../../../widgets/default_toast.dart';

class LiveStream extends StatelessWidget {
  const LiveStream({
    Key? key,
    required this.userName,
    required this.conferenceID,
    required this.mic,
    required this.vid,
  }) : super(key: key);
  final String userName;
  final String conferenceID;
  final bool mic;
  final bool vid;
  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid().v1();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Expanded(
                  child: ZegoUIKitPrebuiltVideoConference(
                    appID: Constants.appIdConference,
                    appSign: Constants.appSignConference,
                    userID: uuid,
                    userName: userName,
                    conferenceID: conferenceID,
                    config: ZegoUIKitPrebuiltVideoConferenceConfig(
                      audioVideoViewConfig: ZegoPrebuiltAudioVideoViewConfig(
                        showAvatarInAudioMode: true,
                        showCameraStateOnView: true,
                        showUserNameOnView: true,
                        showSoundWavesInAudioMode: true,
                        showMicrophoneStateOnView: true,
                      ),
                      turnOnCameraWhenJoining: vid,
                      turnOnMicrophoneWhenJoining: mic,
                      useSpeakerWhenJoining: true,
                      bottomMenuBarConfig: ZegoBottomMenuBarConfig(),
                      onLeave: () {
                        navigateWithReplace(context, const HomeScreen());
                      },
                      leaveConfirmDialogInfo: ZegoLeaveConfirmDialogInfo(
                        title: "Leave the conference",
                        message: "Are Your sure to leave the conference ?",
                        cancelButtonName: "Cancel",
                        confirmButtonName: "Confirm",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                FlutterClipboard.copy(conferenceID).then((value) {
                  defaultToast(text: "Copy Link !");
                });
              },
              child: Icon(
                Icons.copy,
                color: AppColor.kWhite.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
