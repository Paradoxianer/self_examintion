import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

/// The translations for Spanish (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override String get greetings => 'Bienvenido a la Herramienta de Autoevaluación';
  @override String get start => 'Comenzar';
  @override String get results => 'Resultados';
  @override String get settings => 'Configuraciones';
  @override String get examinTitle => 'Autoevaluación';
  @override String get noteHint => 'Agregar notas...';
  @override String get pleasAnswer => 'Por favor, responda todas las preguntas.';
  @override String get commit => 'Finalizar';
  @override String get saved => 'Datos guardados';
  @override String get chartTitle => 'Gráfico de Desarrollo';
  @override String get noHistory => 'No se encontraron datos. Por favor, responda las preguntas.';
  @override String get warningTitle => 'Advertencia';
  @override String warningDel(String autor, Object author) => 'Todo el progreso para $autor se eliminará. ¿Desea continuar?';
  @override String get settingsTitle => 'Configuraciones';
  @override String get chooseQuestionSet => 'Elegir conjunto de preguntas';
  @override String get delete => 'Eliminar datos';
  @override String get notification => 'Recordarme';
  @override String get notificationFrequency => 'Frecuencia';
  @override String get daily => 'diario';
  @override String get weekly => 'semanal';
  @override String get monthly => 'mensual';
  @override String get datasecurityDialog => 'Privacidad y RGPD';
  @override String get dsgvoNo => 'Consentimiento denegado';
  @override String get dsgvoNoInfo => 'La aplicación solo puede funcionar si acepta.';
  @override String get ok => 'Aceptar';
  @override String get cancel => 'Cancelar';
  @override String get dsgvoTitle => 'Privacidad de datos';
  @override String get dsgvo1 => 'Para seguir su desarrollo espiritual, almacenamos sus respuestas localmente en su dispositivo.';
  @override String get dsgvo2 => 'No se transmiten datos a la nube. Su privacidad queda al 100% en su teléfono.';
  @override String get dsgvo3 => 'Al hacer clic en \'Aceptar\', acepta el almacenamiento local. Sin el consentimiento, no se pueden guardar los datos del historial.';
  @override String get dsgvoOK => 'Aceptar';
  @override String get dsgvoCancel => 'Rechazar';
  @override String get dsgvoYes => 'Consentimiento dado';
  @override String get close => 'Cerrar';
  @override String get total => 'Total';
  @override String get compareChart => 'Comparación';
  @override String get timeChart => 'Línea de tiempo';
  @override String get fullDateAndTime => 'EEE, dd MMM yyyy H:mm';
  @override String get fullDate => 'dd MMM yyyy';
  @override String get shortDate => 'dd/MM/yy';
  @override String get shortTime => 'H:mm';
  @override List<String> get rating => ["Excelente", "Buen camino", "No tan bueno", "Necesita trabajo"];
  @override List<String> get answers => ["En absoluto", "Poco", "Mayormente", "Completamente"];
  @override List<String> get frequenze => ["diario", "semanal", "mensual", "anual"];

  @override String get filterQuestions => "Filtrar preguntas";
  @override String get today => "Hoy";
  @override String get noData => "No hay datos disponibles";
  @override String get radarError => "El gráfico de radar requiere al menos 3 preguntas seleccionadas.";
  @override String get prevPeriod => "Período anterior";
  @override String get currPeriod => "Período actual";
  @override String get all => "Todo";
  @override String get selectAll => "Seleccionar todo";
  @override String get selectNone => "No seleccionar ninguno";
  @override List<String> get timeRangeShort => ["2D", "1S", "1M", "1A", "Todo"];
  @override String get tips => "Consejos e información";

  @override String get settingsQuestionSetSubtitle => "Elija un conjunto para editar o eliminar datos.";
  @override String get settingsExportHeader => "Exportación de datos";
  @override String get settingsExportAll => "Exportar todo";
  @override String get settingsExportValues => "Valores y promedio";
  @override String get settingsExportAverage => "Solo promedio";
  @override String get settingsSecurityHeader => "Seguridad y privacidad";
  @override String get settingsSecurityLock => "Activar bloqueo de aplicación";
  @override String get settingsReminderHeader => "Recordatorio";
  @override String get settingsNoDataToExport => "No hay datos disponibles para exportar.";

  @override String get about => "Acerca de la aplicación";
  @override String get aboutContent => "Esta aplicación es para la reflexión personal y el crecimiento espiritual. Inspirada por William Booth y John Wesley.";
  @override String get version => "Versión";
  @override String get imprint => "Aviso legal";
  @override String get license => "Licencias";
  @override String get imprintContent => "Responsable: Matthias Lindner\nContacto: ";
  @override String get githubRepository => "Repositorio GitHub (Reportar errores y contribuir)";

  @override String get onboardingSkip => "Omitir";
  @override String get onboardingNext => "Siguiente";
  @override String get onboardingStart => "Empezar";

  @override
  String get onboarding1Title => "App de Autoevaluación";

  @override
  String get onboarding1DescriptionTop =>
      "William Booth y John Wesley se tomaban tiempo regularmente para la autoevaluación.\n"
          "¿Cómo he vivido mi fe hoy?\n"
          "¿Dónde pudo ser visible el amor de Dios a través de mí?\n"
          "¿Y dónde desea seguir cambiándome?\n\n"
          "Esta aplicación le invita a realizar precisamente esta reflexión honesta.\n"
          "Puede elegir entre diferentes conjuntos de preguntas, registrar sus respuestas\n"
          "y observar su evolución a lo largo de días, semanas, meses o años –\n"
          "en su conjunto o en áreas individuales.\n\n"
          "Como una ayuda para percibir dónde el amor de Dios le invita a seguir actuando –\n"
          "y dónde el crecimiento todavía es posible.";

  @override
  String get onboarding1DescriptionBottom =>
      "Aquí puede elegir entre diferentes conjuntos de preguntas de autoevaluación. "
          "Cada conjunto contiene diferentes preguntas con su propio enfoque. "
          "Puede obtener una visión general de todas las preguntas tocando el icono de información (i).";

  @override
  String get onboarding2Title => "Reflexionar y Anotar";

  @override
  String get onboarding2Step1Title => "Reflexionar";

  @override
  String get onboarding2Step1Description =>
      "Mueva el deslizador para evaluar por sí mismo cómo respondería a la pregunta correspondiente hoy.\n\n"
          "Si siente que su respuesta es más positiva, mueva el deslizador en la dirección verde. "
          "Si siente que es más negativa, muévalo en la dirección roja.\n\n"
          "Su calificación elegida en porcentaje se mostrará sobre el deslizador.";

  @override
  String get onboarding2Step2Title => "Notas";

  @override
  String get onboarding2Step2Description =>
      "Toque el icono de nota (hoja con más) para registrar un pensamiento, una observación "
          "o una oración. La nota se guardará junto con la pregunta y la fecha correspondiente.\n\n"
          "Toque de nuevo el icono de nota para cerrar el campo de notas.";

  @override
  String get onboarding3Title => "Análisis y Seguridad";

  @override
  String get onboarding3Step1Title => "Gráficos";

  @override
  String get onboarding3Step1Description =>
      "Después de haber respondido todas las preguntas, llegará a la vista de gráficos "
          "mediante el botón 'Finalizar'.\n\n"
          "Deslice hacia la izquierda o hacia la derecha en el área del gráfico para cambiar entre diferentes vistas. "
          "Debajo de los gráficos puede seleccionar qué preguntas deben mostrarse en la evaluación.";

  @override
  String get onboarding3Step2Title => "Privacidad";

  @override
  String get onboarding3Step2Description =>
      "Sus datos permanecen almacenados exclusivamente de forma local en su dispositivo.\n\n"
          "Opcionalmente, puede protegerlos adicionalmente con el PIN de su dispositivo o con seguridad "
          "biométrica (por ejemplo, huella dactilar o reconocimiento facial).\n\n"
          "Si es necesario, puede exportar sus datos con diferentes niveles de detalle como un archivo CSV "
          "y, por ejemplo, analizarlos más a fondo en Excel.";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Diez Mandamientos",
        description:
        "Un conjunto de preguntas desarrollado por el Ejército de Salvación de Chemnitz como parte de una serie de sermones sobre los Diez Mandamientos.",
        questions: [
          Question(
            text: "¿Hasta qué punto he evitado poner otras cosas o asuntos por delante del único Dios verdadero?",
            description: "¡No tendrás otros dioses delante de mí! (Éxodo 20, 1–6)",
          ),
          Question(
            text: "¿Con qué frecuencia he evitado hacerme una imagen de Dios?",
            description: "¡No te harás imagen! (Éxodo 20, 4)",
          ),
          Question(
            text: "¿Cuánto he evitado usar el nombre de Dios sin reflexionar?",
            description: "¡No tomarás el nombre del SEÑOR tu Dios en vano! (Éxodo 20, 7)",
          ),
          Question(
            text: "¿Me tomo conscientemente un tiempo de descanso para honrar a Dios?",
            description: "¡Mas el séptimo día es reposo para el SEÑOR tu Dios! (Éxodo 20, 8–11)",
          ),
          Question(
            text: "¿En qué medida honro a mis padres y les muestro respeto?",
            description: "¡Honra a tu padre y a tu madre! (Éxodo 20, 12)",
          ),
          Question(
            text: "¿Con qué frecuencia evito dañar a otras personas con mis pensamientos, palabras o incluso acciones?",
            description: "¡No matarás! (Éxodo 20, 13)",
          ),
          Question(
            text: "¿Hasta qué punto me mantengo alejado del adulterio y mantengo el matrimonio sagrado?",
            description: "¡No cometerás adulterio! (Éxodo 20, 14)",
          ),
          Question(
            text: "¿Con qué fiabilidad evito tocar la propiedad ajena y practico la honestidad?",
            description: "¡No robarás! (Éxodo 20, 15)",
          ),
          Question(
            text: "¿En qué medida evito difundir falsedades sobre otras personas o chismear?",
            description: "¡No hablarás contra tu prójimo falso testimonio! (Éxodo 20, 16)",
          ),
          Question(
            text: "¿Cuánto evito tener envidia de lo que pertenece a otras personas o de cómo viven otras personas?",
            description: "¡No codiciarás la casa de tu prójimo! (Éxodo 20, 17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description:
        "Preguntas de autoevaluación que William Booth se hacía a sí mismo cada noche.",
        questions: [
          Question(
            text: "¿Soy culpable de algún pecado habitual? ¿Peco deliberadamente o por negligencia en pensamientos, palabras o acciones, sabiendo bien que estoy haciendo algo malo?",
            isPositive: true,
          ),
          Question(
            text: "¿Tengo mis deseos físicos bajo control de modo que no me siento culpable? ¿Doy rienda suelta a alguna inclinación que afecte mi santificación, mi crecimiento en el conocimiento, mi obediencia y mi utilidad?",
          ),
          Question(
            text: "¿Son todos mis pensamientos y sentimientos de tal naturaleza que no tenga que avergonzarme si fueran revelados ante Dios?",
          ),
          Question(
            text: "¿Me lleva la influencia del mundo a hacer o decir cosas que no son propias de un seguidor de Cristo?",
            isPositive: true,
          ),
          Question(
            text: "¿Me lleva mi carácter a sentir, hacer o decir algo que después me doy cuenta de que es contrario al amor que siempre debería tener por mi prójimo?",
            isPositive: true,
          ),
          Question(
            text: "¿Hago todo lo que está a mi alcance para que los pecadores se salven? ¿Me importa que estén en peligro? ¿Rezo por ellos, lucho por su salvación como si fueran mis propios hijos?",
          ),
          Question(
            text: "¿Cumplo mis votos que hice ante Dios en un acto de entrega o en el banco de penitencia?",
          ),
          Question(
            text: "¿Es mi ejemplo armonioso con mi palabra?",
          ),
          Question(
            text: "¿Soy orgulloso o arrogante en mi naturaleza y comportamiento?",
            isPositive: true,
          ),
          Question(
            text: "¿Me ajusto a las costumbres y modas del mundo o tengo el valor de ir contra la corriente?",
            isPositive: true,
          ),
          Question(
            text: "¿Estoy en peligro de dejarme llevar por el deseo mundano de ser rico o admirado?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description:
        "Las 22 preguntas de John Wesley que se hacía a sí mismo para la autoevaluación cada día:",
        questions: [
          Question(
            text: "¿Doy, consciente o inconscientemente, la impresión de que soy mejor de lo que soy en realidad? En otras palabras, ¿soy un hipócrita?",
            isPositive: true,
          ),
          Question(
            text: "¿Soy honesto en todas mis acciones y palabras o exagero?",
            isPositive: true,
          ),
          Question(
            text: "¿Transmito confidencialmente a otros lo que me han dicho en confianza?",
            isPositive: true,
          ),
          Question(
            text: "¿Soy digno de confianza?",
          ),
          Question(
            text: "¿Soy esclavo de mi ropa, amigos, trabajo o hábitos?",
          ),
          Question(
            text: "¿Me siento inseguro, lleno de autocompasión o santurrón?",
            isPositive: true,
          ),
          Question(
            text: "¿Vive la Biblia en mí hoy?",
          ),
          Question(
            text: "¿Le doy tiempo a la Biblia cada día para que me hable?",
          ),
          Question(
            text: "¿Disfruto de la oración?",
          ),
          Question(
            text: "¿Cuándo fue la última vez que hablé con alguien sobre mi fe?",
          ),
          Question(
            text: "¿Rezo por el dinero que gasto?",
          ),
          Question(
            text: "¿Me acuesto a tiempo y me levanto a tiempo?",
          ),
          Question(
            text: "¿Soy desobediente a Dios en algo?",
            isPositive: true,
          ),
          Question(
            text: "¿Insisto en hacer algo que inquieta mi conciencia?",
            isPositive: true,
          ),
          Question(
            text: "¿He sido derrotado en alguna parte de mi vida?",
            isPositive: true,
          ),
          Question(
            text: "¿Soy celoso, impuro, crítico, irritable, sensible o desconfiado?",
            isPositive: true,
          ),
          Question(
            text: "¿Cómo paso mi tiempo libre?",
          ),
          Question(
            text: "¿Soy orgulloso?",
            isPositive: true,
          ),
          Question(
            text: "¿Doy gracias a Dios porque no soy como los demás, especialmente como los fariseos que despreciaban al publicano?",
            isPositive: true,
          ),
          Question(
            text: "¿Hay alguien a quien tema, que me caiga mal, con quien no quiera tener nada que ver, a quien critique, contra quien guarde rencor o a quien ignore? Si es así, ¿qué estoy haciendo al respecto?",
            isPositive: true,
          ),
          Question(
            text: "¿Guardo rencor contra alguien?",
            isPositive: true,
          ),
          Question(
            text: "¿Me quejo o me lamento constantemente?",
            isPositive: true,
          ),
          Question(
            text: "¿Es Cristo real para mí?",
          ),
        ],
      ),
    };
  }
}
