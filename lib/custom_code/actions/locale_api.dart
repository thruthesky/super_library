// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/flutter_flow/internationalization.dart';

const defaultLocales = {
  'yes': {
    'en': 'Yes',
    'ko': '예',
  },
  'no': {
    'en': 'No',
    'ko': '아니요',
  },
  'ok': {
    'en': 'OK',
    'ko': '확인',
  },
  'error': {
    'en': 'Error',
    'ko': '에러',
  },
  'No chat messages yet': {
    'en': 'No chat messages yet',
    'ko': '아직 채팅 메시지가 없습니다',
  },
  'setting': {
    'en': 'Setting',
    'ko': '설정',
  },
  'display name': {
    'en': 'Display Name',
    'ko': '닉네임',
  },
  'save': {
    'en': 'Save',
    'ko': '저장',
  },
  'update': {
    'en': 'Update',
    'ko': '업데이트',
  },
  'upload from': {
    'en': 'Upload from',
    'ko': '업로드',
  },
  'Select photo from gallery': {
    'en': 'Upload from Gallery',
    'ko': '갤러리에서 업로드하기',
  },
  'Take photo from camera': {
    'en': 'Upload from Camera',
    'ko': '카메라에서 촬영하기',
  },
  'please sign in to view chat rooms': {
    'en': 'Please sign in to view chat rooms',
    'ko': '채팅방을 보려면 로그인하세요',
  },
  'New chat': {
    'en': 'New chat',
    'ko': '새로운 채팅',
  },
  'Do you want to join this chat room?': {
    'en': 'Do you want to join this chat room?',
    'ko': '이 채팅방에 참여하시겠습니까?',
  },
  'block': {
    'en': 'Block',
    'ko': '차단',
  },
  'report': {
    'en': 'Report',
    'ko': '신고',
  },
  'leave': {
    'en': 'Leave',
    'ko': '나가기',
  },
};

Future localeApi() async {
  // Add your function code here!
}

/// Text Locale Service
class LocaleService {
  static LocaleService? _instance;
  static LocaleService get instance => _instance ??= LocaleService._();
  LocaleService._();

  /// Add translations to the map of the Flutter Localization translations
  add(Map<String, Map<String, String>> translations) {
    /// make the key of the translations lowercase
    final Map<String, Map<String, String>> lowerCaseTranslations = {};
    translations.forEach((key, value) {
      lowerCaseTranslations[key.toLowerCase()] = value;
    });

    kTranslationsMap.addAll(lowerCaseTranslations);
  }

  /// Returns the translation of the key
  String tr(BuildContext context, String key) {
    String text = FFLocalizations.of(context).getText(key.toLowerCase());

    if (text.trim().isEmpty) {
      return key;
    } else {
      return text;
    }
  }
}
