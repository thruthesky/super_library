import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ko'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? koText = '',
  }) =>
      [enText, koText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomeScreen
  {
    'playet81': {
      'en': 'Super Library Home',
      'ko': '슈퍼 라이브러리 홈',
    },
    'aed2aepi': {
      'en':
          'Super Library supports the maximum scalabilties to build mid-sized chat and social apps with cost effiency. It is based on the Firebase realtime database.',
      'ko':
          'Super Library는 중간 규모의 채팅 및 소셜 앱을 비용 효율적으로 구축할 수 있는 최대 확장성을 지원합니다. Firebase 실시간 데이터베이스를 기반으로 합니다.',
    },
    'vtcq6g9l': {
      'en': 'Read detail document',
      'ko': '자세한 문서 읽기',
    },
    'qjocfdtt': {
      'en': 'Goto ChatroomListViewCopy',
      'ko': '채팅방으로 이동목록보기복사',
    },
    'mblo0n8j': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // MenuScreen
  {
    'too58sf2': {
      'en': 'User Menu',
      'ko': '사용자 메뉴',
    },
    'daffns7v': {
      'en': 'Login',
      'ko': '로그인',
    },
    '9qp3spg5': {
      'en': 'Email & Password Sign In',
      'ko': '이메일 및 비밀번호 로그인',
    },
    'xop9kxfm': {
      'en': 'Guest A',
      'ko': '게스트 A',
    },
    'el7bmij0': {
      'en': 'Login as Guest A',
      'ko': '게스트 A로 로그인',
    },
    'g8zkvje6': {
      'en': 'Guest B',
      'ko': '게스트 B',
    },
    '4vcujvpp': {
      'en': 'Login as Guest B',
      'ko': '게스트 B로 로그인',
    },
    '3mzmfllw': {
      'en': 'Logout',
      'ko': '로그아웃',
    },
    'up518xl9': {
      'en': 'Profile',
      'ko': '윤곽',
    },
    '6ml6d9r0': {
      'en': 'Update your information',
      'ko': '귀하의 정보를 업데이트하세요',
    },
    'pmz1118b': {
      'en': 'MenuScreen',
      'ko': '메뉴화면',
    },
    'pap2wu3m': {
      'en': 'Menu',
      'ko': '메뉴',
    },
  },
  // EmailPasswordLoginScreen
  {
    'beqiqwa7': {
      'en': 'Email',
      'ko': '이메일',
    },
    'msrz18p4': {
      'en': 'Input email address',
      'ko': '이메일 주소를 입력하세요',
    },
    '9eetr5hx': {
      'en': 'initial Value',
      'ko': '',
    },
    'khc71ww5': {
      'en': 'Password',
      'ko': '비밀번호',
    },
    'bbhcep1q': {
      'en': 'Input password',
      'ko': '비밀번호를 입력하세요',
    },
    'wy0ja86e': {
      'en': 'initial Value',
      'ko': '',
    },
    '6pg5l50b': {
      'en': 'Login',
      'ko': '로그인',
    },
    'kusy60jb': {
      'en': 'The app will create an account if you login for the first time',
      'ko': '처음 로그인 시 앱에서 계정이 생성됩니다.',
    },
    'h6wltjwh': {
      'en': 'Email Password Login',
      'ko': '이메일 비밀번호 로그인',
    },
    'fihtkfc0': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // ProfileUpdateScreen
  {
    '2rn6slcb': {
      'en': 'Display name',
      'ko': '표시 이름',
    },
    '3qk6bs06': {
      'en': 'Input display name',
      'ko': '표시 이름을 입력하세요',
    },
    'kj5nnm4r': {
      'en': 'initial Value',
      'ko': '',
    },
    'wciqm5pq': {
      'en': 'URL',
      'ko': '웹 주소',
    },
    '33slu6mn': {
      'en': 'Input photo URL',
      'ko': '사진 URL을 입력하세요',
    },
    '2lfpkd8z': {
      'en': 'initial Value',
      'ko': '',
    },
    '0pjelu9w': {
      'en': 'Profile Update',
      'ko': '프로필 업데이트',
    },
    '47tep5xz': {
      'en': 'Profile Update',
      'ko': '프로필 업데이트',
    },
    'f16cslth': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // ChatRoomScreen
  {
    'elqbrkcz': {
      'en': 'Message',
      'ko': '메시지',
    },
    '2gkqjcia': {
      'en': 'Chat',
      'ko': '채팅',
    },
  },
  // Follow
  {
    'ds10cz7h': {
      'en': 'Follow',
      'ko': '페이지 제목',
    },
    '0q5154ha': {
      'en': 'Follow',
      'ko': '따르다',
    },
  },
  // ForumScreen
  {
    '2g3fq3hl': {
      'en': 'Super Library Data Function',
      'ko': '슈퍼 라이브러리 데이터 함수',
    },
    'w4i1qf72': {
      'en':
          'Why:\nIf you are going to build a social app that has a following/follower features with thousands of users who are very active, Firestore is good. But it\'s very costy. And Super library did it with the Realtime Database.',
      'ko':
          '이유:\n매우 활동적인 수천 명의 사용자를 가진 팔로워/팔로워 기능이 있는 소셜 앱을 빌드하려는 경우 Firestore가 좋습니다. 하지만 비용이 많이 듭니다. Super 라이브러리는 Realtime Database로 이를 수행했습니다.',
    },
    'zhzaik49': {
      'en': 'Greetings',
      'ko': '인사말',
    },
    'ginmtvtu': {
      'en': 'QnA',
      'ko': '질문과답변',
    },
    'uk5i3gxt': {
      'en': 'Discussion',
      'ko': '논의',
    },
    'z0lc6ody': {
      'en': 'News',
      'ko': '소식',
    },
    '6kq2tdya': {
      'en': 'Forum',
      'ko': '법정',
    },
    'axf4dgm2': {
      'en': 'Forum',
      'ko': '법정',
    },
  },
  // PostListScreen
  {
    't9xufsdg': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // PostDetailsScreen
  {
    'sjlapi91': {
      'en': 'Post Details',
      'ko': '게시물 세부 정보',
    },
    'o3id8ezm': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // PostCreateScreen
  {
    '0yfzq57k': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // PostUpdateScreen
  {
    'c9qliu28': {
      'en': 'Update',
      'ko': '업데이트',
    },
    'vjzwpmtg': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // ChatRoomListScreen
  {
    'bnx69mqo': {
      'en': 'Chat',
      'ko': '채팅',
    },
    'hnjw5axx': {
      'en': 'Chat',
      'ko': '채팅',
    },
  },
  // PublicProfileScreen
  {
    'woh0w582': {
      'en': 'Profile',
      'ko': '윤곽',
    },
    '4alqmxb3': {
      'en': 'Chat',
      'ko': '채팅',
    },
    'c7opyvou': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // DataDetailComponent
  {
    'opth2ehx': {
      'en': 'Edit',
      'ko': '편집하다',
    },
    'xtkghy0m': {
      'en': 'Delete',
      'ko': '삭제',
    },
    'lql2cwt0': {
      'en': 'Reply',
      'ko': '회신하다',
    },
    '42vwc8nx': {
      'en': 'Follow',
      'ko': '따르다',
    },
    'qo47av0o': {
      'en': 'Unblock',
      'ko': '',
    },
    'm8vsumja': {
      'en': 'Block',
      'ko': '',
    },
    'mnz45tn4': {
      'en': 'Report',
      'ko': '보고서',
    },
  },
  // DataCreateComponent
  {
    'zg37ehn8': {
      'en': 'TITLE',
      'ko': '제목',
    },
    '2bbsspiu': {
      'en': 'Input title',
      'ko': '제목을 입력하세요',
    },
    'x07zv3za': {
      'en': 'initial Value',
      'ko': '',
    },
    '7lfic231': {
      'en': 'CONTENT',
      'ko': '콘텐츠',
    },
    '7a2c64aa': {
      'en': 'Input Content',
      'ko': '입력 내용',
    },
    '86lx6h02': {
      'en': 'initial Value',
      'ko': '',
    },
    '4drp86mr': {
      'en': 'CREATE',
      'ko': '만들다',
    },
  },
  // DataUpdateComponent
  {
    '7qn3zl1m': {
      'en': 'TITLE',
      'ko': '제목',
    },
    '4lwru0a6': {
      'en': 'Input title',
      'ko': '제목을 입력하세요',
    },
    'v0mlt6fs': {
      'en': 'CONTENT',
      'ko': '콘텐츠',
    },
    '05dtiscc': {
      'en': 'Input Content',
      'ko': '입력 내용',
    },
    'i9h7g3m9': {
      'en': 'UPDATE',
      'ko': '업데이트',
    },
  },
  // CommentCreateComponent
  {
    'k7ihw5d9': {
      'en': 'CONTENT',
      'ko': '콘텐츠',
    },
    '217hzlnb': {
      'en': 'Input content',
      'ko': '입력 내용',
    },
    'wowvbxvz': {
      'en': 'Cancel',
      'ko': '취소',
    },
    '2nbu8ziq': {
      'en': 'Create',
      'ko': '만들다',
    },
  },
  // CommentListTileComponent
  {
    'y5z9xduo': {
      'en': 'Reply',
      'ko': '회신하다',
    },
    'end7bh91': {
      'en': 'Edit',
      'ko': '편집하다',
    },
    'tdty4uy7': {
      'en': 'Delete',
      'ko': '삭제',
    },
    'knis7vih': {
      'en': 'Unblock',
      'ko': '',
    },
    'mp9ycf3g': {
      'en': 'Block',
      'ko': '',
    },
    'zq23c5au': {
      'en': 'Report',
      'ko': '보고서',
    },
  },
  // CommentUpdateComponent
  {
    '88yerjrg': {
      'en': 'CONTENT',
      'ko': '콘텐츠',
    },
    'm2zku8ce': {
      'en': 'Input content',
      'ko': '입력 내용',
    },
    'xxut28yb': {
      'en': 'Cancel',
      'ko': '취소',
    },
    '3hxkun6n': {
      'en': 'Update',
      'ko': '업데이트',
    },
  },
  // UserDisplayNameComponent
  {
    '098osuhj': {
      'en': '[Display Name]',
      'ko': '[표시 이름]',
    },
  },
  // ChatRoomNameComponent
  {
    '5k6qkt9g': {
      'en': '[ Chat Room Name ]',
      'ko': '[ 채팅방 이름 ]',
    },
  },
  // ReportBottomSheetComponent
  {
    'n2z6citt': {
      'en': 'Report',
      'ko': '보고서',
    },
    '8gy6t78m': {
      'en': 'Option 1',
      'ko': '',
    },
    '49tuisj5': {
      'en': 'Option 2',
      'ko': '',
    },
    'ncab869o': {
      'en': 'Option 3',
      'ko': '',
    },
    'c3z4wt32': {
      'en': 'Cancel',
      'ko': '취소',
    },
    'ptjvb7lb': {
      'en': 'Submit',
      'ko': '제출하다',
    },
  },
  // ChatRoomInfoComponent
  {
    '0cfglr7y': {
      'en': 'Members',
      'ko': '',
    },
  },
  // ChatOptionsComponent
  {
    'g58nc2zn': {
      'en': 'Options',
      'ko': '',
    },
  },
  // ChatRoomCreateComponent
  {
    '3kf64wt8': {
      'en': 'Create Chat Room',
      'ko': '',
    },
    'rx6kyifu': {
      'en': '',
      'ko': '',
    },
    'uedlx98r': {
      'en': 'Name',
      'ko': '',
    },
    '6vc9sn6a': {
      'en': '',
      'ko': '',
    },
    '0i1zu2m3': {
      'en': '',
      'ko': '',
    },
    'xx5am7rh': {
      'en': 'Description',
      'ko': '',
    },
    'kn8hwtj1': {
      'en': '',
      'ko': '',
    },
    'ld0vr761': {
      'en': 'Open',
      'ko': '',
    },
    '27hcc9s1': {
      'en': 'Anyone can enter',
      'ko': '',
    },
    '4r0r5jzm': {
      'en': 'Invite',
      'ko': '',
    },
    'pxf3q6ii': {
      'en': 'Anyone can invite others',
      'ko': '',
    },
    'e7etpt7s': {
      'en': 'Cancel',
      'ko': '',
    },
    'peik5acl': {
      'en': 'Create',
      'ko': '',
    },
    'd58634pk': {
      'en': 'Field is required',
      'ko': '',
    },
    'i46ee6jz': {
      'en': 'Please choose an option from the dropdown',
      'ko': '',
    },
    'u0o9ye0s': {
      'en': 'Field is required',
      'ko': '',
    },
    'nadxg2v6': {
      'en': 'Please choose an option from the dropdown',
      'ko': '',
    },
  },
  // ChatRoomEditComponent
  {
    '1p9ssitl': {
      'en': 'Edit Chat Room',
      'ko': '',
    },
    '9podhjs5': {
      'en': '',
      'ko': '',
    },
    'au3iovsr': {
      'en': 'Chat Room Icon Url',
      'ko': '',
    },
    'a5936xmu': {
      'en': '',
      'ko': '',
    },
    'pctymwy7': {
      'en': '',
      'ko': '',
    },
    'irb9yyi6': {
      'en': 'Name',
      'ko': '',
    },
    'cv0fabdp': {
      'en': '',
      'ko': '',
    },
    '7xs6bxvb': {
      'en': 'Description',
      'ko': '',
    },
    'ycg4c91y': {
      'en': 'Open',
      'ko': '',
    },
    '4wqovkox': {
      'en': 'Anyone can enter',
      'ko': '',
    },
    'jox7rmng': {
      'en': 'Invite',
      'ko': '',
    },
    'ltkzj57e': {
      'en': 'Anyone can invite others',
      'ko': '',
    },
    'ou3lmakv': {
      'en': 'Cancel',
      'ko': '',
    },
    'hy3wagbp': {
      'en': 'Update',
      'ko': '',
    },
    'tsv7b0ee': {
      'en': 'Field is required',
      'ko': '',
    },
    '3kywan4y': {
      'en': 'Please choose an option from the dropdown',
      'ko': '',
    },
    'v7lydicb': {
      'en': 'Field is required',
      'ko': '',
    },
    '9vluduny': {
      'en': 'Please choose an option from the dropdown',
      'ko': '',
    },
  },
  // ChatRoomInviteComponent
  {
    'tjo4sy0r': {
      'en': 'Invite Users',
      'ko': '',
    },
    'ic862ajs': {
      'en': 'Input name of the user',
      'ko': '',
    },
    'drjme0xm': {
      'en': 'Search',
      'ko': '',
    },
  },
  // Miscellaneous
  {
    'ubgccrii': {
      'en': 'Label Text',
      'ko': '라벨 텍스트',
    },
    'xyfq5azl': {
      'en': 'TextField',
      'ko': '텍스트필드',
    },
    'k3oi3tph': {
      'en': 'initial Value',
      'ko': '초기값',
    },
    'y6x3kwuj': {
      'en': 'Button',
      'ko': '단추',
    },
    'erebvy0l': {
      'en': 'Button',
      'ko': '단추',
    },
    'q5ueauoo': {
      'en': 'Button',
      'ko': '단추',
    },
    'ibz13zd5': {
      'en': 'TextField',
      'ko': '',
    },
    'op8004f1': {
      'en': '',
      'ko': '',
    },
    'b3n3hv46': {
      'en': '',
      'ko': '',
    },
    'swxxs8r4': {
      'en': '',
      'ko': '',
    },
    '8laar1g4': {
      'en': '',
      'ko': '',
    },
    'vq4jdu4l': {
      'en': '',
      'ko': '',
    },
    'rnbjuyh8': {
      'en': '',
      'ko': '',
    },
    'vxfdf8yr': {
      'en': '',
      'ko': '',
    },
    'qxjzf8mk': {
      'en': '',
      'ko': '',
    },
    'xgo41kux': {
      'en': '',
      'ko': '',
    },
    'pmlm1jpb': {
      'en': '',
      'ko': '',
    },
    'w2u81yog': {
      'en': '',
      'ko': '',
    },
    'qor9juzy': {
      'en': '',
      'ko': '',
    },
    '4fwsr0j4': {
      'en': '',
      'ko': '',
    },
    '9b0uf8vk': {
      'en': '',
      'ko': '',
    },
    '5elp0mc8': {
      'en': '',
      'ko': '',
    },
    '9g970fe5': {
      'en': '',
      'ko': '',
    },
    'l3r4akp9': {
      'en': '',
      'ko': '',
    },
    'dze02vgf': {
      'en': '',
      'ko': '',
    },
    '1xf4bbb5': {
      'en': '',
      'ko': '',
    },
    'feaach5v': {
      'en': '',
      'ko': '',
    },
    '4vcltgtk': {
      'en': '',
      'ko': '',
    },
    '5rzd8ndb': {
      'en': '',
      'ko': '',
    },
    'ja3apvym': {
      'en': '',
      'ko': '',
    },
    '6djfzuxg': {
      'en': '',
      'ko': '',
    },
    'iqqzeewo': {
      'en': '',
      'ko': '',
    },
  },
].reduce((a, b) => a..addAll(b));
