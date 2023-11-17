import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/models/question.dart';

import 'app_localizations.dart';

class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get greetings => 'Bienvenido a la Herramienta de Autoevaluación';

  @override
  String get start => 'Comenzar';

  @override
  String get results => 'Resultados';

  @override
  String get settings => 'Configuraciones';

  @override
  String get examinTitle => 'Autoevaluación';

  @override
  String get noteHint => 'Agregar notas...';

  @override
  String get pleasAnswer => 'Por favor, responda todas las preguntas.';

  @override
  String get commit => 'Finalizar';

  @override
  String get saved => 'Datos guardados';

  @override
  String get chartTitle => 'Gráfico de Desarrollo';

  @override
  String get noHistory =>
      'No se encontraron datos de las preguntas de autoevaluación anteriores. Elija un conjunto de preguntas diferente o responda las preguntas.';

  @override
  String get warningTitle => 'Advertencia';

  @override
  String warningDel(String autor, Object author) {
    return 'Todo el progreso guardado para $author se eliminará y se perderá para siempre. ¿Desea continuar?';
  }

  @override
  String get settingsTitle => 'Configuraciones';

  @override
  String get chooseQuestionSet => 'Elegir conjunto de preguntas';

  @override
  String get delete => 'Eliminar datos';

  @override
  String get notification => 'Recordarme';

  @override
  String get notificationFrequency => 'Frecuencia';

  @override
  String get daily => 'diario';

  @override
  String get weekly => 'semanal';

  @override
  String get monthly => 'mensual';

  @override
  String get datasecurityDialog => 'Diálogo de protección de datos';

  @override
  String get dsgvoNo => 'Consentimiento denegado';

  @override
  String get dsgvoNoInfo => 'La aplicación solo puede funcionar si acepta.';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get dsgvoTitle => 'Privacidad de datos y consentimiento';

  @override
  String get dsgvo1 =>
      'Para realizar un seguimiento de su desarrollo espiritual personal, almacenamos sus respuestas a las preguntas formuladas. Estos datos se anonimizan y se almacenan localmente en su dispositivo.';

  @override
  String get dsgvo2 =>
      'Tenga en cuenta que las personas que tienen acceso a su dispositivo y la aplicación pueden tener acceso a estos datos.';

  @override
  String get dsgvo3 =>
      'Al hacer clic en \'Aceptar\' a continuación, acepta que se almacenen sus datos como se describe anteriormente. Si no está de acuerdo, no se recopilarán datos, pero la aplicación tampoco funcionará.';

  @override
  String get dsgvoOK => 'Aceptar';

  @override
  String get dsgvoCancel => 'Objetar';

  @override
  String get dsgvoYes => 'Consentimiento dado';

  @override
  String get close => 'Cerrar';

  List<String> get answers => ["En absoluto", "Poco", "Mayormente", "Completamente"];

  List<String> get frequenze => ["diario", "semanal", "mensual", "anual"];

  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Preguntas de autonegación de William Booth",
        questions: [
          Question(
              text:
              "¿Soy habitualmente culpable de algún pecado conocido? ¿Practico o permito algún pensamiento, palabra o acción que sé que está mal?",
              isNegative: true),
          Question(
              text:
              "¿Soy el amo de mis apetitos corporales hasta el punto de no tener condena? ¿Me permito alguna indulgencia que sea perjudicial para mi santidad, crecimiento en conocimiento, obediencia o utilidad?"),
          Question(
              text:
              "¿Son mis pensamientos y sentimientos de tal manera que no debería avergonzarme de escucharlos publicados ante Dios?"),
          Question(
              text:
              "¿La influencia del mundo me hace hacer o decir cosas que son diferentes a las de Cristo?",
              isNegative: true),
          Question(
              text:
              "¿Mis malhumores me hacen actuar, o sentir, o decir cosas que veo después que son contrarias al amor que debería [mostrar] siempre a quienes me rodean?",
              isNegative: true),
          Question(
              text:
              "¿Estoy haciendo todo en mi poder por la salvación de los pecadores? ¿Siento preocupación por su peligro y rezo y trabajo por su salvación como si fueran mis hijos?"),
          Question(
              text:
              "¿Estoy cumpliendo los votos que he hecho a Dios en mis actos de consagración o en el banco de penitentes?"),
          Question(
            text: "¿Es mi ejemplo armonioso con mi profesión?",
          ),
          Question(
              text:
              "¿Soy consciente de algún orgullo o altivez en mi manera de ser o de comportarme?",
              isNegative: true),
          Question(
              text:
              "¿Me conformo con las modas y costumbres del mundo, o demuestro que las desprecio?"),
          Question(
              text:
              "¿Estoy en peligro de dejarme llevar por el deseo mundano de ser rico o admirado?",
              isNegative: true),
          // Weitere Fragen von William Booth hier hinzufügen
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "John Wesley se autoexaminaba rigurosamente todos los días haciendo las siguientes 22 preguntas:",
        questions: [
          Question(
              text:
              "¿Estoy creando consciente o inconscientemente la impresión de que soy mejor de lo que realmente soy? En otras palabras, ¿soy un hipócrita?"),
          Question(
              text:
              "¿Soy honesto en todos mis actos y palabras, o exagero?"),
          Question(
              text:
              "¿Paso confidencialmente a otros lo que se me ha dicho en confianza?"),
          Question(text: "¿Puedo confiar en mí?"),
          Question(text: "¿Soy esclavo del vestir, amigos, trabajo o hábitos?"),
          Question(
              text: "¿Soy autoconsciente, autocompasivo o autojustificativo?"),
          Question(text: "¿Vivió la Biblia en mí hoy?"),
          Question(text: "¿Le doy tiempo a la Biblia para que me hable todos los días?"),
          Question(text: "¿Disfruto de la oración?"),
          Question(text: "¿Cuándo fue la última vez que hablé a alguien más acerca de mi fe?"),
          Question(text: "¿Rezo por el dinero que gasto?"),
          Question(text: "¿Me acuesto a tiempo y me levanto a tiempo?"),
          Question(text: "¿Desobedezco a Dios en algo?"),
          Question(
              text:
              "¿Insisto en hacer algo sobre lo que mi conciencia está inquieta?"),
          Question(text: "¿Soy derrotado en alguna parte de mi vida?"),
          Question(
              text:
              "¿Soy celoso, impuro, crítico, irritable, quisquilloso o desconfiado?"),
          Question(text: "¿Cómo paso mi tiempo libre?"),
          Question(text: "¿Soy orgulloso?"),
          Question(
              text:
              "¿Agradezco a Dios que no soy como otras personas, especialmente como los fariseos que despreciaban al publicano?"),
          Question(
              text:
              "¿Hay alguien a quien tema, no me guste, reniegue, critique, guarde rencor o desconsidere? Si es así, ¿qué estoy haciendo al respecto?"),
          Question(text: "¿Me quejo constantemente?"),
          Question(text: "¿Cristo es real para mí?")
        ],
      )
    };
    return _questionMap;
  }
}
