import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override String get greetings => '자가평가 도구에 오신 것을 환영합니다';
  @override String get start => '시작';
  @override String get results => '결과';
  @override String get settings => '설정';
  @override String get examinTitle => '자가평가';
  @override String get noteHint => '메모 추가...';
  @override String get pleasAnswer => '모든 질문에 답해주세요.';
  @override String get commit => '완료';
  @override String get saved => '데이터가 저장되었습니다';
  @override String get chartTitle => '개발 차트';
  @override String get noHistory => '데이터가 없습니다. 질문에 답해주세요.';
  @override String get warningTitle => '경고';
  @override String warningDel(String autor, Object author) => '$author의 모든 진행 상황이 삭제됩니다. 계속하시겠습니까?';
  @override String get settingsTitle => '설정';
  @override String get chooseQuestionSet => '질문 세트 선택';
  @override String get delete => '데이터 삭제';
  @override String get notification => '알림 받기';
  @override String get notificationFrequency => '주기';
  @override String get daily => '매일';
  @override String get weekly => '매주';
  @override String get monthly => '매월';
  @override String get datasecurityDialog => '데이터 개인 정보 보호';
  @override String get dsgvoNo => '동의 거부';
  @override String get dsgvoNoInfo => '동의하지 않으면 앱을 사용할 수 없습니다.';
  @override String get ok => '확인';
  @override String get cancel => '취소';
  @override String get dsgvoTitle => '데이터 개인 정보 보호 및 동의';
  @override String get dsgvo1 => '영적 발전을 추적하기 위해 답변을 로컬에 저장합니다.';
  @override String get dsgvo2 => '클라우드로 전송되지 않습니다. 프라이버시는 기기에 남습니다.';
  @override String get dsgvo3 => '동의하면 로컬 저장에 동의하는 것입니다.';
  @override String get dsgvoOK => '동의';
  @override String get dsgvoCancel => '거부';
  @override String get dsgvoYes => '동의 완료';
  @override String get close => '닫기';
  @override String get total => '전체';
  @override String get compareChart => '비교';
  @override String get timeChart => '시간 흐름';
  @override String get fullDateAndTime => 'yyyy년 MMM dd일 EEE H시 mm분';
  @override String get fullDate => 'yyyy년 MMM dd일';
  @override String get shortDate => 'yy년 MM월 dd일';
  @override String get shortTime => 'H시 mm분';
  @override List<String> get rating => ["매우 좋음", "좋은 길", "그리 좋지 않음", "개선 필요"];
  @override List<String> get answers => ["전혀 아님", "조금", "대부분", "완전히"];
  @override List<String> get frequenze => ["매일", "매주", "매월", "매년"];

  @override String get filterQuestions => "질문 필터링";
  @override String get today => "오늘";
  @override String get noData => "데이터 없음";
  @override String get radarError => "레이더 차트를 표시하려면 최소 3개의 질문을 선택해야 합니다.";
  @override String get prevPeriod => "이전 기간";
  @override String get currPeriod => "현재 기간";
  @override String get all => "전체";
  @override List<String> get timeRangeShort => ["2일", "1주", "1월", "1년", "전체"];
  @override String get tips => "팁 및 정보";

  @override String get settingsQuestionSetSubtitle => "데이터를 편집하거나 삭제할 세트를 선택하십시오.";
  @override String get settingsExportHeader => "데이터 내보내기";
  @override String get settingsExportAll => "모두 내보내기";
  @override String get settingsExportValues => "값 및 평균";
  @override String get settingsExportAverage => "평균만";
  @override String get settingsSecurityHeader => "보안 및 개인 정보 보호";
  @override String get settingsSecurityLock => "앱 잠금 활성화";
  @override String get settingsReminderHeader => "알림";
  @override String get settingsNoDataToExport => "내보낼 데이터가 없습니다.";

  @override String get about => "앱 정보";
  @override String get aboutContent => "이 앱은 개인적인 성찰과 영적 성장을 위한 것입니다. William Booth와 John Wesley의 영감을 받았습니다.";
  @override String get version => "버전";
  @override String get imprint => "법적 고지";
  @override String get license => "라이선스";
  @override String get imprintContent => "책임자: Matthias Lindner\n연락처: info@example.com";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "켐니츠 구세군",
        description: "십계명 기반 질문.",
        questions: [
          Question(text: "하나님 외에 다른 것을 두지 않습니까?"),
          Question(text: "하나님의 형상을 만들지 않습니까?"),
          Question(text: "하나님의 이름을 함부로 부르지 않습니까?"),
          Question(text: "안식일을 거룩히 지킵니까?"),
          Question(text: "부모를 공경합니까?"),
          Question(text: "이웃에게 해를 끼치지 않습니까?"),
          Question(text: "간음하지 않습니까?"),
          Question(text: "정직하며 도둑질하지 않습니까?"),
          Question(text: "거짓 증언을 하지 않습니까?"),
          Question(text: "이웃의 것을 탐내지 않습니까?"),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "윌리엄 부스",
        description: "자기부인 질문.",
        questions: [
          Question(text: "알고 있는 죄를 짓고 있습니까?", isPositive: true),
          Question(text: "육체의 욕망을 다스리고 있습니까?"),
          Question(text: "생각이 하나님 앞에 깨끗합니까?"),
          Question(text: "세상의 영향을 받고 있습니까?", isPositive: true),
          Question(text: "사랑으로 행동하고 있습니까?", isPositive: true),
          Question(text: "죄인 구원을 위해 최선을 다합니까?"),
          Question(text: "하나님께 한 서약을 지킵니까?"),
          Question(text: "행동이 말과 일치합니까?"),
          Question(text: "교만함을 느끼고 있습니까?", isPositive: true),
          Question(text: "세상의 흐름을 거스르고 있습니까?"),
          Question(text: "세속적 욕망이 있습니까?", isPositive: true),
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "웨슬리의 22가지 질문:",
        questions: [
          Question(text: "위선자입니까?", isPositive: true),
          Question(text: "정직합니까?", isPositive: true),
          Question(text: "비밀을 지킵니까?", isPositive: true),
          Question(text: "신뢰할 수 있습니까?"),
          Question(text: "습관의 노예입니까?", isPositive: true),
          Question(text: "자기 연민에 빠져 있습니까?", isPositive: true),
          Question(text: "말씀이 내 안에 살고 있습니까?"),
          Question(text: "기도를 즐깁니까?"),
          Question(text: "신앙을 전하고 있습니까?"),
          Question(text: "제시간에 자고 일어납니까?"),
          Question(text: "하나님께 불순종합니까?", isPositive: true),
          Question(text: "교만합니까?", isPositive: true),
          Question(text: "그리스도가 실제입니까?"),
        ],
      ),
    };
  }
}
