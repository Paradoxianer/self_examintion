import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';

import 'app_localizations.dart';

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get greetings => '자가평가 도구에 오신 것을 환영합니다';

  @override
  String get start => '시작';

  @override
  String get results => '결과';

  @override
  String get settings => '설정';

  @override
  String get examinTitle => '자가평가';

  @override
  String get noteHint => '메모 추가...';

  @override
  String get pleasAnswer => '모든 질문에 답해주세요.';

  @override
  String get commit => '완료';

  @override
  String get saved => '데이터가 저장되었습니다';

  @override
  String get chartTitle => '개발 차트';

  String get fullDateAndTime => 'yyyy년 MMM dd일 EEE H시 mm분';

  String get fullDate => 'yyyy년 MMM dd일';

  String get shortDate => 'yy년 MM월 dd일';

  String get shortTime => 'H시 mm분';


  @override
  String get noHistory =>
      '지난 자가평가 질문에서 찾을 수 있는 데이터가 없습니다. 다른 질문 세트를 선택하거나 질문에 답해주세요.';

  @override
  String get warningTitle => '경고';

  @override
  String warningDel(String autor, Object author) {
    return '$author에 대한 모든 저장된 진행 상황이 삭제되어 영원히 손실됩니다. 계속하시겠습니까?';
  }

  @override
  String get settingsTitle => '설정';

  @override
  String get chooseQuestionSet => '질문 세트 선택';

  @override
  String get delete => '데이터 삭제';

  @override
  String get notification => '알림 받기';

  @override
  String get notificationFrequency => '주기';

  @override
  String get daily => '매일';

  @override
  String get weekly => '매주';

  @override
  String get monthly => '매월';

  @override
  String get datasecurityDialog => 'GDPR 대화 상자';

  @override
  String get dsgvoNo => '동의 거부';

  @override
  String get dsgvoNoInfo => '동의하지 않으면 앱을 사용할 수 없습니다.';

  @override
  String get ok => '확인';

  @override
  String get cancel => '취소';

  @override
  String get dsgvoTitle => '데이터 개인 정보 보호 및 동의';

  @override
  String get dsgvo1 =>
      '개인적인 영적 발전을 추적하기 위해 우리는 당신의 답변을 저장합니다. 이러한 데이터는 익명화되어 기기에 로컬로 저장됩니다.';

  @override
  String get dsgvo2 =>
      '기기 및 앱에 액세스 권한이 있는 개인이이 데이터에 액세스 할 수 있을 수 있습니다.';

  @override
  String get dsgvo3 =>
      '\'동의\'를 클릭하면 위에서 설명한대로 데이터가 저장되는 데 동의하는 것입니다. 동의하지 않으면 데이터가 수집되지 않지만 앱도 작동하지 않습니다.';

  @override
  String get dsgvoOK => '동의';

  @override
  String get dsgvoCancel => '반대';

  @override
  String get dsgvoYes => '동의 완료';

  @override
  String get close => '닫기';

  @override
  String get total => '전체';

  @override
  String get compareChart => '비교 차트';

  @override
  String get timeChart => '시간 차트';

  List<String> get rating => ["매우 좋음", "좋은 길", "그리 좋지 않음", "개선이 필요함"];

  List<String> get answers => ["전혀 아님","조금", "대부분","완전히"];

  List<String> get frequenze => ["매일", "주간", "월간", "연간"];

  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "헤일스아미 켐니츠",
        description: "헤일스아미 켐니츠에서 만든 십계명을 기반으로 한 자가진단 질문.",
        questions: [
          Question(
              text: "내가 다른 것을 하나의 참된 하나님과 함께 두지 않도록 어느 정도로 피하고 있나요?",
              description: "너는 나의 앞에 다른 신들이 있어서는 안 된다! (출애굽기 20:2-6)"
          ),
          Question(
              text: "나는 어느 정도로 하나님의 형상을 만들거나 숭배하지 않기 위해 노력하고 있나요?",
              description: "너는 자기에게 너무나도 비슷한 무엇이든지의 형상을 만들지 말며 또 그 안에 있거나 그 위에 있는 하늘에나 땅에 있는 무엇이든지의 형상을 만들지 말지니라. (출애굽기 20:4)"
          ),
          Question(
              text: "내가 여호와 나의 하나님의 이름을 경배하지 않고 남용하는 것을 얼마나 피했나요?",
              description: "너는 여호와 너의 하나님의 이름을 거룩하게 하지 말지니 네 하나님 여호와가 무죄로 여기지 않게 하려니와 이를 남용하는 자는 무죄로 여기지 않으시리라. (출애굽기 20:7)"
          ),
          Question(
              text: "나는 매 여섯 일마다 쉬어서 하나님을 존경하기 위해 한 날 쉬고 있나요?",
              description: "그러나 일곱째 날은 너의 하나님 여호와를 공경하는 안식일이로다. (출애굽기 20:8-11)"
          ),
          Question(
              text: "나는 부모를 존경하고 존경하는 정도는 어느 정도인가요?",
              description: "네 부모를 공경하라 그리하면 네 하나님 여호와가 네게 주는 땅에서 네 날을 길게 살리라. (출애굽기 20:12)"
          ),
          Question(
              text: "내가 다른 사람들에게 생각, 말 또는 행동으로 피해를 주지 않도록 어느 정도로 노력하고 있나요?",
              description: "네가 살인하지 말라. (출애굽기 20:13)"
          ),
          Question(
              text: "나는 간통을 멀리하고 결혼을 거룩한 제도로 유지하는 데 어느 정도로 노력하고 있나요?",
              description: "네가 간통하지 말라. (출애굽기 20:14)"
          ),
          Question(
              text: "남의 것을 가져가지 않고 정직을 실천하는 데 얼마나 신뢰할 수 있나요?",
              description: "네가 도둑질하지 말라. (출애굽기 20:15)"
          ),
          Question(
              text: "나는 다른 사람에 대해 거짓말이나 중상을 퍼뜨리지 않도록 어느 정도로 피하고 있나요?",
              description: "네 이웃에 대한 거짓 증거를 네가 삼가야 할지니라. (출애굽기 20:16)"
          ),
          Question(
              text: "나는 다른 사람들이 소유한 것이나 다른 사람들이 어떻게 살고 있는 것에 대해 부러워하지 않도록 어느 정도로 피하고 있나요?",
              description: "네 이웃의 집을 탐내지 말라. 네 이웃의 아내나 종이나 여종나 소나 나귀나 그의 소유 중 어떠한 것이라도 탐내지 말라. (출애굽기 20:17)"
          ),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "William Booth 의 자기부인 질문",
        questions: [
          Question(
              text:
              "내가 습관적으로 어떤 알려진 죄에 유죄인가? 나는 나에게나 남에게 틀린 생각, 말 또는 행동을 허락하거나 연습하는가?",
              isPositive: true),
          Question(
              text:
              "나는 내 몸의 욕망에 대해 그 정점을 통제하여 나에게 어떤 비난도 없는가? 내가 나의 거룩함, 지식, 복종 또는 유용성에 해로운 품위를 허락하거나 연습하는가?"),
          Question(
              text:
              "내 생각과 감정은 나에게서 하나님 앞에 공표되어도 부끄러워하지 않을 정도인가요?"),
          Question(
              text:
              "세상의 영향은 그리스도와 다르게 행동하거나 말하게 만들어 나는가?",
              isPositive: true),
          Question(
              text:
              "내 기분이 나를 주변 사람들에게 항상 나와 주변 사람들에게 항상 나와 주변 사람들에게 항상 나와 주변 사람들에게 나와 동일하지 않다고 나타내도록 만드는가?",
              isPositive: true),
          Question(
              text:
              "나는 죄인들의 구원을 위해 내 능력의 전부를 다하고 있나요? 나는 그들의 위험에 대해 걱정하고 그들의 구원을 위해 기도하고 일하는가 마치 그들이 내 자녀인 것처럼?"),
          Question(
              text:
              "나는 나의 바치기나 회개 형식에서 하나님에게 한 서약을 이행하고 있나요?"),
          Question(
            text: "나의 본문은 내 전문과 조화를 이루는가?",
          ),
          Question(
              text:
              "내 태도나 행동에서 무의도 또는 거만함을 느끼는가?",
              isPositive: true),
          Question(
              text:
              "나는 세상의 패션과 관습에 순응하거나 나는 그것들을 경멸하는 것으로 나타내고 있나요?"),
          Question(
              text:
              "나는 부자 또는 존경받기를 원하는 세속적 욕망에 휩쓸리기 위험이 있나요?",
              isPositive: true),
          // William Booth의 다른 질문들 여기에 추가
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "존 웨즐리는 매일 다음의 22개 질문을 통해 엄격히 자기 검토했습니다.",
        questions: [
          Question(
              text:
              "나는 내가 실제로 있는 것보다 나은 인상을 의도적 또는 무의식적으로 만들어 내고 있나요? 다시 말해서 나는 위선자인가요?",
              isPositive: true),
          Question(
              text:
              "내 모든 행위와 말은 정직한가요, 아니면 과장하는가요?",
              isPositive: true),
          Question(
              text:
              "내게 기밀로 전해진 것을 다른 사람에게 신뢰할 수 있게 전달하나요?",
              isPositive: true),
          Question(text: "내게 신뢰할 수 있나요?"),
          Question(
              text: "나는 드레스, 친구, 일 또는 습관에 노예입니까?",
              isPositive: true),
          Question(
              text: "나는 자의식이 있거나 자기 불쌍하게 여기거나 자기 정당화를 하는가?",
              isPositive: true),
          Question(text: "오늘 성경이 나 안에 살았나요?"),
          Question(text: "내가 매일 성경에게 말할 시간을 드리나요?"),
          Question(text: "나는 기도를 즐기고 있나요?"),
          Question(text: "내 신앙에 대해 다른 사람에게 언제 마지막으로 말했나요?"),
          Question(text: "내가 지출하는 돈에 대해 기도하나요?"),
          Question(text: "나는 제시간에 자러 가고 일어납니까?"),
          Question(text: "나는 하나님께 어떤 부분에서든 순종하지 않나요?",
              isPositive: true),
          Question(
              text:
              "내 양심이 불편한 상태에서 무언가를 강제로 하겠다고 요구하나요?",
              isPositive: true),
          Question(text: "내 삶의 어떤 부분에서 패배당한 적이 있나요?",
              isPositive: true),
          Question(
              text:
              "나는 시기, 부정, 비판, 불쾌, 투기 또는 불신을 느끼고 있나요?",
              isPositive: true),
          Question(text: "여가 시간을 어떻게 보내고 있나요?",
              isPositive: true),
          Question(text: "나는 자부심이 있나요?",
              isPositive: true),
          Question(
              text:
              "내가 다른 사람들과 특히 대중세례자를 멸시한 바리새인처럼 다른 사람들처럼 되지 않아 감사하나요?",
              isPositive: true),
          Question(
              text:
              "내가 두려워하거나 싫어하거나 거부하거나 비난하거나 원망하거나 무시하는 사람이 있나요? 있다면 그에 대해 어떻게 대처하고 있나요?",
              isPositive: true),
          Question(text: "나는 끊임없이 불평하거나 불평하는가?",
              isPositive: true),
          Question(text: "나에게 그리스도는 실재인가요?")
        ],
      ),
    };
    return _questionMap;
  }
}
