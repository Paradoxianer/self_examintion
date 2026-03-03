import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override String get greetings => 'Добро пожаловать в инструмент самоанализа';
  @override String get start => 'Начать';
  @override String get results => 'Результаты';
  @override String get settings => 'Настройки';
  @override String get examinTitle => 'Самоанализ';
  @override String get noteHint => 'Добавить заметку...';
  @override String get pleasAnswer => 'Пожалуйста, ответьте на все вопросы.';
  @override String get commit => 'Завершить';
  @override String get saved => 'Данные сохранены';
  @override String get chartTitle => 'График развития';
  @override String get noHistory => 'Данные не найдены. Пожалуйста, ответьте на вопросы.';
  @override String get warningTitle => 'Предупреждение';
  @override String warningDel(String autor, Object author) => 'Весь прогресс для $autor будет удален. Продолжить?';
  @override String get settingsTitle => 'Настройки';
  @override String get chooseQuestionSet => 'Выберите набор вопросов';
  @override String get delete => 'Удалить данные';
  @override String get notification => 'Напомнить мне';
  @override String get notificationFrequency => 'Частота';
  @override String get daily => 'ежедневно';
  @override String get weekly => 'еженедельно';
  @override String get monthly => 'ежемесячно';
  @override String get datasecurityDialog => 'Конфиденциальность и GDPR';
  @override String get dsgvoNo => 'Согласие отклонено';
  @override String get dsgvoNoInfo => 'Приложение может работать только если вы согласны.';
  @override String get ok => 'OK';
  @override String get cancel => 'Отмена';
  @override String get dsgvoTitle => 'Конфиденциальность данных и согласие';
  @override String get dsgvo1 => 'Чтобы отслеживать ваше личное духовное развитие, мы храним ваши ответы локально на вашем устройстве.';
  @override String get dsgvo2 => 'Данные не передаются в облако. Ваша конфиденциальность на 100% остается на вашем телефоне.';
  @override String get dsgvo3 => 'Нажимая «Согласен», вы даете согласие на локальное хранение. Без него история не может быть сохранена.';
  @override String get dsgvoOK => 'Согласен';
  @override String get dsgvoCancel => 'Отклонить';
  @override String get dsgvoYes => 'Согласие дано';
  @override String get close => 'Закрыть';
  @override String get total => 'Всего';
  @override String get compareChart => 'Сравнение';
  @override String get timeChart => 'Хронология';
  @override String get fullDateAndTime => 'EEE, d MMM yyyy, HH:mm';
  @override String get fullDate => 'd MMM yyyy';
  @override String get shortDate => 'dd.MM.yy';
  @override String get shortTime => 'HH:mm';
  @override List<String> get rating => ["Отлично", "Хороший путь", "Не очень", "Нужна работа"];
  @override List<String> get answers => ["Совсем нет", "Немного", "В основном", "Полностью"];
  @override List<String> get frequenze => ["ежедневно", "еженедельно", "ежемесячно", "ежегодно"];

  @override String get filterQuestions => "Фильтр вопросов";
  @override String get today => "Сегодня";
  @override String get noData => "Нет данных";
  @override String get radarError => "Для радарной диаграммы требуется как минимум 3 выбранных вопроса.";
  @override String get prevPeriod => "Прошлый период";
  @override String get currPeriod => "Текущий период";
  @override String get all => "Все";
  @override String get selectAll => "Выбрать все";
  @override String get selectNone => "Снять выделение";
  @override List<String> get timeRangeShort => ["2Д", "1Н", "1М", "1Г", "Все"];
  @override String get tips => "Советы и информация";

  @override String get settingsQuestionSetSubtitle => "Выберите набор, чтобы редактировать или удалить данные.";
  @override String get settingsExportHeader => "Экспорт данных";
  @override String get settingsExportAll => "Экспортировать все";
  @override String get settingsExportValues => "Значения и среднее";
  @override String get settingsExportAverage => "Только среднее";
  @override String get settingsSecurityHeader => "Безопасность и приватность";
  @override String get settingsSecurityLock => "Включить блокировку приложения";
  @override String get settingsReminderHeader => "Напоминание";
  @override String get settingsNoDataToExport => "Нет данных для экспорта.";
  @override String get settingsLanguage => 'Язык';
  @override String get chooseLanguage => 'Выберите язык';

  @override String get about => "О приложении";
  @override String get aboutContent => "Это приложение предназначено для личного размышления и духовного роста. Вдохновлено Уильямом Бутом и Джоном Уэсли.";
  @override String get version => "Версия";
  @override String get imprint => "Выходные данные";
  @override String get license => "Лицензии";
  @override String get imprintContent => "Ответственный: Маттиас Линднер\nКонтакт: ";
  @override String get githubRepository => "GitHub Репозиторий (сообщить об ошибках и помочь)";

  @override String get onboardingSkip => "Пропустить";
  @override String get onboardingNext => "Далее";
  @override String get onboardingStart => "Начать";

  @override
  String get onboarding1Title => "Приложение для самоанализа";

  @override
  String get onboarding1DescriptionTop =>
      "Уильям Бут и Джон Уэсли регулярно уделяли время самоанализу.\n"
          "Как я прожил свою веру сегодня?\n"
          "Где Божья любовь могла быть видна через меня?\n"
          "И где она хочет продолжать менять меня?\n\n"
          "Это приложение приглашает вас именно к такому честному размышлению.\n"
          "Вы можете выбирать из различных наборов вопросов, записывать свои ответы\n"
          "и наблюдать за своим развитием на протяжении дней, недель, месяцев или лет –\n"
          "в целом или в отдельных областях.\n\n"
          "Как помощь в осознании того, куда Божья любовь приглашает вас продолжать действовать –\n"
          "и где рост все еще возможен.";

  @override
  String get onboarding1DescriptionBottom =>
      "Здесь вы можете выбирать между различными наборами вопросов для самоанализа. "
          "Каждый набор содержит разные вопросы со своим фокусом. "
          "Вы можете получить обзор всех вопросов, нажав на иконку информации (i).";

  @override
  String get onboarding2Title => "Размышляйте и записывайте";

  @override
  String get onboarding2Step1Title => "Размышляйте";

  @override
  String get onboarding2Step1Description =>
      "Перемещайте ползунок, чтобы оценить для себя, как бы вы ответили на соответствующий вопрос сегодня.\n\n"
          "Если вы чувствуете, что ваш ответ более позитивный, сдвиньте ползунок в сторону зеленого. "
          "Если вы чувствуете, что он более негативный, сдвиньте его в сторону красного.\n\n"
          "Ваш выбранный рейтинг в процентах будет отображаться над ползунком.";

  @override
  String get onboarding2Step2Title => "Заметки";

  @override
  String get onboarding2Step2Description =>
      "Нажмите на иконку заметки (лист с плюсом), чтобы записать мысль, наблюдение или молитву. "
          "Заметка будет сохранена вместе с вопросом и соответствующей датой.\n\n"
          "Нажмите на иконку заметки еще раз, чтобы закрыть поле заметки.";

  @override
  String get onboarding3Title => "Анализ и безопасность";

  @override
  String get onboarding3Step1Title => "Графики";

  @override
  String get onboarding3Step1Description =>
      "После того как вы ответили на все вопросы, вы можете перейти к просмотру графиков через кнопку «Завершить».\n\n"
          "Проведите пальцем влево или вправо в области графика, чтобы переключаться между различными видами. "
          "Под графиками вы можете выбрать, какие вопросы должны отображаться в оценке.";

  @override
  String get onboarding3Step2Title => "Конфиденциальность";

  @override
  String get onboarding3Step2Description =>
      "Ваши данные хранятся исключительно локально на вашем устройстве.\n\n"
          "Опционально вы можете дополнительно защитить их с помощью PIN-кода вашего устройства или биометрических "
          "данных (например, отпечатка пальца или распознавания лица).\n\n"
          "При необходимости вы можете экспортировать свои данные в виде CSV-файла с различным уровнем детализации "
          "и, например, продолжить их анализ в Excel.";

  @override String get appLocked => "Приложение заблокировано";
  @override String get unlock => "Разблокировать";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Десять заповедей",
        description:
        "Набор вопросов, разработанный Армией Спасения в Хемнице в рамках серии проповедей о Десяти заповедях.",
        questions: [
          Question(
            text: "В какой мере я избегал ставить другие вещи или дела рядом с единственным истинным Богом?",
            description: "Да не будет у тебя других богов пред лицем Моим. (Исход 20:1–6)",
          ),
          Question(
            text: "Насколько последовательно я избегал создания или изготовления образа Бога?",
            description: "Не делай себе кумира. (Исход 20:4)",
          ),
          Question(
            text: "Насколько я избегал бездумного использования имени Бога?",
            description: "Не произноси имени Господа, Бога твоего, напрасно. (Исход 20:7)",
          ),
          Question(
            text: "Делаю ли я сознательно перерыв, чтобы почтить Бога?",
            description: "А день седьмой — суббота Господу, Богу твоему. (Исход 20:8–11)",
          ),
          Question(
            text: "В какой мере я почитаю своих родителей и проявляю к ним уважение?",
            description: "Почитай отца твоего и мать твою. (Исход 20:12)",
          ),
          Question(
            text: "Насколько последовательно я избегаю причинения вреда другим людям мыслью, словом или делом?",
            description: "Не убивай. (Исход 20:13)",
          ),
          Question(
            text: "В какой мере я храню верность и считаю брак священным?",
            description: "Не прелюбодействуй. (Исход 20:14)",
          ),
          Question(
            text: "Насколько надежно я не посягаю на чужую собственность и практикую честность?",
            description: "Не кради. (Исход 20:15)",
          ),
          Question(
            text: "В какой мере я избегаю распространения ложных сведений о других людях или сплетен?",
            description: "Не произноси ложного свидетельства на ближнего твоего. (Исход 20:16)",
          ),
          Question(
            text: "Насколько я избегаю зависти к тому, что принадлежит другим людям, или к тому, как живут другие люди?",
            description: "Не желай дома ближнего твоего... ни всего, что у ближнего твоего. (Исход 20:17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "Уильям Бут",
        description: "Вопросы для самоанализа, которые Уильям Бут задавал себе каждый вечер.",
        questions: [
          Question(
            text: "Виновен ли я привычно в каком-либо известном грехе? Практикую ли я или позволяю себе какие-либо мысли, слова или поступки, за которые меня осуждает совесть?",
            isPositive: true,
          ),
          Question(
            text: "Являюсь ли я настолько хозяином своих телесных влечений, чтобы не проявлять постыдного поведения? Позволяю ли я себе какие-либо излишества, вредящие моей святости, росту в познании, послушанию и полезности?",
          ),
          Question(
            text: "Являются ли все мои мысли и чувства такими, за которые мне не было бы стыдно, если бы они были открыты пред Богом?",
          ),
          Question(
            text: "Ведет ли влияние мира меня к тому, чтобы делать или говорить что-либо, что не соответствует характеру христианина?",
            isPositive: true,
          ),
          Question(
            text: "Ведет ли мой нрав к тому, что я чувствую, делаю или говорю что-либо, что, как я позже осознаю, противоречит той любви, которую я должен всегда питать к своим ближним?",
            isPositive: true,
          ),
          Question(
            text: "Делаю ли я все, что в моих силах, для спасения грешников? Волнует ли меня то, что они в опасности? Молюсь ли я о них, борюсь ли за их спасение так, как если бы они были моими собственными детьми?",
          ),
          Question(
            text: "Выполняю ли я свои обеты, данные Богу в акте освящения или у алтаря?",
          ),
          Question(
            text: "Гармонирует ли мой пример с моими словами?",
          ),
          Question(
            text: "Горд ли я или высокомерен по натуре или на вид?",
            isPositive: true,
          ),
          Question(
            text: "Сообразуюсь ли я с обычаями и модой мира или имею мужество идти против течения?",
            isPositive: true,
          ),
          Question(
            text: "Нахожусь ли я в опасности быть увлеченным мирским желанием быть богатым или объектом восхищения?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "Джон Уэсли",
        description: "22 вопроса Джона Уэсли, которые он задавал себе для самоанализа каждый день:",
        questions: [
          Question(
            text: "Создаю ли я сознательно или бессознательно впечатление, что я лучше, чем есть на самом деле? Другими словами, не лицемер ли я?",
            isPositive: true,
          ),
          Question(
            text: "Честен ли я во всех своих поступках и словах, или я преувеличиваю?",
            isPositive: true,
          ),
          Question(
            text: "Передаю ли я конфиденциально другому то, что было сказано мне по секрету?",
            isPositive: true,
          ),
          Question(
            text: "Можно ли мне доверять?",
          ),
          Question(
            text: "Являюсь ли я рабом одежды, друзей, работы или привычек?",
          ),
          Question(
            text: "Являюсь ли я самосознательным, жалеющим себя или оправдывающим себя?",
            isPositive: true,
          ),
          Question(
            text: "Жила ли Библия во мне сегодня?",
          ),
          Question(
            text: "Даю ли я Библии время говорить со мной каждый день?",
          ),
          Question(
            text: "Получаю ли я удовольствие от молитвы?",
          ),
          Question(
            text: "Когда я в последний раз говорил с кем-то о своей вере?",
          ),
          Question(
            text: "Молюсь ли я о деньгах, которые трачу?",
          ),
          Question(
            text: "Ложусь ли я вовремя и встаю ли вовремя?",
          ),
          Question(
            text: "Ослушиваюсь ли я Бога в чем-либо?",
            isPositive: true,
          ),
          Question(
            text: "Настаиваю ли я на том, чтобы делать что-то, от чего моя совесть неспокойна?",
            isPositive: true,
          ),
          Question(
            text: "Потерпел ли я поражение в какой-либо части своей жизни?",
            isPositive: true,
          ),
          Question(
            text: "Являюсь ли я ревнивым, нечистым, критичным, раздражительным, обидчивым или недоверчивым?",
            isPositive: true,
          ),
          Question(
            text: "Как я провожу свободное время?",
          ),
          Question(
            text: "Горд ли я?",
            isPositive: true,
          ),
          Question(
            text: "Благодарю ли я Бога за то, что я не такой, как другие люди, особенно как фарисеи, презиравшие мытаря?",
            isPositive: true,
          ),
          Question(
            text: "Есть ли кто-то, кого я боюсь, кому не верю, в ком ошибаюсь, кого критикую или на кого обижаюсь? Если да, что я с этим делаю?",
            isPositive: true,
          ),
          Question(
            text: "Держу ли я обиду?",
            isPositive: true,
          ),
          Question(
            text: "Ворчу ли я или постоянно жалуюсь?",
            isPositive: true,
          ),
          Question(
            text: "Реален ли Христос для меня?",
          ),
        ],
      ),
    };
  }
}
