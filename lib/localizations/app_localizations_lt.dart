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
  @override String get generalNoteLabel => 'Bendra pastaba';
  @override String get generalNoteHint => 'Kokia tavo bendra dvasinė būklė šiandien? (neprivaloma)';
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
  @override String get notificationReminderBody => 'Laikas savo kasdieniam savęs vertinimui.';
  @override String get notificationPermissionDenied => 'Priminimams reikalingas pranešimų leidimas. Įjunk pranešimus sistemos nustatymuose.';
  @override String get daily => 'kasdien';
  @override String get weekly => 'kas savaitę';
  @override String get monthly => 'kas mėnesį';
  @override String get datasecurityDialog => 'BDAR Dialogas';
  @override String get dsgvoNo => 'Sutikimas atmestas';
  @override String get dsgvoNoInfo => 'Deja, programa gali veikti tik jei sutinkate.';
  @override String get ok => 'gerai';
  @override String get cancel => 'atšaukti';
  @override String get dsgvoTitle => 'Duomenų apsauga';
  @override String get dsgvo1 => 'Siekiant sekti Jūsų dvasinį vystymąsi, mes saugome Jūsų atsakymus lokaliai Jūsų įrenginyje.';
  @override String get dsgvo2 => 'Jokie duomenys neperduodami į debesį. Jūsų privatumas 100 % lieka Jūsų telefone.';
  @override String get dsgvo3 => 'Spausdami „Sutinku“, Jūs sutinkate su vietiniu saugojimu. Be sutikimo programėlė negali saugoti istorijos duomenų.';
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
  @override String get selectAll => "Pasirinkti viską";
  @override String get selectNone => "Atšaukti viską";
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
  @override String get settingsLanguage => 'Kalba';
  @override String get chooseLanguage => 'Pasirinkti kalbą';
  @override String get systemDefault => 'Sistemos numatytasis';

  @override String get about => "Apie programėlę";
  @override String get aboutContent => "Ši programėlė skirta asmeninei refleksijai ir dvasiniam augimui. Įkvėpta William Booth ir John Wesley.";
  @override String get version => "Versija";
  @override String get imprint => "Atspaudas";
  @override String get license => "Licencijos";
  @override String get imprintContent => "Atsakingas: Matthias Lindner\nKontaktai: ";
  @override String get githubRepository => "GitHub saugykla (Pranešti apie klaidas ir prisidėti)";

  @override String get onboardingSkip => "Praleisti";
  @override String get onboardingNext => "Toliau";
  @override String get onboardingStart => "Pradėti";

  @override
  String get onboarding1Title => "Savęs Vertinimo Programėlė";

  @override
  String get onboarding1DescriptionTop =>
      "William Booth ir John Wesley reguliariai skirdavo laiko savęs vertinimui.\n"
          "Kaip šiandien išgyvenau savo tikėjimą?\n"
          "Kur Dievo meilė galėjo tapti matoma per mane?\n"
          "And kur ji dar nori mane keisti?\n\n"
          "Ši programėlė kviečia jus būtent tokiai nuoširdžiai refleksijai.\n"
          "Galite rinktis iš skirtingų klausimų rinkinių, fiksuoti savo atsakymus\n"
          "ir stebėti savo vystymąsi per dienas, savaites, mėnesius ar metus –\n"
          "bendrai arba atskirose srityse.\n\n"
          "Kaip pagalba suvokti, kur Dievo meilė jus kviečia toliau veikti –\n"
          "ir kur augimas vis dar įmanomas.";

  @override
  String get onboarding1DescriptionBottom =>
      "Čia galite rinktis iš skirtingų savęs vertinimo klausimų rinkinių. "
          "Kiekviename rinkinyje yra skirtingi klausimai su savo akcentais. "
          "Visų klausimų apžvalgą galite gauti paspaudę informacijos piktogramą (i).";

  @override
  String get onboarding2Title => "Refleksija ir Pastabos";

  @override
  String get onboarding2Step1Title => "Refleksija";

  @override
  String get onboarding2Step1Description =>
      "Pastumkite slankiklį, kad patys įvertintumėte, "
          "kaip šiandien atsakytumėte į atitinkamą klausimą.\n\n"
          "Jei jaučiate, kad jūsų atsakymas yra labiau teigiamas, stumkite slankiklį žalios spalvos kryptimi. "
          "Jei jaučiate, kad jis labiau neigiamas, stumkite jį raudonas spalvos kryptimi.\n\n"
          "Virš slankiklio bus rodomas jūsų pasirinktas įvertinimas procentais.";

  @override
  String get onboarding2Step2Title => "Pastabos";

  @override
  String get onboarding2Step2Description =>
      "Bakstelėkite užrašų piktogramą (lapas su pliusu), kad užfiksuotumėte mintį, pastebėjimą "
          "ar maldą. Pastaba bus išsaugota kartu with klausimu ir atitinkama data.\n\n"
          "Dar kartą bakstelėkite užrašų piktogramą, kad vėl uždarytumėte užrašų lauką.";

  @override
  String get onboarding3Title => "Analizė ir Saugumas";

  @override
  String get onboarding3Step1Title => "Diagramos";

  @override
  String get onboarding3Step1Description =>
      "Atsakę į visus klausimus, mygtuku „Baigta“ pateksite į diagramų vaizdą.\n\n"
          "Braukite diagramoje į kairę arba į dešinę, kad perjungtumėte skirtingus vaizdus. "
          "Po diagramomis galite pasirinkti, kurie klausimai turi būti rodomi analizėje.";

  @override
  String get onboarding3Step2Title => "Privatumas";

  @override
  String get onboarding3Step2Description =>
      "Jūsų duomenys saugomi tik lokaliai jūsų įrenginyje.\n\n"
          "Pasirinktinai galite juos papildomai apsaugoti savo įrenginio PIN kodu arba biometrinėmis "
          "apsaugos priemonėmis (pvz., piršto atspaudu arba veido atpažinimu).\n\n"
          "Prireikus galite eksportuoti savo duomenis su skirtingu detalumu kaip CSV failą "
          "ir, pavyzüdyje, toliau analizuoti juos „Excel“ programoje.";

  @override String get appLocked => "Programėlė užrakinta";
  @override String get unlock => "Atrakinti";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Dešimt įsakymų",
        description:
        "Heilsarmee Chemnitz sukurtas klausimų rinkinys pagal pamokslų ciklą apie Dešimt įsakymų.",
        questions: [
          Question(
            text: "Kiek man pavyko išvengti kitų dalykų ar objektų iškėlimo šalia vienintelio tikrojo Dievo?",
            description: "Neturėk kitų dievų šalia manęs! (Išėjimo 20, 1–6)",
          ),
          Question(
            text: "Kaip nuosekliai vengiau susikurti ar pasigaminti Dievo atvaizdą?",
            description: "Nedaryk sau jokio Dievo atvaizdo! (Išėjimo 20, 4)",
          ),
          Question(
            text: "Kiek vengiau neapgalvotai vartoti Dievo vardą?",
            description: "Nenaudok piktam Viešpaties, savo Dievo, vardo! (Išėjimo 20, 7)",
          ),
          Question(
            text: "Ar sąmoningai skiriu laiko Dievui pagerbti?",
            description: "O septintoji diena yra šventė Viešpaties, tavo Dievo, garbei! (Išėjimo 20, 8–11)",
          ),
          Question(
            text: "Kiek gerbiu savo tėvus ir rodau jiems pagarbą?",
            description: "Gerbk tavo tėvą ir motiną! (Išėjimo 20, 12)",
          ),
          Question(
            text: "Kaip nuosekliai vengiu kenkti kitiems žmonėms mintimis, žodžiais ar net darbais?",
            description: "Nežudyk! (Išėjimo 20, 13)",
          ),
          Question(
            text: "Kiek laikausi atokiau nuo svetimavimo ir saugau santuoką šventą?",
            description: "Nesvetimauk! (Išėjimo 20, 14)",
          ),
          Question(
            text: "Kaip patikimai neliečiu svetimo turto ir praktikuoju sąžiningumą?",
            description: "Nevok! (Išėjimo 20, 15)",
          ),
          Question(
            text: "Kiek vengiau skleisti melagingą informaciją apie kitus žmones ar apkalbinėti?",
            description: "Neliudyk melagingai prieš savo artimą! (Išėjimo 20, 16)",
          ),
          Question(
            text: "Kiek vengiu pavydėti to, kas priklauso kitiems žmonėms ar kaip kiti žmonės gyvena?",
            description: "Negeisk savo artimo namų! (Išėjimo 20, 17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description:
        "Savęs vertinimo klausimai, kuriuos William Booth užduodavo sau kiekvieną vakarą.",
        questions: [
          Question(
            text: "Ar esu kaltas dėl kokios nors žinomos nuodėmės? Ar nusidedu tyčia ar dėl aplaidumo mintimis, žodžiais ar darbais, gerai žinodamas, kad elgiuosi neteisingai?",
            isPositive: true,
          ),
          Question(
            text: "Ar taip kontroliuoju savo kūniškus troškimus, kad nesijaučiu kaltas? Ar pasiduodu kokiam nors polinkiui, kuris kenkia mano šventėjimui, augimui pažinime, paklusnumui ir naudingumui?",
          ),
          Question(
            text: "Ar visos mano mintys ir jausmai yra tokie, kad man nereikėtų gėdytis, jei jie būtų atskleisti prieš Dievą?",
          ),
          Question(
            text: "Ar pasaulio įtaka mane verčia daryti ar sakyti dalykus, kurie netinka Kristaus sekėjui?",
            isPositive: true,
          ),
          Question(
            text: "Ar mano charakteris verčia mane jausti, daryti ar sakyti ką nors, kas, kaip vėliau suprantu, prieštarauja meilei, kurią visada turėčiau jausti savo artimui?",
            isPositive: true,
          ),
          Question(
            text: "Ar darau viską, kas mano galioje, kad nusidėjėliai būtų išgelbėti? Ar man rūpi, kad jiems gresia pavojus? Ar meldžiuosi už juos, ar kovoju už jų išgelbėjimą taip, lyg jie būtų mano paties vaikai?",
          ),
          Question(
            text: "Ar vykdau savo pažadus, kuriuos daviau Dievui pasiaukojimo metu ar prie atgailos suolo?",
          ),
          Question(
            text: "Ar mano pavyzdys dera su mano žodžiu?",
          ),
          Question(
            text: "Ar savo prigimtimi ir elgesiu esu išdidus ar arogantiškas?",
            isPositive: true,
          ),
          Question(
            text: "Ar prisitaikau prie pasaulio papročių ir mados, ar turiu drąsos plaukti prieš srovę?",
            isPositive: true,
          ),
          Question(
            text: "Ar man gresia pavojus pasiduoti pasaulietiškam troškimui būti turtingam ar žavinčiam?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description:
        "John Wesley 22 klausimai, kuriuos jis užduodavo sau savęs vertinimui kiekvieną dieną:",
        questions: [
          Question(
            text: "Ar sąmoningai ar nesąmoningai sudarau įspūdį, kad esu geresnis nei esu iš tikrųjų? Kitaip tariant: ar esu veidmainis?",
            isPositive: true,
          ),
          Question(
            text: "Ar visuose savo veiksmuose ir žodžiuose esu sąžiningas, ar perdedu?",
            isPositive: true,
          ),
          Question(
            text: "Ar konfidencialiai perduodu kitiems tai, kas man buvo pasakyta paslaptyje?",
            isPositive: true,
          ),
          Question(
            text: "Ar esu patikimas?",
          ),
          Question(
            text: "Ar esu savo aprangos, draugų, darbo ar įpročių vergas?",
          ),
          Question(
            text: "Ar esu nesaugus, pilnas savigailos ar savęs pateisinimo?",
            isPositive: true,
          ),
          Question(
            text: "Ar Biblija šiandien gyva manyje?",
          ),
          Question(
            text: "Ar kiekvieną dieną skiriu Biblijai laiko su manimi kalbėtis?",
          ),
          Question(
            text: "Ar jaučiu džiaugsmą melsdamasis?",
          ),
          Question(
            text: "Kada paskutinį kartą su kuo nors kalbėjausi apie savo tikėjimą?",
          ),
          Question(
            text: "Ar meldžiuosi dėl pinigų, kuriuos išleidžiu?",
          ),
          Question(
            text: "Ar laiku einu miegoti ir laiku keliuosi?",
          ),
          Question(
            text: "Ar esu Dievui nepaklusnus kuriame nors dalyke?",
            isPositive: true,
          ),
          Question(
            text: "Ar primygtinai reikalauju daryti ką nors, dėl ko mano sąžinė nerimauja?",
            isPositive: true,
          ),
          Question(
            text: "Ar buvau nugalėtas kurioie nors savo gyvenimo dalyje?",
            isPositive: true,
          ),
          Question(
            text: "Ar esu pavydus, netyras, kritiškas, irzlus, jautrus ar įtarus?",
            isPositive: true,
          ),
          Question(
            text: "Kaip leidžiu laisvalaikį?",
          ),
          Question(
            text: "Ar esu išdidus?",
            isPositive: true,
          ),
          Question(
            text: "Ar dėkoju Dievui, kad nesu toks kaip kiti žmonės, ypač kaip fariziejai, kurie niekino muitininką?",
            isPositive: true,
          ),
          Question(
            text: "Ar yra kas nors, ko bijau, ko nemėgstu, su kuo nenoriu turėti nieko bendra, ką kritikuoju, kam jaučiu pagiežą ar ką ignoruoju? Jei taip, ką dėl to darau?",
            isPositive: true,
          ),
          Question(
            text: "Ar jaučiu kam nors pagiežą?",
            isPositive: true,
          ),
          Question(
            text: "Ar nuolat burbu ar skundžiuosi?",
            isPositive: true,
          ),
          Question(
            text: "Ar Kristus man tikras?",
          ),
        ],
      ),
    };
  }
}
