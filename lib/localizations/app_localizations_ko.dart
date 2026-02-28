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
  @override String get noHistory => '지난 데이터가 없습니다. 질문에 답해주세요.';
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
  @override String get datasecurityDialog => 'GDPR 대화 상자';
  @override String get dsgvoNo => '동의 거부';
  @override String get dsgvoNoInfo => '동의하지 않으면 앱을 사용할 수 없습니다.';
  @override String get ok => '확인';
  @override String get cancel => '취소';
  @override String get dsgvoTitle => '데이터 개인 정보 보호';
  @override String get dsgvo1 => '영적 발전을 추적하기 위해 답변을 저장합니다. 답변은 기기에 로컬로 저장됩니다.';
  @override String get dsgvo2 => '클라우드로 데이터가 전송되지 않습니다. 귀하의 개인 정보는 100% 휴대전화에 유지됩니다.';
  @override String get dsgvo3 => '동의를 클릭하면 로컬 저장에 동의하게 됩니다. 동의하지 않으면 기록 데이터를 저장할 수 없습니다.';
  @override String get dsgvoOK => '동의';
  @override String get dsgvoCancel => '반대';
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
  @override String get selectAll => "모두 선택";
  @override String get selectNone => "모두 해제";
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
  @override String get imprintContent => "책임자: Matthias Lindner\n연락처: ";
  @override String get githubRepository => "GitHub 저장소 (버그 보고 및 기여)";

  @override String get onboardingSkip => "건너뛰기";
  @override String get onboardingNext => "다음";
  @override String get onboardingStart => "시작";

  @override
  String get onboarding1Title => "자기성찰 앱";

  @override
  String get onboarding1DescriptionTop =>
      "윌리엄 부스와 존 웨슬리는 정기적으로 자기성찰의 시간을 가졌습니다.\n"
          "오늘 나는 나의 신앙을 어떻게 실천했는가?\n"
          "나를 통해 하나님의 사랑이 어디에서 나타났는가?\n"
          "그리고 그 사랑이 나를 어떻게 더 변화시키길 원하는가?\n\n"
          "이 앱은 당신을 이러한 정직한 성찰로 초대합니다.\n"
          "다양한 질문 세트 중에서 선택하고, 답변을 기록하며,\n"
          "일, 주, 월 또는 년 단위로 당신의 변화를 관찰할 수 있습니다.\n\n"
          "하나님의 사랑이 당신을 어디로 계속 초대하는지,\n"
          "그리고 어디에서 여전히 성장이 가능한지 파악하는 데 도움이 될 것입니다.";

  @override
  String get onboarding1DescriptionBottom =>
      "여기에서 다양한 자기성찰 질문 세트 중에서 선택할 수 있습니다. "
          "각 세트에는 고유한 중점을 둔 다양한 질문이 포함되어 있습니다. "
          "정보 아이콘(i)을 탭하면 모든 질문에 대한 개요를 볼 수 있습니다.";

  @override
  String get onboarding2Title => "성찰 및 메모";

  @override
  String get onboarding2Step1Title => "성찰";

  @override
  String get onboarding2Step1Description =>
      "슬라이더를 움직여 각 질문에 대해 오늘 어떻게 답변할지 스스로 평가해 보세요.\n\n"
          "답변이 긍정적이라고 느껴지면 슬라이더를 초록색 방향으로, "
          "부정적이라고 느껴지면 빨간색 방향으로 움직이세요.\n\n"
          "슬라이더 위에 선택한 등급이 백분율로 표시됩니다.";

  @override
  String get onboarding2Step2Title => "메모";

  @override
  String get onboarding2Step2Description =>
      "메모 아이콘(플러스가 있는 종이)을 탭하여 생각, 관찰 또는 기도를 기록하세요. "
          "메모는 질문 및 해당 날짜와 함께 저장됩니다.\n\n"
          "메모 아이콘을 다시 탭하면 메모 필드가 닫힙니다.";

  @override
  String get onboarding3Title => "분석 및 보안";

  @override
  String get onboarding3Step1Title => "차트";

  @override
  String get onboarding3Step1Description =>
      "모든 질문에 답한 후 '완료' 버튼을 통해 차트 보기로 이동할 수 있습니다.\n\n"
          "차트 영역에서 왼쪽이나 오른쪽으로 스와이프하여 다양한 보기 간에 전환할 수 있습니다. "
          "차트 아래에서 평가에 표시할 질문을 선택할 수 있습니다.";

  @override
  String get onboarding3Step2Title => "개인 정보 보호";

  @override
  String get onboarding3Step2Description =>
      "귀하의 데이터는 기기에 로컬로만 저장됩니다.\n\n"
          "선택적으로 기기 PIN 또는 생체 인식 보안(예: 지문 또는 얼굴 인식)으로 데이터를 추가로 보호할 수 있습니다.\n\n"
          "필요한 경우 데이터를 다양한 상세 수준의 CSV 파일로 내보내어 Excel 등에서 추가로 분석할 수 있습니다.";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "십계명",
        description:
        "십계명에 관한 설교 시리즈의 일환으로 캠니츠 구세군에서 개발한 질문 세트입니다.",
        questions: [
          Question(
            text: "유일하신 참 하나님 외에 다른 것들을 두지 않으려고 어느 정도 노력했습니까?",
            description: "너는 나 외에는 다른 신들을 네게 두지 말라! (출애굽기 20:1-6)",
          ),
          Question(
            text: "하나님의 형상을 만들거나 제작하지 않으려고 얼마나 일관되게 노력했습니까?",
            description: "너를 위하여 새긴 우상을 만들지 말고! (출애굽기 20:4)",
          ),
          Question(
            text: "하나님의 이름을 망령되이 일컫지 않으려고 얼마나 노력했습니까?",
            description: "너는 네 하나님 여호와의 이름을 망령되게 부르지 말라! (출애굽기 20:7)",
          ),
          Question(
            text: "하나님을 공경하기 위해 의식적으로 휴식 시간을 가집니까?",
            description: "일곱째 날은 네 하나님 여호와의 안식일인즉! (출애굽기 20:8-11)",
          ),
          Question(
            text: "부모님을 공경하고 존경심을 얼마나 나타내고 있습니까?",
            description: "네 부모를 공경하라! (출애굽기 20:12)",
          ),
          Question(
            text: "생각이나 말 또는 행동으로 타인에게 해를 끼치지 않으려고 얼마나 일관되게 노력합니까?",
            description: "살인하지 말라! (출애굽기 20:13)",
          ),
          Question(
            text: "간음을 멀리하고 결혼을 얼마나 거룩하게 유지하고 있습니까?",
            description: "간음하지 말라! (출애굽기 20:14)",
          ),
          Question(
            text: "타인의 소유에 손을 대지 않고 정직을 얼마나 성실하게 실천하고 있습니까?",
            description: "도둑질하지 말라! (출애굽기 20:15)",
          ),
          Question(
            text: "타인에 대해 거짓된 것을 퍼뜨리거나 험담하는 것을 얼마나 피하고 있습니까?",
            description: "네 이웃에 대하여 거짓 증거하지 말라! (출애굽기 20:16)",
          ),
          Question(
            text: "타인의 소유나 타인의 삶의 방식에 대해 시기하지 않으려고 얼마나 노력합니까?",
            description: "네 이웃의 집을 탐내지 말라! (출애굽기 20:17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "윌리엄 부스",
        description:
        "윌리엄 부스가 매일 저녁 자신에게 던졌던 자기성찰 질문들입니다.",
        questions: [
          Question(
            text: "알고 있는 죄를 짓고 있습니까? 내가 잘못하고 있음을 잘 알면서도 생각이나 말 또는 행동으로 고의로 혹은 부주의하게 죄를 짓고 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "나의 신체적 욕망을 잘 다스려 죄를 짓지 않고 있습니까? 나의 성결함, 지식의 성장, 순종 및 유용성을 해치는 어떤 성향에 방종하고 있지는 않습니까?",
          ),
          Question(
            text: "나의 모든 생각과 감정이 하나님 앞에 드러나도 부끄럽지 않을 만큼 깨끗합니까?",
          ),
          Question(
            text: "세상의 영향으로 인해 그리스도인에게 어울리지 않는 행동을 하거나 말을 하고 있지는 않습니까?",
            isPositive: true,
          ),
          Question(
            text: "나의 기질로 인해 나중에 생각했을 때 이웃에 대해 마땅히 가져야 할 사랑에 반하는 감정을 느끼거나 행동 또는 말을 하지는 않았습니까?",
            isPositive: true,
          ),
          Question(
            text: "죄인들이 구원받을 수 있도록 내가 할 수 있는 모든 노력을 다하고 있습니까? 그들이 위험에 처해 있다는 사실에 관심을 가집니까? 나의 자녀들처럼 그들을 위해 기도하고 구원을 위해 싸우고 있습니까?",
          ),
          Question(
            text: "헌신의 행위나 자비석(회개석) 앞에서 하나님께 드린 서약을 지키고 있습니까?",
          ),
          Question(
            text: "나의 본보기가 나의 말과 일치합니까?",
          ),
          Question(
            text: "본성이나 겉모습에 있어 교만하거나 오만하지는 않습니까?",
            isPositive: true,
          ),
          Question(
            text: "세상의 관습과 유행을 따르고 있습니까, 아니면 흐름을 거스를 용기가 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "부유해지거나 존경받고 싶은 세상적 욕망에 휩쓸릴 위험에 처해 있지는 않습니까?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "존 웨슬리",
        description:
        "존 웨슬리가 매일 자기성찰을 위해 자신에게 던졌던 22가지 질문입니다.",
        questions: [
          Question(
            text: "의식적으로든 무의식적으로든 실제보다 더 나은 사람인 척하고 있지는 않습니까? 즉, 나는 위선자입니까?",
            isPositive: true,
          ),
          Question(
            text: "모든 행동과 말에 있어 정직합니까, 아니면 과장하고 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "나에게 은밀하게 전해진 일을 타인에게 전달하고 있지는 않습니까?",
            isPositive: true,
          ),
          Question(
            text: "나는 신뢰할 만한 사람입니까?",
          ),
          Question(
            text: "나의 의복, 친구, 업무 또는 습관의 노예입니까?",
          ),
          Question(
            text: "자신감이 없거나 자기 연민에 빠져 있거나 혹은 독선적입니까?",
            isPositive: true,
          ),
          Question(
            text: "오늘 성경 말씀이 내 안에 살아 있었습니까?",
          ),
          Question(
            text: "매일 성경이 나에게 말할 시간을 주고 있습니까?",
          ),
          Question(
            text: "기도하는 것에 즐거움을 느낍니까?",
          ),
          Question(
            text: "마지막으로 다른 사람에게 나의 신앙에 대해 말한 것이 언제입니까?",
          ),
          Question(
            text: "내가 지출하는 돈에 대해 기도하고 있습니까?",
          ),
          Question(
            text: "제시간에 잠자리에 들고 제시간에 일어납니까?",
          ),
          Question(
            text: "하나님께 불순종하고 있는 부분이 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "나의 양심을 불안하게 만드는 일을 고집하고 있지는 않습니까?",
            isPositive: true,
          ),
          Question(
            text: "나의 삶의 어떤 부분에서 패배했습니까?",
            isPositive: true,
          ),
          Question(
            text: "시기심이 있거나 불결하거나 비판적이거나 화를 잘 내거나 민감하거나 혹은 의심이 많지는 않습니까?",
            isPositive: true,
          ),
          Question(
            text: "여가 시간을 어떻게 보내고 있습니까?",
          ),
          Question(
            text: "교만합니까?",
            isPositive: true,
          ),
          Question(
            text: "내가 다른 사람들, 특히 세리를 멸시했던 바리새인들과 같지 않음에 대해 하나님께 감사하고 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "내가 두려워하거나 믿지 못하거나 오해하거나 비판하거나 원망하거나 혹은 무시하는 사람이 있습니까? 있다면 그에 대해 무엇을 하고 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "누군가에게 원한을 품고 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "끊임없이 투덜대거나 불평하고 있습니까?",
            isPositive: true,
          ),
          Question(
            text: "그리스도가 나에게 실제입니까?",
          ),
        ],
      ),
    };
  }
}
