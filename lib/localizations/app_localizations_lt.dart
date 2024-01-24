import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';

import 'app_localizations.dart';

/// Vertimai vokiečių kalbai (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get greetings => 'Sveiki atvykę į savęs vertinimo įrankį';

  @override
  String get start => 'Pradėti';

  @override
  String get results => 'Rezultatai';

  @override
  String get settings => 'Nustatymai';

  @override
  String get examinTitle => 'Savęs Vertinimas';

  @override
  String get noteHint => 'Pridėti pastabas..';

  @override
  String get pleasAnswer => 'Prašome atsakyti į visus klausimus.';

  @override
  String get commit => 'Baigta';

  @override
  String get saved => 'Duomenys išsaugoti';

  @override
  String get chartTitle => 'Vystymosi diagrama';

  @override
  String get noHistory =>
      'Nerasta jokių ankstesnių savęs vertinimo klausimų duomenų. Prašome pasirinkti kitą klausimų rinkinį arba atsakyti į klausimus.';

  @override
  String get warningTitle => 'Įspėjimas';

  @override
  String warningDel(String autor, Object author) {
    return 'Visi išsaugoti $autor pažangos duomenys bus ištrinti ir prarasti amžinai. Ar norite tęsti?';
  }

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get chooseQuestionSet => 'Pasirinkite klausimų rinkinį';

  @override
  String get delete => 'Ištrinti duomenis';

  @override
  String get notification => 'Priminti man';

  @override
  String get notificationFrequency => 'Dažnumas';

  @override
  String get daily => 'kasdien';

  @override
  String get weekly => 'kas savaitę';

  @override
  String get monthly => 'kas mėnesį';

  @override
  String get datasecurityDialog => 'BDAR Dialogas';

  @override
  String get dsgvoNo => 'Sutikimas atmestas';

  @override
  String get dsgvoNoInfo =>
      'Deja, programa gali veikti tik jei sutinkate.';

  @override
  String get ok => 'gerai';

  @override
  String get cancel => 'atšaukti';

  @override
  String get dsgvoTitle => 'Duomenų apsauga ir sutikimas';

  @override
  String get dsgvo1 =>
      'Siekiant sekti Jūsų asmeninį dvasinį vystymąsi, mes saugome Jūsų atsakymus į užduotus klausimus. Šie duomenys yra anonimiškai saugomi lokalioje Jūsų įrenginyje.';

  @override
  String get dsgvo2 =>
      'Atkreipkite dėmesį, kad asmenys, turintys prieigą prie Jūsų įrenginio ir programos, gali turėti prieigą prie šių duomenų.';

  @override
  String get dsgvo3 =>
      'Paspausdami žemiau esantį "Sutinku", Jūs sutinkate, kad Jūsų duomenys bus saugomi kaip aprašyta aukščiau. Jei nesutinkate, duomenys nebus renkami, tačiau programa taip pat negalės veikti.';

  @override
  String get dsgvoOK => 'Sutinku';

  @override
  String get dsgvoCancel => 'Nesutinku';

  @override
  String get dsgvoYes => 'Sutikimas suteiktas';

  @override
  String get close => 'Uždaryti';

  @override
  String get total => 'Iš viso';

  @override
  String get compareChart => 'Palyginimo diagrama';

  @override
  String get timeChart => 'Laiko diagrama';

  String get fullDateAndTime => 'EEE, yyyy-MM-dd HH:mm';

  String get fullDate => 'yyyy-MM-dd';

  String get shortDate => 'yy-MM-dd';

  String get shortTime => 'HH:mm';

  List<String> get rating => ["Labai gerai", "Gerai","Neblogai","Reikia tobulėti"];


  List<String> get answers => ["Visiškai ne","Nedaug", "Daugiausia","Visiškai"];

  List<String> get frequenze => ["kasdien","kas savaitę","kas mėnesį","kasmet"];



  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Chemnico Heilsarmee",
        description: "Savigynos klausimai, sukurti Chemnico Heilsarmee, remiantis dešimčia Dievo įsakymų.",
        questions: [
          Question(
              text: "Kaip labai stengiuosi neįstatyti kitų dalykų šalia vieno tikrojo Dievo?",
              description:"Neturėsi kitų dievų šalia manęs! (Išėjimo 2, 1-6)",
              tips: "Paskaitykite Bibliją, pvz., [www.bibelserver.com](https://bibelserver.com/)"),
          Question(
              text: "Kaip nuosekliai vengiu sau kurti Dievo atvaizdą ar jį gaminti?",
              description: "Neturėsi sau padaryti jokio Dievo atvaizdo! (Išėjimo 2, 4)"),
          Question(
              text: "Kaip aš vengiau nesvarstyti Dievo vardo?",
              description:
              "Neturėsi piktnaudžiauti VIEŠPATIES, savo Dievo, vardu! (Išėjimo 2, 7)"),
          Question(
              text: "Ar kartais nesidariau laisvos dienos per šešias dienas, kad pagerbčiau Dievą?",
              description:
              "Bet septintoji diena yra šventė VIEŠPAČIUI, tavo Dievui! (Išėjimo 2, 8-11)"),
          Question(
              text: "Kaip aš gerbiu savo tėvus ir rodo jiems pagarbą?",
              description: "Gerbk savo tėvą ir motiną! (Išėjimo 2, 12)"),
          Question(
              text: "Kaip nuosekliai vengiu daryti žalą kitiems žmonėms mintyse, žodžiais ar net veiksmais?",
              description:
              "Nežudysi! (Išėjimo 2, 13)"),
          Question(
              text: "Kaip labai laikausi nuo svetimavimo ir saugoju santuoką kaip šventą instituciją?",
              description:
              "Nesvetimauk! (Išėjimo 2, 14)"),
          Question(
              text: "Kaip patikimai laikau rankas nuo svetimo turto ir praktikuoju sąžiningumą?",
              description: "Nevogsi! (Išėjimo 2, 15)"),
          Question(
              text: "Kiek aš vengiu skleisti neteisingus dalykus apie kitus žmones ar apkalbinėti?",
              description: "Nemeluok prieš savo artimą! (Išėjimo 2, 16)"),
          Question(
              text: "Kaip labai vengiu pavydo dėl to, kas priklauso kitiems žmonėms, ar kaip jie gyvena?",
              description: "Netrokšk savo artimo namo! Netrokšk savo artimo žmonos, nei jo tarno, nei tarnaitės, nei jo jaučio, nei jo asilo, nei bet ko, kas yra tavo artimo. (Išėjimo 2, 16)")
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "William Booth'o savęs neigimo klausimai",
        questions: [
          Question(
              text:
              "Ar kaltas esu dėl įpročio nuodėmės? Ar tyčia ar neatsargiai nusidedu mintimis, žodžiais ar veiksmais, gerai žinodamas, kad darau blogai?",
              isPositive: true),
          Question(
              text:
              "Ar kontroliuoju savo kūniškus troškimus taip, kad nesielgčiau nusikalstamai? Ar leidžiu sau laisvai veikti bet kokiems polinkiams, kurie trukdo mano šventumui, pažinimui, paklusnumui ir naudingumui?"),
          Question(
              text:
              "Ar visos mano mintys ir jausmai tokie, kad man nereikėtų gėdytis, jei jos taptų viešos prieš Dievą?"),
          Question(
              text:
              "Ar pasaulietiška įtaka mane skatina daryti ar sakyti dalykus, kurie nepriklauso Kristui?",
              isPositive: true),
          Question(
              text:
              "Ar mano polinkis verčia mane jausti, daryti ar sakyti kažką, ką vėliau suvokiu kaip prieštaraujantį meilei, kurią turėčiau visada rodyti savo artimui?",
              isPositive: true),
          Question(
              text:
              "Ar darau viską, kas mano galioje, kad nusidėjėliai būtų išgelbėti? Ar rūpi man, kad jie yra pavojingi? Ar meldžiuosi už juos, kovodamas už jų išgelbėjimą, lyg jie būtų mano vaikai?"),
          Question(
              text:
              "Ar vykdau savo pažadus, kuriuos kartą daviau Dievui atsidavimo akte ar ant atgailos suolelio?"),
          Question(
            text: "Ar mano pavyzdys atitinka mano žodį?",
          ),
          Question(
              text: "Ar aš esu išoriškai ir elgesiu stambus ar arogantiškas?",
              isPositive: true),
          Question(
              text:
              "Ar laikausi pasaulio papročių ir tradicijų, ar turiu drąsos eiti prieš srovę?"),
          Question(
              text:
              "Ar kyla pavojus, kad pasiduosiu pasaulio troškimui būti turtingam ar gerbiamam?",
              isPositive: true),
          // Čia galima pridėti daugiau William Booth'o klausimų
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description:
        "John Wesley, metodistų įkūrėjas, kasdien griežtai vertindavo save, užduodamas sau šiuos 22 klausimus:",
        questions: [
          Question(
              text:
              "Ar sąmoningai ar nesąmoningai sukeliau įspūdį, kad esu geresnis nei iš tikrųjų esu? Kitaip tariant, ar aš veidmainis?",
              isPositive: true),
          Question(
              text:
              "Ar esu sąžiningas visuose savo veiksmuose ir žodžiuose, ar perdėliojau?",
              isPositive: true),
          Question(
              text:
              "Ar pasitikiu kitais konfidencialia informacija, kuri man buvo patikėta pasitikėjimu?",
              isPositive: true),
          Question(text: "Ar manimi galima pasitikėti?"),
          Question(
              text:
              "Ar esu savo drabužių, draugų, darbo ar įpročių vergas?",
              isPositive: true),
          Question(
              text:
              "Ar esu pasipūtęs, užuojautos sau ieškantis ar pateisinu save?",
              isPositive: true),
          Question(text: "Ar šiandien Biblija gyvavo manyje?"),
          Question(
              text: "Ar kasdien skiriu laiko bendrauti su Biblija?"),
          Question(text: "Ar mėgaujuosi malda?"),
          Question(
              text:
              "Kada paskutinį kartą kalbėjau su kažkuo apie savo tikėjimą?"),
          Question(text: "Ar meldžiuosi dėl pinigų, kuriuos išleidžiu?"),
          Question(
              text: "Ar einu miegoti laiku ir keliuosi laiku?"),
          Question(text: "Ar priešinuosi Dievui kokiu nors klausimu?",
              isPositive: true),
          Question(
              text:
              "Ar atkakliai darau tai, kas trikdo mano sąžinę?",
              isPositive: true),
          Question(text: "Ar esu silpnas kuriame nors gyvenimo aspekte?",
              isPositive: true),
          Question(
              text:
              "Ar esu pavydus, netyras, kritiškas, įniršęs, jautrus ar nepasitikintis?",
              isPositive: true),
          Question(text: "Kaip leidžiu savo laisvalaikį?",
              isPositive: true),
          Question(text: "Ar esu išdidus?",
              isPositive: true),
          Question(
              text:
              "Ar dėkoju Dievui, kad nesu kaip kiti žmonės, ypač kaip fariziejai, kurie niekino muitininką?",
              isPositive: true),
          Question(
              text:
              "Ar yra kas nors, ko bijau, nepakenčiu, atstumiu, kritikuoju, nekenčiu ar ignoruoju? Jei taip, ką dėl to darau?",
              isPositive: true),
          Question(text: "Ar nuolat murmėju ar skundžiuosi?",
              isPositive: true),
          Question(text: "Ar Kristus man yra tikras?")
        ],
      ),


    };
    return _questionMap;
  }
}
