import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/models/question.dart';

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


  List<String> get answers => ["전혀 아님","조금", "대부분","완전히"];

  List<String> get frequenze => ["매일", "주간", "월간", "연간"];

  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "William Booth의 자기부인 질문",
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
              "나는 내가 실제로 있는 것보다 나은 인상을 의도적 또는 무의식적으로 만들어 내고 있나요? 다시 말해서 나는 위선자인가요?"),
          Question(
              text:
              "내 모든 행위와 말은 정직한가요, 아니면 과장하는가요?"),
          Question(
              text:
              "내게 기밀로 전해진 것을 다른 사람에게 신뢰할 수 있게 전달하나요?"),
          Question(text: "내게 신뢰할 수 있나요?"),
          Question(text: "나는 드레스, 친구, 일 또는 습관에 노예입니까?"),
          Question(
              text: "나는 자의식이 있거나 자기 불쌍하게 여기거나 자기 정당화를 하는가?"),
          Question(text: "오늘 성경이 나 안에 살았나요?"),
          Question(text: "내가 매일 성경에게 말할 시간을 드리나요?"),
          Question(text: "나는 기도를 즐기고 있나요?"),
          Question(text: "내 신앙에 대해 다른 사람에게 언제 마지막으로 말했나요?"),
          Question(text: "내가 지출하는 돈에 대해 기도하나요?"),
          Question(text: "나는 제시간에 자러 가고 일어납니까?"),
          Question(text: "나는 하나님께 어떤 부분에서든 순종하지 않나요?"),
          Question(
              text:
              "내 양심이 불편한 상태에서 무언가를 강제로 하겠다고 요구하나요?"),
          Question(text: "내 삶의 어떤 부분에서 패배당한 적이 있나요?"),
          Question(
              text:
              "나는 시기, 부정, 비판, 불쾌, 투기 또는 불신을 느끼고 있나요?"),
          Question(text: "여가 시간을 어떻게 보내고 있나요?"),
          Question(text: "나는 자부심이 있나요?"),
          Question(
              text:
              "내가 다른 사람들과 특히 대중세례자를 멸시한 바리새인처럼 다른 사람들처럼 되지 않아 감사하나요?"),
          Question(
              text:
              "내가 두려워하거나 싫어하거나 거부하거나 비난하거나 원망하거나 무시하는 사람이 있나요? 있다면 그에 대해 어떻게 대처하고 있나요?"),
          Question(text: "나는 끊임없이 불평하거나 불평하는가?"),
          Question(text: "나에게 그리스도는 실재인가요?")
        ],
      )
    };
    return _questionMap;
  }
}
