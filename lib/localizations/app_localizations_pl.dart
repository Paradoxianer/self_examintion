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
  @override String get datasecurityDialog => 'Prywatność i RODO';
  @override String get dsgvoNo => 'Odmowa zgody';
  @override String get dsgvoNoInfo => 'Aplikacja może działać tylko po wyrażeniu zgody.';
  @override String get ok => 'OK';
  @override String get cancel => 'Anuluj';
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
  @override String get selectAll => "Zaznacz wszystko";
  @override String get selectNone => "Odznacz wszystko";
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

  @override String get about => "O aplikacji";
  @override String get aboutContent => "Ta aplikacja służy do osobistej refleksji i wzrostu duchowego. Zainspirowana przez Williama Bootha i Johna Wesleya.";
  @override String get version => "Wersja";
  @override String get imprint => "Nota prawna";
  @override String get license => "Licencje";
  @override String get imprintContent => "Odpowiedzialny: Matthias Lindner\nKontakt: ";
  @override String get githubRepository => "Repozytorium GitHub (Zgłoś błędy i współtwórz)";

  @override String get onboardingSkip => "Pomiń";
  @override String get onboardingNext => "Dalej";
  @override String get onboardingStart => "Zacznij";

  @override
  String get onboarding1Title => "Aplikacja Autorefleksja";

  @override
  String get onboarding1DescriptionTop =>
      "William Booth i John Wesley regularnie poświęcali czas na badanie własnego serca.\n"
          "Jak przeżyłem dzisiaj moją wiarę?\n"
          "Gdzie Boża miłość mogła stać się widoczna przeze mnie?\n"
          "A gdzie jeszcze chce mnie ona dalej zmieniać?\n\n"
          "Ta aplikacja zaprasza cię właśnie do takiej szczerej refleksji.\n"
          "Możesz wybierać spośród różnych zestawów pytań, zapisywać swoje odpowiedzi\n"
          "i obserwować swój rozwój na przestrzeni dni, tygodni, miesięcy lub lat –\n"
          "całościowo lub w poszczególnych obszarach.\n\n"
          "Jako pomoc w dostrzeganiu, gdzie Boża miłość zaprasza cię do dalszego działania –\n"
          "i gdzie wzrost jest wciąż możliwy.";

  @override
  String get onboarding1DescriptionBottom =>
      "Tutaj możesz wybierać między różnymi zestawami pytań do autorefleksji. "
          "Każdy zestaw zawiera inne pytania o innym punkcie ciężkości. "
          "Przegląd wszystkich pytań uzyskasz, dotykając symbolu informacji (i).";

  @override
  String get onboarding2Title => "Refleksja i Notatki";

  @override
  String get onboarding2Step1Title => "Refleksja";

  @override
  String get onboarding2Step1Description =>
      "Przesuń suwak, aby ocenić dla siebie samego, "
          "jak odpowiedziałbyś dzisiaj na dane pytanie.\n\n"
          "Jeśli czujesz, że twoja odpowiedź jest bardziej pozytywna, przesuń suwak w kierunku zielonym. "
          "Jeśli czujesz, że jest bardziej negatywna, przesuń go w kierunku czerwonym.\n\n"
          "Nad suwakiem wyświetli się twoja wybrana ocena w procentach.";

  @override
  String get onboarding2Step2Title => "Notatki";

  @override
  String get onboarding2Step2Description =>
      "Dotknij ikony notatki (kartka z plusem), aby zapisać myśl, obserwację "
          "lub modlitwę. Notatka zostanie zapisana razem z pytaniem i odpowiednią datą.\n\n"
          "Dotknij ponownie ikony notatki, aby zamknąć pole notatki.";

  @override
  String get onboarding3Title => "Analiza i Bezpieczeństwo";

  @override
  String get onboarding3Step1Title => "Wykresy";

  @override
  String get onboarding3Step1Description =>
      "Po udzieleniu odpowiedzi na wszystkie pytania, przejdziesz do widoku wykresów "
          "za pomocą przycisku „Gotowe”.\n\n"
          "Przesuń po wykresie w lewo lub w prawo, aby przełączać się między różnymi widokami. "
          "Poniżej wykresów możesz wybrać, które pytania mają być uwzględnione w analizie.";

  @override
  String get onboarding3Step2Title => "Prywatność";

  @override
  String get onboarding3Step2Description =>
      "Twoje dane pozostają zapisane wyłącznie lokalnie na twoim urządzeniu.\n\n"
          "Opcjonalnie możesz je dodatkowo zabezpieczyć kodem PIN urządzenia lub zabezpieczeniami "
          "biometrycznymi (np. odciskiem palca lub rozpoznawaniem twarzy).\n\n"
          "W razie potrzeby możesz wyeksportować swoje dane z różnym stopniem szczegółowości jako plik CSV "
          "i na przykład dalej analizować je w programie Excel.";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Dziesięć Przykazań",
        description:
        "Zestaw pytań opracowany przez Armię Zbawienia w Chemnitz w ramach serii kazań o Dziesięciu Przykazaniach.",
        questions: [
          Question(
            text: "W jakim stopniu unikałem stawiania innych rzeczy lub spraw ponad jedynego prawdziwego Boga?",
            description: "Nie będziesz miał innych bogów obok mnie! (2 Mojż. 20, 1–6)",
          ),
          Question(
            text: "Jak konsekwentnie unikałem czynienia sobie obrazu Boga?",
            description: "Nie będziesz czynił sobie żadnego rzeźbionego obrazu! (2 Mojż. 20, 4)",
          ),
          Question(
            text: "Jak bardzo unikałem używania imienia Bożego bez zastanowienia?",
            description: "Nie będziesz brał imienia Pana, Boga twego, nadaremno! (2 Mojż. 20, 7)",
          ),
          Question(
            text: "Czy świadomie robię sobie przerwę, aby oddać cześć Bogu?",
            description: "Ale siódmy dzień jest szabatem Pana, Boga twego! (2 Mojż. 20, 8–11)",
          ),
          Question(
            text: "W jakim stopniu szanuję moich rodziców i okazuję im respekt?",
            description: "Czcij ojca swego i matkę swoją! (2 Mojż. 20, 12)",
          ),
          Question(
            text: "Jak konsekwentnie unikam szkodzenia innym ludziom w myślach, słowach lub czynach?",
            description: "Nie będziesz zabijał! (2 Mojż. 20, 13)",
          ),
          Question(
            text: "W jakim stopniu unikam cudzołóstwa i zachowuję małżeństwo jako święte?",
            description: "Nie będziesz cudzołożył! (2 Mojż. 20, 14)",
          ),
          Question(
            text: "Jak rzetelnie unikam przywłaszczania sobie cudzej własności i praktykuję uczciwość?",
            description: "Nie będziesz kradł! (2 Mojż. 20, 15)",
          ),
          Question(
            text: "W jakim stopniu unikam rozpowszechniania nieprawdziwych rzeczy o innych ludziach lub plotkowania?",
            description: "Nie będziesz mówił przeciw bliźniemu swemu kłamstwa jako świadek! (2 Mojż. 20, 16)",
          ),
          Question(
            text: "Jak bardzo unikam zazdrości o to, co należy do innych ludzi lub jak żyją inni?",
            description: "Nie będziesz pożądał domu bliźniego swego! (2 Mojż. 20, 17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description:
        "Pytania do autorefleksji, które William Booth zadawał sobie każdego wieczoru.",
        questions: [
          Question(
            text: "Czy jestem winny jakiegoś znanego grzechu? Czy świadomie lub przez zaniedbanie grzeszę w myślach, słowach lub uczynkach, wiedząc, że czynię źle?",
            isPositive: true,
          ),
          Question(
            text: "Czy mam swoje cielesne pragnienia pod taką kontrolą, że nie czuję się winny? Czy ulegam jakiejś skłonności, która szkodzi mojemu uświęceniu, wzrostowi w poznaniu, posłuszeństwu i użyteczności?",
          ),
          Question(
            text: "Czy wszystkie moje myśli i uczucia są takie, że nie musiałbym się wstydzić, gdyby zostały objawione przed Bogiem?",
          ),
          Question(
            text: "Czy wpływ świata skłania mnie do robienia lub mówienia rzeczy, które nie pasują do naśladowcy Chrystusa?",
            isPositive: true,
          ),
          Question(
            text: "Czy moje usposobienie skłania mnie do odczuwania, robienia lub mówienia czegoś, o czym później przekonuję się, że jest sprzeczne z miłością, którą zawsze powinienem darzyć moich bliźnich?",
            isPositive: true,
          ),
          Question(
            text: "Czy czynię wszystko, co w mojej mocy, aby grzesznicy zostali zbawieni? Czy obchodzi mnie to, że są w niebezpieczeństwie? Czy modlę się za nich, walczę o ich zbawienie, jakby byli moimi własnymi dziećmi?",
          ),
          Question(
            text: "Czy wypełniam moje śluby, które złożyłem przed Bogiem w akcie oddania lub przy ławce pokutnej?",
          ),
          Question(
            text: "Czy mój przykład jest zgodny z moim słowem?",
          ),
          Question(
            text: "Czy w mojej naturze i zachowaniu jestem dumny lub arogancki?",
            isPositive: true,
          ),
          Question(
            text: "Czy dostosowuję się do zwyczajów i mód świata, czy mam odwagę płynąć pod prąd?",
            isPositive: true,
          ),
          Question(
            text: "Czy grozi mi, że dam się ponieść światowemu pragnieniu bycia bogatym lub podziwianym?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description:
        "22 pytania Johna Wesleya, które zadawał sobie codziennie w ramach autorefleksji:",
        questions: [
          Question(
            text: "Czy świadomie lub nieświadomie sprawiam wrażenie, że jestem lepszy niż w rzeczywistości? Innymi słowy: czy jestem hipokrytą?",
            isPositive: true,
          ),
          Question(
            text: "Czy we wszystkich moich działaniach i słowach jestem uczciwy, czy też przesadzam?",
            isPositive: true,
          ),
          Question(
            text: "Czy przekazuję innym w zaufaniu to, co mi powiedziano w tajemnicy?",
            isPositive: true,
          ),
          Question(
            text: "Czy można mi ufać?",
          ),
          Question(
            text: "Czy jestem niewolnikiem swojego ubioru, przyjaciół, pracy lub nawyków?",
          ),
          Question(
            text: "Czy jestem niepewny siebie, pełen użalania się nad sobą lub samousprawiedliwienia?",
            isPositive: true,
          ),
          Question(
            text: "Czy Biblia żyje dzisiaj we mnie?",
          ),
          Question(
            text: "Czy każdego dnia daję Biblii czas, aby do mnie mówiła?",
          ),
          Question(
            text: "Czy mam radość z modlitwy?",
          ),
          Question(
            text: "Kiedy ostatni raz rozmawiałem z kimś o mojej wierze?",
          ),
          Question(
            text: "Czy modlę się o pieniądze, które wydaję?",
          ),
          Question(
            text: "Czy kładę się spać o czasie i wstaję o czasie?",
          ),
          Question(
            text: "Czy jestem nieposłuszny Bogu w czymkolwiek?",
            isPositive: true,
          ),
          Question(
            text: "Czy upieram się przy robieniu czegoś, co niepokoi moje sumienie?",
            isPositive: true,
          ),
          Question(
            text: "Czy zostałem pokonany w jakiejś części mojego życia?",
            isPositive: true,
          ),
          Question(
            text: "Czy jestem zazdrosny, nieczysty, krytyczny, drażliwy, przewrażliwiony lub podejrzliwy?",
            isPositive: true,
          ),
          Question(
            text: "Jak spędzam wolny czas?",
          ),
          Question(
            text: "Czy jestem dumny?",
            isPositive: true,
          ),
          Question(
            text: "Czy dziękuję Bogu za to, że nie jestem jak inni ludzie, zwłaszcza jak faryzeusze, którzy gardzili celnikiem?",
            isPositive: true,
          ),
          Question(
            text: "Czy jest ktoś, kogo się boję, kogo nie lubię, z kim nie chcę mieć nic wspólnego, kogo krytykuję, do kogo żywię urazę lub kogo ignoruję? Jeśli tak, co z tym robię?",
            isPositive: true,
          ),
          Question(
            text: "Czy żywię do kogoś urazę?",
            isPositive: true,
          ),
          Question(
            text: "Czy ciągle narzekam lub skarżę się?",
            isPositive: true,
          ),
          Question(
            text: "Czy Chrystus jest dla mnie realny?",
          ),
        ],
      ),
    };
  }
}
