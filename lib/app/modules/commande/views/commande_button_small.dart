import 'dart:async';
import 'dart:math';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:alfred_taxi_driver/app/utils/small_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommandeDetailBottomButtons extends StatefulWidget {
  const CommandeDetailBottomButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<CommandeDetailBottomButtons> createState() =>
      _CommandeDetailBottomButtonsState();
}

class _CommandeDetailBottomButtonsState
    extends State<CommandeDetailBottomButtons> {
  bool _cancelSpeech = false;
  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  static const audioWordsListOUI = <String>[
    "oui",
    "ouioui",
    "oui oui",
    "oui-oui",
    "ouii",
  ];
  static const audioWordsListNON = <String>[
    "non",
    "nonnon",
    "non non",
    "non-non",
    "noon",
  ];
  static const audioWordsListYES = <String>[
    "yes",
    "yesyes",
    "yes yes",
    "yes-yes",
    "yees",
  ];
  static const audioWordsListNO = <String>[
    "no",
    "nono",
    "no no",
    "no-no",
    "noo",
  ];
  static const audioWordsListREFUSER = <String>[
    "refus",
    "refuse",
    "refuser",
    "refuserrefuser",
    "refuser refuser",
    "refuser-refuser",
  ];
  static const audioWordsListACCETER = <String>[
    "accept",
    "accepte",
    "accepter",
    "accepteraccepter",
    "accepter accepter",
    "accepter-accepter",
  ];

  @override
  void initState() {
    initSpeechState();

    super.initState();
  }

  @override
  void dispose() {
    speech.stop();
    super.dispose();
  }

  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeechOrig = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
      );

      if (_hasSpeech) {
        _localeNames = await speech.locales();
        for (var element in _localeNames) {
          print(element.name);
        }

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeechOrig;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
    recordSound();
  }

  recordSound() {
    Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      if (_hasSpeech ||
          speech.isListening && ctlcommande.isPosting.value == false) {
        startListening();
      }
      if (_cancelSpeech) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: LightColor.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Accepter la commande ?",
                    style: TextStyle(fontSize: 22)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: const Text("Refuser"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        onPressed: () async {
                          var res = await showModalActionSheet<String>(
                            context: context,
                            title: 'Refuser commande',
                            message:
                                "En continuant, vous enlevez cette comande de votre liste de commande actuelle ?",
                            actions: [
                              const SheetAction(
                                icon: Icons.check,
                                label: "OUI",
                                key: KEYWORD.YES,
                                isDefaultAction: true,
                              ),
                              const SheetAction(
                                icon: Icons.close,
                                label: 'NON',
                                key: KEYWORD.NO,
                              ),
                            ],
                          );
                          print(res);
                          if (res.toString().toLowerCase() ==
                              KEYWORD.YES.toString().toLowerCase()) {
                            ctlcommande.changeStatus(CMDSTATUS.COMMAND_EMPTY);
                            ctlcommande.refuserCourse();
                            Get.offAllNamed(Routes.HOME);
                          }
                        }),
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: .26,
                              spreadRadius: level * 1.5,
                              color: Colors.red.withOpacity(.5))
                        ],
                        color: Colors.amber,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(50)),
                      ),
                      child: InkWell(
                        child: const Icon(
                          CupertinoIcons.mic,
                        ),
                        onTap: () {},
                      ),
                    ),
                    ElevatedButton(
                      child: const Text("Accepter"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () async {
                        var res = await showModalActionSheet<String>(
                          context: context,
                          title: 'Accepter commande',
                          message:
                              "En continuant, vous accepter de conduire ce client depuis le lieu de rendez-vous jusqu'à destination",
                          actions: [
                            const SheetAction(
                              icon: Icons.info,
                              label: "J'accepte !",
                              key: KEYWORD.ACCEPTER,
                              isDefaultAction: true,
                            ),
                            const SheetAction(
                              icon: Icons.reply_all_rounded,
                              label: 'Revenir en arrière',
                              key: KEYWORD.REVENIR,
                            ),
                          ],
                        );
                        print(res);
                        if (res != null) {
                          ctlcommande.managerCourse(res.toLowerCase(),
                              context: context);
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  //////////////////////////////AUDIO
// This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    if (!_cancelSpeech)
      speech.listen(
          onResult: resultListener,
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 5),
          partialResults: true,
          localeId: _currentLocaleId,
          onSoundLevelChange: soundLevelListener,
          cancelOnError: true,
          listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
    print("resultat: ${result.recognizedWords.toLowerCase()}");
    for (var word in audioWordsListOUI) {
      if (result.recognizedWords.toLowerCase().contains(word) &&
          ctlcommande.isPosting.value == false) {
        ctlcommande.accepterCourse();
        print(" resultatoui $word");
        _cancelSpeech = true;
        speech.stop();
      }
    }
    for (var word in audioWordsListYES) {
      if (result.recognizedWords.toLowerCase().contains(word) &&
          ctlcommande.isPosting.value == false) {
        ctlcommande.accepterCourse();
        print(" resultatyes $word");
        _cancelSpeech = true;
        speech.stop();
      }
    }
    for (var word in audioWordsListACCETER) {
      if (result.recognizedWords.toLowerCase().contains(word) &&
          ctlcommande.isPosting.value == false) {
        ctlcommande.accepterCourse();
        print(" resultatyes $word");
        _cancelSpeech = true;
        speech.stop();
      }
    }

    for (var word in audioWordsListNON) {
      if (result.recognizedWords.toLowerCase().contains(word) &&
          ctlcommande.isPosting.value == false) {
        ctlcommande.refuserCourse();
        print(" resultatnon $word");
        _cancelSpeech = true;
        speech.stop();
        Get.offAllNamed(Routes.HOME);
      }
    }

    for (var word in audioWordsListNO) {
      if (result.recognizedWords.toLowerCase().contains(word) &&
          ctlcommande.isPosting.value == false) {
        ctlcommande.refuserCourse();
        print(" resultatno $word");
        _cancelSpeech = true;
        speech.stop();
        Get.offAllNamed(Routes.HOME);
      }
    }
    for (var word in audioWordsListREFUSER) {
      if (result.recognizedWords.toLowerCase().contains(word) &&
          ctlcommande.isPosting.value == false) {
        ctlcommande.refuserCourse();
        print(" resultatrefuser $word");
        _cancelSpeech = true;
        speech.stop();
        Get.offAllNamed(Routes.HOME);
      }
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }
}
