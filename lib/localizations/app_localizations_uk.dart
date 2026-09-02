import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

/// Переклади для української (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override String get greetings => 'Ласкаво просимо до інструменту самоперевірки';
  @override String get start => 'Почати';
  @override String get results => 'Результати';
  @override String get settings => 'Налаштування';
  @override String get examinTitle => 'Самоперевірка';
  @override String get noteHint => 'Додати замітки...';
  @override String get generalNoteLabel => 'Загальна нотатка';
  @override String get generalNoteHint => "Який твій загальний духовний стан сьогодні? (необов'язково)";
  @override String get pleasAnswer => 'Будь ласка, дайте відповідь на всі запитання.';
  @override String get commit => 'Готово';
  @override String get saved => 'Дані збережено';
  @override String get chartTitle => 'Графік розвитку';
  @override String get noHistory => 'Даних не знайдено. Будь ласка, заповніть запитання.';
  @override String get warningTitle => 'Попередження';
  @override String warningDel(String autor, Object author) => 'Весь прогрес для $autor буде видалено. Продовжити?';
  @override String get settingsTitle => 'Налаштування';
  @override String get chooseQuestionSet => 'Вибрати набір запитань';
  @override String get delete => 'Видалити дані';
  @override String get notification => 'Нагадати мені';
  @override String get notificationFrequency => 'Частота';
  @override String get daily => 'щодня';
  @override String get weekly => 'щотижня';
  @override String get monthly => 'щомісяця';
  @override String get datasecurityDialog => 'Конфіденційність та GDPR';
  @override String get dsgvoNo => 'Відмовлено у згоді';
  @override String get dsgvoNoInfo => 'На жаль, додаток може працювати лише за умови вашої згоди.';
  @override String get ok => 'OK';
  @override String get cancel => 'Скасувати';
  @override String get dsgvoTitle => 'Конфіденційність та згода';
  @override String get dsgvo1 => 'Щоб відстежувати ваш особистий духовний розвиток, ми зберігаємо ваші відповіді локально на вашому пристрої.';
  @override String get dsgvo2 => 'Дані не передаються в хмару. Ваша конфіденційність на 100% залишається на вашому телефоні.';
  @override String get dsgvo3 => 'Натискаючи «Погодитися», ви погоджуєтеся на локальне зберігання. Без згоди додаток не може зберігати історію даних.';
  @override String get dsgvoOK => 'Погодитися';
  @override String get dsgvoCancel => 'Відмовитися';
  @override String get dsgvoYes => 'Згода надана';
  @override String get close => 'Закрити';
  @override String get total => 'Загалом';
  @override String get compareChart => 'Порівняльний графік';
  @override String get timeChart => 'Графік часу';
  @override String get fullDateAndTime => 'EEE dd.MMM.yyyy HH:mm';
  @override String get fullDate => 'dd.MMM.yyyy';
  @override String get shortDate => 'dd.MM.yy';
  @override String get shortTime => 'HH:mm';
  @override List<String> get rating => ["Дуже добре", "Гарний шлях", "Не дуже добре", "Терміново потрібно працювати"];
  @override List<String> get answers => ["Зовсім ні", "Трохи", "Здебільшого", "Повністю"];
  @override List<String> get frequenze => ["щодня", "щотижня", "щомісяця", "щороку"];

  @override String get filterQuestions => "Фільтрувати запитання";
  @override String get today => "Сьогодні";
  @override String get noData => "Дані відсутні";
  @override String get radarError => "Радарна діаграма потребує щонайменше 3 вибраних запитань.";
  @override String get prevPeriod => "Попередній період";
  @override String get currPeriod => "Поточний період";
  @override String get all => "Усі";
  @override String get selectAll => "Вибрати всі";
  @override String get selectNone => "Скасувати вибір";
  @override List<String> get timeRangeShort => ["2Д", "1Т", "1М", "1Р", "Усі"];
  @override String get tips => "Поради та вказівки";

  @override String get settingsQuestionSetSubtitle => "Виберіть набір для редагування або видалення даних.";
  @override String get settingsExportHeader => "Експорт даних";
  @override String get settingsExportAll => "Експортувати все";
  @override String get settingsExportValues => "Значення та середнє";
  @override String get settingsExportAverage => "Тільки середнє";
  @override String get settingsSecurityHeader => "Безпека та конфіденційність";
  @override String get settingsSecurityLock => "Увімкнути блокування додатка";
  @override String get settingsReminderHeader => "Нагадування";
  @override String get settingsNoDataToExport => "Немає даних для експорту.";
  @override String get settingsLanguage => 'Мова';
  @override String get chooseLanguage => 'Вибрати мову';
  @override String get systemDefault => 'Системне значення';

  @override String get about => "Про додаток";
  @override String get aboutContent => "Цей додаток призначений для особистої рефлексії та духовного розвитку. Натхненний Вільямом Бутом та Джоном Веслі.";
  @override String get version => "Версія";
  @override String get imprint => "Вихідні дані";
  @override String get license => "Ліцензії";
  @override String get imprintContent => "Відповідальний: Маттіас Лінднер\nКонтакти:";
  @override String get githubRepository => "Репозиторій GitHub (повідомити про помилку та взяти участь)";

  @override String get onboardingSkip => "Пропустити";
  @override String get onboardingNext => "Далі";
  @override String get onboardingStart => "Почати";

  @override
  String get onboarding1Title => "Додаток для самоперевірки";

  @override
  String get onboarding1DescriptionTop =>
      "Вільям Бут і Джон Веслі регулярно приділяли час самоперевірці.\n"
          "Як я сьогодні жив своєю вірою?\n"
          "Де Божа любов могла стати видимою через мене?\n"
          "І де вона хоче змінювати мене далі?\n\n"
          "Цей додаток запрошує вас саме до такої щирої рефлексії.\n"
          "Ви можете вибирати між різними наборами запитань, фіксувати свої відповіді\n"
          "та спостерігати за своїм розвитком протягом днів, тижнів, місяців чи років –\n"
          "загалом або в окремих сферах.\n\n"
          "Як допомога в усвідомленні того, де Божа любов запрошує вас до подальших дій –\n"
          "і де зростання все ще можливе.";

  @override
  String get onboarding1DescriptionBottom =>
      "Тут ви можете вибрати між різними наборами запитань для самоперевірки. "
          "Кожен набір містить різні запитання зі своїм фокусом. "
          "Ви можете отримати огляд усіх запитань, натиснувши на іконку інформації (i).";

  @override
  String get onboarding2Title => "Рефлексія та замітки";

  @override
  String get onboarding2Step1Title => "Рефлексія";

  @override
  String get onboarding2Step1Description =>
      "Пересуньте повзунок, щоб оцінити для себе, "
          "як би ви сьогодні відповіли на відповідне запитання.\n\n"
          "Якщо ви відчуваєте, що ваша відповідь більш позитивна, посуньте повзунок у зеленому напрямку. "
          "Якщо ви відчуваєте її більш негативною, посуньте його в червоному напрямку.\n\n"
          "Над повзунком відобразиться ваша обрана оцінка у відсотках.";

  @override
  String get onboarding2Step2Title => "Замітки";

  @override
  String get onboarding2Step2Description =>
      "Натисніть на іконку нотаток (аркуш із плюсом), щоб записати думку, спостереження "
          "або молитву. Нотатка буде збережена разом із запитанням та відповідною датою.\n\n"
          "Натисніть ще раз на іконку нотаток, щоб знову закрити поле для нотаток.";

  @override
  String get onboarding3Title => "Аналіз та безпека";

  @override
  String get onboarding3Step1Title => "Діаграми";

  @override
  String get onboarding3Step1Description =>
      "Після того як ви відповіли на всі запитання, ви потрапите до перегляду діаграм "
          "за допомогою кнопки «Готово».\n\n"
          "Проведіть по діаграмі вліво або вправо, щоб перемикатися між різними видами. "
          "Під діаграмами ви можете вибрати, які запитання мають відображатися в оцінці.";

  @override
  String get onboarding3Step2Title => "Конфіденційність";

  @override
  String get onboarding3Step2Description =>
      "Ваші дані зберігаються виключно локально на вашому пристрої.\n\n"
          "За бажанням ви можете додатково захистити їх PIN-кодом пристрою або біометричними "
          "засобами захисту (наприклад, відбитком пальця або розпізнаванням обличчя).\n\n"
          "За потреби ви можете експортувати свої дані з різним ступенем деталізації як CSV-файл "
          "і, наприклад, далі аналізувати їх в Excel.";

  @override String get appLocked => "Додаток заблоковано";
  @override String get unlock => "Розблокувати";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Десять заповідей",
        description:
        "Набір запитань, розроблений Армією Спасіння в Хемніці в рамках серії проповідей про Десять заповідей.",
        questions: [
          Question(
            text: "Якою мірою я уникав ставити інші речі чи справи вище єдиного істинного Бога?",
            description: "Нехай не буде в тебе інших богів передо Мною! (2-га Мойсея 20, 1–6)",
          ),
          Question(
            text: "Як послідовно я уникав того, щоб робити чи виготовляти собі подобу Бога?",
            description: "Не роби собі кумира! (2-га Мойсея 20, 4)",
          ),
          Question(
            text: "Наскільки я уникав бездумного вживання Божого імені?",
            description: "Не призивай Імені Господа, Бога твого, надаремно! (2-га Мойсея 20, 7)",
          ),
          Question(
            text: "Чи свідомо я роблю перерву, щоб вшанувати Бога?",
            description: "А день сьомий — субота для Господа, Бога твого! (2-га Мойсея 20, 8–11)",
          ),
          Question(
            text: "Якою мірою я шаную своїх батьків і виявляю їм повагу?",
            description: "Шануй свого батька та матір свою! (2-га Мойсея 20, 12)",
          ),
          Question(
            text: "Як послідовно я уникаю завдання шкоди іншим людям думками, словами чи навіть діями?",
            description: "Не вбивай! (2-га Мойсея 20, 13)",
          ),
          Question(
            text: "Якою мірою я тримаюся подалі від перелюбу і вважаю шлюб святим?",
            description: "Не чини перелюбу! (2-га Мойсея 20, 14)",
          ),
          Question(
            text: "Наскільки надійно я не торкаюся чужої власності та практикую чесність?",
            description: "Не кради! (2-га Мойсея 20, 15)",
          ),
          Question(
            text: "Якою мірою я уникаю поширення неправди про інших людей або пліткування?",
            description: "Не свідчи неправдиво на свого ближнього! (2-га Мойсея 20, 16)",
          ),
          Question(
            text: "Наскільки я уникаю заздрості до того, що належить іншим людям, або до того, як живуть інші люди?",
            description: "Не жадай дому ближнього свого! (2-га Мойсея 20, 17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "Вільям Бут",
        description:
        "Запитання для самоперевірки, які Вільям Бут ставив собі щовечора.",
        questions: [
          Question(
            text: "Чи винен я в якомусь звичному гріху? Чи грішу я навмисно чи недбало думками, словами чи діями, добре знаючи, що чиню неправильно?",
            isPositive: true,
          ),
          Question(
            text: "Чи тримаю я свої тілесні бажання під таким контролем, що не почуваюся винним? Чи даю я волю будь-якій схильності, яка шкодить моєму освяченню, моєму зростанню в пізнанні, моєму послуху та моїй корисності?",
          ),
          Question(
            text: "Чи всі мої думки та почуття такі, що мені не довелося б соромитися, якби вони відкрилися перед Богом?",
          ),
          Question(
            text: "Чи спонукає мене мирський вплив робити чи говорити речі, які не личать послідовнику Христа?",
            isPositive: true,
          ),
          Question(
            text: "Чи спонукає мене моя вдача відчувати, робити чи говорити щось, про що я згодом усвідомлюю, що це суперечить любові, яку я завжди повинен мати до своїх ближніх?",
            isPositive: true,
          ),
          Question(
            text: "Чи роблю я все, що в моїх силах, щоб грішники були спасенні? Чи турбує мене те, що вони в небезпеці? Чи молюся я за них, чи борюся за їхнє спасіння так, ніби вони мої власні діти?",
          ),
          Question(
            text: "Чи виконую я свої обітниці, які я дав перед Богом в акті посвяти або біля лави покаяння?",
          ),
          Question(
            text: "Чи відповідає мій приклад моїм словам?",
          ),
          Question(
            text: "Чи я гордий або зарозумілий за своєю природою та поведінкою?",
            isPositive: true,
          ),
          Question(
            text: "Чи пристосовуюся я до звичаїв та моди світу, чи маю мужність пливти проти течії?",
            isPositive: true,
          ),
          Question(
            text: "Чи перебуваю я в небезпеці бути захопленим мирським бажанням бути багатим або викликати захоплення?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "Джон Веслі",
        description:
        "22 запитання Джона Веслі, які він ставив собі для самоперевірки щодня:",
        questions: [
          Question(
            text: "Чи свідомо чи несвідомо я справляю враження, що я кращий, ніж є насправді? Іншими словами: чи я лицемір?",
            isPositive: true,
          ),
          Question(
            text: "Чи чесний я у всіх своїх діях і словах, чи я перебільшую?",
            isPositive: true,
          ),
          Question(
            text: "Чи передаю я конфіденційно іншим те, що мені було сказано по секрету?",
            isPositive: true,
          ),
          Question(
            text: "Чи можна мені довіряти?",
          ),
          Question(
            text: "Чи є я рабом свого одягу, друзів, роботи чи звичок?",
          ),
          Question(
            text: "Чи я невпевнений у собі, сповнений жалості до себе чи самовпевненості?",
            isPositive: true,
          ),
          Question(
            text: "Чи живе Біблія сьогодні в мені?",
          ),
          Question(
            text: "Чи приділяю я Біблії час щодня, щоб вона промовляла до мене?",
          ),
          Question(
            text: "Чи маю я радість у молитві?",
          ),
          Question(
            text: "Коли я востаннє розмовляв з кимось про свою віру?",
          ),
          Question(
            text: "Чи молюся я про гроші, які витрачаю?",
          ),
          Question(
            text: "Чи вчасно я лягаю спати і вчасно встаю?",
          ),
          Question(
            text: "Чи неслухняний я Богу в чомусь?",
            isPositive: true,
          ),
          Question(
            text: "Чи наполягаю я на тому, щоб робити щось, що турбує мою совість?",
            isPositive: true,
          ),
          Question(
            text: "Чи зазнав я поразки в якійсь частині свого життя?",
            isPositive: true,
          ),
          Question(
            text: "Чи я заздрісний, нечистий, критичний, дратівливий, вразливий чи підозрілий?",
            isPositive: true,
          ),
          Question(
            text: "Як я проводжу свій вільний час?",
          ),
          Question(
            text: "Чи я гордий?",
            isPositive: true,
          ),
          Question(
            text: "Чи дякую я Богу за те, що я не такий, як інші люди, особливо як фарисеї, які зневажали митника?",
            isPositive: true,
          ),
          Question(
            text: "Чи є хтось, кого я боюся, хто мені не подобається, з ким я не хочу мати нічого спільного, кого я критикую, на кого тримаю образу або кого ігнорую? Якщо так, що я з цим роблю?",
            isPositive: true,
          ),
          Question(
            text: "Чи тримаю я на когось образу?",
            isPositive: true,
          ),
          Question(
            text: "Чи постійно я нарікаю або скаржуся?",
            isPositive: true,
          ),
          Question(
            text: "Чи Христос реальний для мене?",
          ),
        ],
      ),
    };
  }
}
