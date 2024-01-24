import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';

import 'app_localizations.dart';

/// Tłumaczenia dla języka niemieckiego (`de`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get greetings => 'Witamy w narzędziu do samopomiaru';

  @override
  String get start => 'Rozpocznij';

  @override
  String get results => 'Wyniki';

  @override
  String get settings => 'Ustawienia';

  @override
  String get examinTitle => 'Autoocena';

  @override
  String get noteHint => 'Dodaj notatki...';

  @override
  String get pleasAnswer => 'Proszę odpowiedzieć na wszystkie pytania.';

  @override
  String get commit => 'Gotowe';

  @override
  String get saved => 'Dane zapisane';

  @override
  String get chartTitle => 'Wykres rozwoju';

  @override
  String get noHistory =>
      'Nie znaleziono danych z poprzednich pytań do samopomiaru. Wybierz inny zestaw pytań lub wypełnij pytania.';

  @override
  String get warningTitle => 'Ostrzeżenie';

  @override
  String warningDel(String autor, Object author) {
    return 'Wszystkie zapisane postępy dla $autor zostaną usunięte i będą bezpowrotnie stracone. Czy chcesz kontynuować?';
  }

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get chooseQuestionSet => 'Wybierz zestaw pytań';

  @override
  String get delete => 'Usuń dane';

  @override
  String get notification => 'Przypomnij mi';

  @override
  String get notificationFrequency => 'Częstotliwość';

  @override
  String get daily => 'codziennie';

  @override
  String get weekly => 'tygodniowo';

  @override
  String get monthly => 'miesięcznie';

  @override
  String get datasecurityDialog => 'Dialog DSGVO';

  @override
  String get dsgvoNo => 'Odmowa zgody';

  @override
  String get dsgvoNoInfo =>
      'Aplikacja może funkcjonować tylko, jeśli wyrazisz zgodę.';

  @override
  String get ok => 'ok';

  @override
  String get cancel => 'anuluj';

  @override
  String get dsgvoTitle => 'Ochrona danych i zgoda';

  @override
  String get dsgvo1 =>
      'Aby śledzić Twój osobisty rozwój duchowy, przechowujemy Twoje odpowiedzi na zadane pytania. Dane te są anonimizowane i przechowywane lokalnie na Twoim urządzeniu.';

  @override
  String get dsgvo2 =>
      'Proszę pamiętać, że osoby mające dostęp do Twojego urządzenia i aplikacji mogą mieć dostęp do tych danych.';

  @override
  String get dsgvo3 =>
      'Klikając poniżej "Zgadzam się", wyrażasz zgodę na przechowywanie danych, jak opisano powyżej. Jeśli się nie zgadzasz, dane nie będą zbierane, ale aplikacja również nie będzie mogła funkcjonować.';

  @override
  String get dsgvoOK => 'Zgadzam się';

  @override
  String get dsgvoCancel => 'Sprzeciwiam się';

  @override
  String get dsgvoYes => 'Zgoda udzielona';

  @override
  String get close => 'Zamknij';

  @override
  String get total => 'Razem';

  @override
  String get compareChart => 'Wykres porównawczy';

  @override
  String get timeChart => 'Wykres czasowy';

  List<String> get rating => ["Bardzo dobrze", "Dobrze","Nie tak dobrze","Pilnie pracować"];

  List<String> get answers => ["Wcale nie","Trochę", "Większość czasu","Całkowicie"];

  List<String> get frequenze => ["codziennie","tygodniowo","miesięcznie","rocznie"];

  String get fullDateAndTime => 'EEE, dd MMM yyyy HH:mm';

  String get fullDate => 'dd MMM yyyy';

  String get shortDate => 'dd.MM.yy';

  String get shortTime => 'HH:mm';

  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Heilsarmee Chemnitz",
        description: "Pytania do samokontroli opracowane przez Heilsarmee Chemnitz, oparte na dziesięciu przykazaniach.",
        questions: [
          Question(
              text: "Do jakiego stopnia unikam stawiania innych rzeczy / spraw obok jedynego prawdziwego Boga?",
              description: "Nie będziesz miał innych bogów obok mnie! (2 Mojżeszowa 2, 1-6)",
              tips: "Przeczytaj Biblię, na przykład na [www.bibelserver.com](https://bibelserver.com/)" ),
          Question(
              text: "Jak konsekwentnie unikam tworzenia sobie obrazu Boga lub jego wyrabiania?",
              description: "Nie będziesz robił sobie wyobrażenia boga! (2 Mojżeszowa 2, 4)"),
          Question(
              text: "Jak bardzo unikam lekkomyślnego używania imienia Boga?",
              description:
              "Nie będziesz nadużywał imienia Pana, Boga swego! (2 Mojżeszowa 2, 7)"),
          Question(
              text: "Czy raz na sześć dni biorę dzień wolny, aby oddać cześć Bogu?",
              description:
              "Ale siódmy dzień jest dniem świątecznym ku czci Pana, Boga twojego! (2 Mojżeszowa 2, 8-11)"),
          Question(
              text: "Do jakiego stopnia szanuję swoich rodziców i okazuję im szacunek?",
              description: "Czcij ojca swego i matkę swoją! (2 Mojżeszowa 2, 12)"),
          Question(
              text: "Jak konsekwentnie unikam krzywdzenia innych ludzi w myślach, słowach lub nawet czynach?",
              description:
              "Nie będziesz zabijał! (2 Mojżeszowa 2, 13)"),
          Question(
              text: "Jak bardzo trzymam się z dala od cudzołóstwa i zachowuję małżeństwo jako świętą instytucję?",
              description:
              "Nie będziesz cudzołożył! (2 Mojżeszowa 2, 14)"),
          Question(
              text: "Jak niezawodnie trzymam się z dala od cudzej własności i praktykuję uczciwość?" ,
              description: "Nie będziesz kraść! (2 Mojżeszowa 2, 15)"),
          Question(
              text: "Do jakiego stopnia unikam rozpowszechniania fałszywych informacji o innych ludziach lub obgadywania ich?",
              description: "Nie będziesz fałszywie świadczył przeciw bliźniemu swemu! (2 Mojżeszowa 2, 16)"),
          Question(
              text: "Jak bardzo unikam zazdrości o to, co należy do innych ludzi lub o to, jak inni ludzie żyją?",
              description: "Nie będziesz pożądał domu bliźniego swego! Nie będziesz pożądał żony bliźniego swego, ani jego sługi, ani jego służącej, ani jego wołu, ani jego osła, ani czegokolwiek, co należy do bliźniego twego. (2 Mojżeszowa 2, 16)")
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Pytania do samozaparcia od Williama Bootha",
        questions: [
          Question(
              text:
              "Czy jestem winny grzechu nawykowego? Czy grzeszę celowo lub zaniedbując w myślach, słowach lub czynach, dobrze wiedząc, że czynię źle?",
              isPositive: true),
          Question(
              text:
              "Czy mam taką kontrolę nad moimi cielesnymi pragnieniami, że nie dopuszczam się grzechu? Czy pozwalając sobie na jakiekolwiek skłonności, ograniczam moją świętość, rozwój w wiedzy, posłuszeństwo i użyteczność?"),
          Question(
              text:
              "Czy wszystkie moje myśli i uczucia są takie, że nie muszę się wstydzić, gdy zostaną ujawnione przed Bogiem?"),
          Question(
              text:
              "Czy wpływ świata skłania mnie do robienia lub mówienia rzeczy, które nie pasują do Chrystusa?",
              isPositive: true),
          Question(
              text:
              "Czy moja skłonność skłania mnie do czucia, robienia lub mówienia czegoś, co później uznaję za sprzeczne z miłością, którą zawsze powinienem mieć dla bliźnich?",
              isPositive: true),
          Question(
              text:
              "Czy robię wszystko, co w mojej mocy, aby grzesznicy byli zbawieni? Czy troszczę się o to, że są w niebezpieczeństwie? Czy modlę się za nich, walczę o ich zbawienie, jakby byli moimi własnymi dziećmi?"),
          Question(
              text:
              "Czy spełniam moje śluby, które złożyłem przed Bogiem podczas aktu poświęcenia lub przy ławce pokutnej?"),
          Question(
            text: "Czy moje przykładanie jest zgodne z moimi słowami?",
          ),
          Question(
              text: "Czy jestem dumny lub arogancki w moim zachowaniu i postawie?",
              isPositive: true),
          Question(
              text:
              "Czy dostosowuję się do zwyczajów i obyczajów świata, czy mam odwagę płynąć pod prąd?"),
          Question(
              text:
              "Czy jestem w niebezpieczeństwie, że pozwolę się porwać światowym pragnieniom bycia bogatym lub podziwianym?",
              isPositive: true),
          // Dodaj więcej pytań od Williama Bootha tutaj
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description:
        "John Wesley, założyciel Metodystów, codziennie dokładnie badał siebie, zadając sobie następujące 22 pytania:",
        questions: [
          Question(
              text: "Czy świadomie czy nieświadomie sprawiam wrażenie, że jestem lepszy, niż jestem w rzeczywistości? Innymi słowy: czy jestem hipokrytą?",
              isPositive: true),
          Question(
              text: "Czy jestem uczciwy we wszystkich moich działaniach i słowach, czy przesadzam?",
              isPositive: true),
          Question(
              text: "Czy przekazuję innym poufne informacje, które powierzono mi w zaufaniu?",
              isPositive: true),
          Question(text: "Czy można mi ufać?"),
          Question(
              text: "Czy jestem niewolnikiem mojego ubioru, przyjaciół, pracy lub nawyków?",
              isPositive: true),
          Question(
              text: "Czy jestem pewny siebie, użalam się nad sobą lub usprawiedliwiam?",
              isPositive: true),
          Question(text: "Czy Biblia żyje we mnie dzisiaj?"),
          Question(text: "Czy codziennie poświęcam czas na rozmowę z Biblią?"),
          Question(text: "Czy cieszę się z modlitwy?"),
          Question(text: "Kiedy ostatnio rozmawiałem z kimś o mojej wierze?"),
          Question(text: "Czy modlę się nad pieniędzmi, które wydaję?"),
          Question(text: "Czy kładę się spać na czas i wstaję na czas?"),
          Question(text: "Czy sprzeciwiam się Bogu w czymkolwiek?",
              isPositive: true),
          Question(text: "Czy upieram się przy robieniu czegoś, co niepokoi moje sumienie?",
              isPositive: true),
          Question(text: "Czy jestem słaby w jakiejś części mojego życia?",
              isPositive: true),
          Question(text: "Czy jestem zazdrosny, nieczysty, krytyczny, drażliwy, przewrażliwiony lub podejrzliwy?",
              isPositive: true),
          Question(text: "Jak spędzam swój wolny czas?",
              isPositive: true),
          Question(text: "Czy jestem dumny?",
              isPositive: true),
          Question(text: "Czy dziękuję Bogu, że nie jestem jak inni ludzie, zwłaszcza jak Faryzeusze, którzy pogardzali celnikiem?",
              isPositive: true),
          Question(text: "Czy jest ktoś, kogo się boję, nie znoszę, odrzucam, krytykuję, mam do niego urazę lub ignoruję? Jeśli tak, co robię w tej sprawie?",
              isPositive: true),
          Question(text: "Czy ciągle narzekam lub skarżę się?",
              isPositive: true),
          Question(text: "Czy Chrystus jest dla mnie rzeczywisty?")
        ],
      )
    };
    return _questionMap;
  }
}
