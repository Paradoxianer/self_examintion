import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override String get greetings => 'Sveiki atvykę į savęs vertinimo įrankį';
  @override String get start => 'Pradėti';
  @override String get results => 'Rezultatai';
  @override String get settings => 'Nustatymai';
  @override String get examinTitle => 'Savęs Vertinimas';
  @override String get noteHint => 'Pridėti pastabas..';
  @override String get pleasAnswer => 'Prašome atsakyti į visus klausimus.';
  @override String get commit => 'Baigta';
  @override String get saved => 'Duomenys išsaugoti';
  @override String get chartTitle => 'Vystymosi diagrama';
  @override String get noHistory => 'Nerasta jokių ankstesnių duomenų. Prašome atsakyti į klausimus.';
  @override String get warningTitle => 'Įspėjimas';
  @override String warningDel(String autor, Object author) => 'Visi išsaugoti $autor duomenys bus ištrinti. Ar norite tęsti?';
  @override String get settingsTitle => 'Nustatymai';
  @override String get chooseQuestionSet => 'Pasirinkite klausimų rinkinį';
  @override String get delete => 'Ištrinti duomenis';
  @override String get notification => 'Priminti man';
  @override String get notificationFrequency => 'Dažnumas';
  @override String get daily => 'kasdien';
  @override String get weekly => 'kas savaitę';
  @override String get monthly => 'kas mėnesį';
  @override String get datasecurityDialog => 'BDAR Dialogas';
  @override String get dsgvoNo => 'Sutikimas atmestas';
  @override String get dsgvoNoInfo => 'Deja, programa gali veikti tik jei sutinkate.';
  @override String get ok => 'gerai';
  @override String get cancel => 'atšaukti';
  @override String get dsgvoTitle => 'Duomenų apsauga';
  @override String get dsgvo1 => 'Siekiant sekti Jūsų dvasinį vystymąsi, mes saugome Jūsų atsakymus lokaliai.';
  @override String get dsgvo2 => 'Atkreipkite dėmesį, kad kiti asmenys gali turėti prieigą prie šių duomenų.';
  @override String get dsgvo3 => 'Paspausdami "Sutinku", Jūs sutinkate su duomenų saugojimu.';
  @override String get dsgvoOK => 'Sutinku';
  @override String get dsgvoCancel => 'Nesutinku';
  @override String get dsgvoYes => 'Sutikimas suteiktas';
  @override String get close => 'Uždaryti';
  @override String get total => 'Iš viso';
  @override String get compareChart => 'Palyginimas';
  @override String get timeChart => 'Laikas';
  @override String get fullDateAndTime => 'EEE, yyyy-MM-dd HH:mm';
  @override String get fullDate => 'yyyy-MM-dd';
  @override String get shortDate => 'yy-MM-dd';
  @override String get shortTime => 'HH:mm';
  @override List<String> get rating => ["Puikiai", "Geras kelias", "Neblogai", "Reikia tobulėti"];
  @override List<String> get answers => ["Visiškai ne", "Nedaug", "Daugiausia", "Visiškai"];
  @override List<String> get frequenze => ["kasdien", "kas savaitę", "kas mėnesį", "kasmet"];

  @override String get filterQuestions => "Filtruoti klausimus";
  @override String get today => "Šiandien";
  @override String get noData => "Duomenų nėra";
  @override String get radarError => "Radarų diagramai reikia bent 3 pasirinktų klausimų.";
  @override String get prevPeriod => "Ankstesnis laikotarpis";
  @override String get currPeriod => "Dabartinis laikotarpis";
  @override String get all => "Visi";
  @override List<String> get timeRangeShort => ["2D", "1S", "1M", "1M", "Visi"];
  @override String get tips => "Patarimai ir informacija";

  @override String get settingsQuestionSetSubtitle => "Pasirinkite rinkinį duomenims redaguoti arba ištrinti.";
  @override String get settingsExportHeader => "Duomenų eksportavimas";
  @override String get settingsExportAll => "Eksportuoti viską";
  @override String get settingsExportValues => "Vertės ir vidurkis";
  @override String get settingsExportAverage => "Tik vidurkis";
  @override String get settingsSecurityHeader => "Saugumas ir privatumas";
  @override String get settingsSecurityLock => "Įjungti programos užraktą";
  @override String get settingsReminderHeader => "Priminimas";
  @override String get settingsNoDataToExport => "Nėra duomenų eksportavimui.";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Heilsarmee Chemnitz",
        description: "Dešimt įsakymų.",
        questions: [
          Question(text: "Ar vengiu kitų dievų?"),
          Question(text: "Ar nedarau stabų?"),
          Question(text: "Ar nepiktnaudžiauju Dievo vardu?"),
          Question(text: "Ar švenčiu sabatą?"),
          Question(text: "Ar gerbiu tėvus?"),
          Question(text: "Ar nežudau?"),
          Question(text: "Ar vengiu svetimavimo?"),
          Question(text: "Ar nevogiu?"),
          Question(text: "Ar nemeluoju?"),
          Question(text: "Ar netrokštu svetimo turto?"),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Savęs neigimo klausimai.",
        questions: [
          Question(text: "Ar kaltas dėl žinomos nuodėmės?", isPositive: true),
          Question(text: "Ar kontroliuoju troškimus?"),
          Question(text: "Ar mintys švarios?"),
          Question(text: "Ar pasaulio įtaka veikia?", isPositive: true),
          Question(text: "Ar elgiuosi su meile?", isPositive: true),
          Question(text: "Ar rūpinuosi išgelbėjimu?"),
          Question(text: "Ar vykdau pažadus?"),
          Question(text: "Ar pavyzdys atitinka žodžius?"),
          Question(text: "Ar esu išdidus?", isPositive: true),
          Question(text: "Ar einu prieš srovę?"),
          Question(text: "Ar trokštu turtų?", isPositive: true),
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "Wesley 22 klausimai:",
        questions: [
          Question(text: "Ar esu veidmainis?", isPositive: true),
          Question(text: "Ar esu sąžiningas?", isPositive: true),
          Question(text: "Ar išduodu paslaptis?", isPositive: true),
          Question(text: "Ar patikimas?"),
          Question(text: "Ar esu įpročių vergas?", isPositive: true),
          Question(text: "Ar gailiuosi savęs?", isPositive: true),
          Question(text: "Ar Biblija gyva?"),
          Question(text: "Ar skiriu laiko maldai?"),
          Question(text: "Ar dalinuosi tikėjimu?"),
          Question(text: "Ar laiku einu miegoti?"),
          Question(text: "Ar priešinuosi Dievui?", isPositive: true),
          Question(text: "Ar esu išdidus?", isPositive: true),
          Question(text: "Ar Kristus man tikras?"),
        ],
      ),
    };
  }
}
