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

  @override
  String get total => 'Total';

  @override
  String get compareChart => 'Gráfico de comparación';

  @override
  String get timeChart => 'Gráfico de tiempo';

  @override
  String get reminderTitle => 'Preguntas de Autoevaluación';

  @override
  String get reminderBody => '¡Hola! Es hora de tu autorreflexión regular';


  List<String> get rating => ["Excelente", "Buen camino", "No tan bueno", "Necesita trabajo"];

  List<String> get answers => ["En absoluto", "Poco", "Mayormente", "Completamente"];

  List<String> get frequenze => ["diario", "semanal", "mensual", "anual"];

  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "Ejército de Salvación Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Ejército de Salvación Chemnitz",
        description: "Preguntas de autoevaluación desarrolladas por el Ejército de Salvación Chemnitz basadas en los Diez Mandamientos.",
        questions: [
          Question(
              text: "¿Hasta qué punto evito poner otras cosas junto al único Dios verdadero?",
              description: "No tendrás otros dioses delante de mí. (Éxodo 20:2-6)"
          ),
          Question(
              text: "¿Con qué consistencia me abstengo de hacer o adorar una imagen de Dios?",
              description: "No te harás imagen, ni ninguna semejanza de lo que esté arriba en el cielo, ni abajo en la tierra, ni en las aguas debajo de la tierra. (Éxodo 20:4)"
          ),
          Question(
              text: "¿Cuánto he evitado usar el nombre del SEÑOR, mi Dios, sin pensar?",
              description: "No tomarás el nombre del SEÑOR tu Dios en vano, porque el SEÑOR no tendrá por inocente al que tome su nombre en vano. (Éxodo 20:7)"
          ),
          Question(
              text: "¿Me tomo un día libre cada seis días para honrar a Dios?",
              description: "Acuérdate del día de reposo para santificarlo. (Éxodo 20:8-11)"
          ),
          Question(
              text: "¿Hasta qué punto honro a mis padres y les muestro respeto?",
              description: "Honra a tu padre y a tu madre, para que tus días se alarguen en la tierra que el SEÑOR tu Dios te da. (Éxodo 20:12)"
          ),
          Question(
              text: "¿Con qué consistencia evito hacer daño a los demás en pensamientos, palabras o acciones?",
              description: "No matarás. (Éxodo 20:13)"
          ),
          Question(
              text: "¿Hasta qué punto me alejo del adulterio y preservo el matrimonio como una institución sagrada?",
              description: "No cometerás adulterio. (Éxodo 20:14)"
          ),
          Question(
              text: "¿Con qué fiabilidad me abstengo de tomar lo que no me pertenece y practico la honestidad?",
              description: "No hurtarás. (Éxodo 20:15)"
          ),
          Question(
              text: "¿Hasta qué punto evito difundir información falsa o chismes sobre los demás?",
              description: "No darás falso testimonio contra tu prójimo. (Éxodo 20:16)"
          ),
          Question(
              text: "¿Cuánto evito sentir envidia de lo que pertenece a los demás o de cómo viven los demás?",
              description: "No codiciarás la casa de tu prójimo, no codiciarás la mujer de tu prójimo, ni su siervo, ni su criada, ni su buey, ni su asno, ni cosa alguna de tu prójimo. (Éxodo 20:17)"
          ),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Preguntas de autonegación de William Booth",
        questions: [
          Question(
              text:
              "¿Soy habitualmente culpable de algún pecado conocido? ¿Practico o permito algún pensamiento, palabra o acción que sé que está mal?",
              isPositive: true),
          Question(
              text:
              "¿Soy el amo de mis apetitos corporales hasta el punto de no tener condena? ¿Me permito alguna indulgencia que sea perjudicial para mi santidad, crecimiento en conocimiento, obediencia o utilidad?"),
          Question(
              text:
              "¿Son mis pensamientos y sentimientos de tal manera que no debería avergonzarme de escucharlos publicados ante Dios?"),
          Question(
              text:
              "¿La influencia del mundo me hace hacer o decir cosas que son diferentes a las de Cristo?",
              isPositive: true),
          Question(
              text:
              "¿Mis malhumores me hacen actuar, o sentir, o decir cosas que veo después que son contrarias al amor que debería [mostrar] siempre a quienes me rodean?",
              isPositive: true),
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
              isPositive: true),
          Question(
              text:
              "¿Me conformo con las modas y costumbres del mundo, o demuestro que las desprecio?"),
          Question(
              text:
              "¿Estoy en peligro de dejarme llevar por el deseo mundano de ser rico o admirado?",
              isPositive: true),
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
