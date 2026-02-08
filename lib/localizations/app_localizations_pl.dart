import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override String get greetings => 'Witamy w narzędziu do autooceny';
  @override String get start => 'Rozpocznij';
  @override String get results => 'Wyniki';
  @override String get settings => 'Ustawienia';
  @override String get examinTitle => 'Autoocena';
  @override String get noteHint => 'Dodaj notatki...';
  @override String get pleasAnswer => 'Proszę odpowiedzieć na wszystkie pytania.';
  @override String get commit => 'Gotowe';
  @override String get saved => 'Dane zapisane';
  @override String get chartTitle => 'Wykres rozwoju';
  @override String get noHistory => 'Brak danych. Proszę wypełnić pytania.';
  @override String get warningTitle => 'Ostrzeżenie';
  @override String warningDel(String autor, Object author) => 'Wszystkie postępy dla $autor zostaną usunięte. Kontynuować?';
  @override String get settingsTitle => 'Ustawienia';
  @override String get chooseQuestionSet => 'Wybierz zestaw';
  @override String get delete => 'Usuń dane';
  @override String get notification => 'Przypomnij mi';
  @override String get notificationFrequency => 'Częstotliwość';
  @override String get daily => 'codziennie';
  @override String get weekly => 'tygodniowo';
  @override String get monthly => 'miesięcznie';
  @override String get datasecurityDialog => 'Dialog RODO';
  @override String get dsgvoNo => 'Odmowa zgody';
  @override String get dsgvoNoInfo => 'Aplikacja może działać tylko po wyrażeniu zgody.';
  @override String get ok => 'ok';
  @override String get cancel => 'anuluj';
  @override String get dsgvoTitle => 'Ochrona danych';
  @override String get dsgvo1 => 'Aby śledzić rozwój duchowy, przechowujemy odpowiedzi lokalnie.';
  @override String get dsgvo2 => 'Inne osoby z dostępem do urządzenia mogą widzieć te dane.';
  @override String get dsgvo3 => 'Klikając „Zgadzam się”, akceptujesz przechowywanie danych.';
  @override String get dsgvoOK => 'Zgadzam się';
  @override String get dsgvoCancel => 'Sprzeciwiam się';
  @override String get dsgvoYes => 'Zgoda udzielona';
  @override String get close => 'Zamknij';
  @override String get total => 'Razem';
  @override String get compareChart => 'Porównanie';
  @override String get timeChart => 'Oś czasu';
  @override String get fullDateAndTime => 'EEE, dd MMM yyyy HH:mm';
  @override String get fullDate => 'dd MMM yyyy';
  @override String get shortDate => 'dd.MM.yy';
  @override String get shortTime => 'HH:mm';
  @override List<String> get rating => ["Bardzo dobrze", "Dobrze", "Nie tak dobrze", "Wymaga pracy"];
  @override List<String> get answers => ["Wcale nie", "Trochę", "Większość czasu", "Całkowicie"];
  @override List<String> get frequenze => ["codziennie", "tygodniowo", "miesięcznie", "rocznie"];

  @override String get filterQuestions => "Filtruj pytania";
  @override String get today => "Dzisiaj";
  @override String get noData => "Brak danych";
  @override String get radarError => "Wykres radarowy wymaga co najmniej 3 wybranych pytań.";
  @override String get prevPeriod => "Poprzedni okres";
  @override String get currPeriod => "Bieżący okres";
  @override String get all => "Wszystko";
  @override List<String> get timeRangeShort => ["2D", "1T", "1M", "1R", "Wszystko"];
  @override String get tips => "Porady i informacje";

  @override String get settingsQuestionSetSubtitle => "Wybierz zestaw do edycji lub usunięcia danych.";
  @override String get settingsExportHeader => "Eksport danych";
  @override String get settingsExportAll => "Eksportuj wszystko";
  @override String get settingsExportValues => "Wartości i średnia";
  @override String get settingsExportAverage => "Tylko średnia";
  @override String get settingsSecurityHeader => "Bezpieczeństwo i prywatność";
  @override String get settingsSecurityLock => "Włącz blokadę aplikacji";
  @override String get settingsReminderHeader => "Przypomnienie";
  @override String get settingsNoDataToExport => "Brak danych do eksportu.";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Armia Zbawienia Chemnitz",
        description: "Pytania oparte na dekalogu.",
        questions: [
          Question(text: "Czy unikam stawiania innych rzeczy obok Boga?"),
          Question(text: "Czy unikam tworzenia obrazów Boga?"),
          Question(text: "Czy nie nadużywam imienia Bożego?"),
          Question(text: "Czy święcę dzień święty?"),
          Question(text: "Czy czczę rodziców?"),
          Question(text: "Czy nie krzywdzę innych?"),
          Question(text: "Czy unikam cudzołóstwa?"),
          Question(text: "Czy jestem uczciwy i nie kradnę?"),
          Question(text: "Czy nie kłamię przeciw bliźniemu?"),
          Question(text: "Czy nie pożądam cudzej własności?"),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Pytania o samozaparcie.",
        questions: [
          Question(text: "Czy jestem winny grzechu nawykowego?", isPositive: true),
          Question(text: "Czy panuję nad pragnieniami?"),
          Question(text: "Czy moje myśli są czyste?"),
          Question(text: "Czy świat skłania mnie do zła?", isPositive: true),
          Question(text: "Czy zawsze działam z miłością?", isPositive: true),
          Question(text: "Czy dbam o zbawienie grzeszników?"),
          Question(text: "Czy wypełniam śluby?"),
          Question(text: "Czy mój przykład jest zgodny z wiarą?"),
          Question(text: "Czy jestem dumny?", isPositive: true),
          Question(text: "Czy idę pod prąd świata?"),
          Question(text: "Czy pożądam bogactwa?", isPositive: true),
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "22 pytania Wesleya:",
        questions: [
          Question(text: "Czy jestem hipokrytą?", isPositive: true),
          Question(text: "Czy jestem uczciwy?", isPositive: true),
          Question(text: "Czy dochowuję tajemnicy?", isPositive: true),
          Question(text: "Czy można mi ufać?"),
          Question(text: "Czy jestem niewolnikiem nawyków?", isPositive: true),
          Question(text: "Czy Biblia żyje we mnie?"),
          Question(text: "Czy mam czas na modlitwę?"),
          Question(text: "Czy Jezus jest realny?"),
        ],
      ),
    };
  }
}
