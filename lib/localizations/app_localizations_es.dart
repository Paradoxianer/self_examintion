import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

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
  @override String get noHistory => 'No se encontraron datos. Elija un conjunto de preguntas diferente o responda las preguntas.';
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
  @override String get datasecurityDialog => 'Diálogo de protección de datos';
  @override String get dsgvoNo => 'Consentimiento denegado';
  @override String get dsgvoNoInfo => 'La aplicación solo puede funcionar si acepta.';
  @override String get ok => 'Aceptar';
  @override String get cancel => 'Cancelar';
  @override String get dsgvoTitle => 'Privacidad de datos y consentimiento';
  @override String get dsgvo1 => 'Para realizar un seguimiento de su desarrollo espiritual personal, almacenamos sus respuestas localmente.';
  @override String get dsgvo2 => 'Tenga en cuenta que las personas que tienen acceso a su dispositivo pueden tener acceso a estos datos.';
  @override String get dsgvo3 => 'Al hacer clic en \'Aceptar\', acepta que se almacenen sus datos.';
  @override String get dsgvoOK => 'Aceptar';
  @override String get dsgvoCancel => 'Objetar';
  @override String get dsgvoYes => 'Consentimiento dado';
  @override String get close => 'Cerrar';
  @override String get total => 'Total';
  @override String get compareChart => 'Comparación';
  @override String get timeChart => 'Tiempo';
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
  @override List<String> get timeRangeShort => ["2D", "1S", "1M", "1A", "Todo"];

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Ejército de Salvación Chemnitz",
        description: "Preguntas de autoevaluación basadas en los Diez Mandamientos.",
        questions: [
          Question(text: "¿Evito poner otras cosas junto al único Dios verdadero?"),
          Question(text: "¿Me abstengo de hacer o worshiping una imagen de Dios?"),
          Question(text: "¿Cuánto he evitado usar el nombre del Señor sin pensar?"),
          Question(text: "¿Me tomo un día libre cada seis días para honrar a Dios?"),
          Question(text: "¿Hasta qué punto honro a mis padres?"),
          Question(text: "¿Evito hacer daño a los demás?"),
          Question(text: "¿Me alejo del adulterio?"),
          Question(text: "¿Practico la honestidad?"),
          Question(text: "¿Evito difundir información falsa?"),
          Question(text: "¿Evito sentir envidia?"),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Preguntas de autonegación de William Booth",
        questions: [
          Question(text: "¿Soy habitualmente culpable de algún pecado?", isPositive: true),
          Question(text: "¿Soy el amo de mis apetitos corporales?"),
          Question(text: "¿Son mis pensamientos limpios ante Dios?"),
          Question(text: "¿Me hace el mundo hacer cosas diferentes a las de Cristo?", isPositive: true),
          Question(text: "¿Mis malhumores me hacen actuar contra el amor?", isPositive: true),
          Question(text: "¿Hago todo por la salvación de los pecadores?"),
          Question(text: "¿Cumplo mis votos a Dios?"),
          Question(text: "¿Es mi ejemplo armonioso con mi fe?"),
          Question(text: "¿Soy consciente de orgullo?", isPositive: true),
          Question(text: "¿Tengo el valor de ir contra la corriente?"),
          Question(text: "¿Deseo ser rico?", isPositive: true),
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "22 preguntas diarias de John Wesley:",
        questions: [
          Question(text: "¿Soy un hipócrita?", isPositive: true),
          Question(text: "¿Soy honesto o exagero?", isPositive: true),
          Question(text: "¿Paso información confidencial?", isPositive: true),
          Question(text: "¿Puedo confiar en mí?"),
          Question(text: "¿Soy esclavo de mis hábitos?", isPositive: true),
          Question(text: "¿Soy autocompasivo?", isPositive: true),
          Question(text: "¿Vivió la Biblia en mí hoy?"),
          Question(text: "¿Le doy tiempo a la Biblia cada día?"),
          Question(text: "¿Disfruto de la oración?"),
          Question(text: "¿Hablé hoy de mi fe?"),
          Question(text: "¿Rezo por el dinero que gasto?"),
          Question(text: "¿Duermo y me levanto a tiempo?"),
          Question(text: "¿Desobedezco a Dios en algo?", isPositive: true),
          Question(text: "¿Hago algo que molesta mi conciencia?", isPositive: true),
          Question(text: "¿Me siento derrotado?", isPositive: true),
          Question(text: "¿Soy celoso o irritable?", isPositive: true),
          Question(text: "¿Cómo paso mi tiempo libre?", isPositive: true),
          Question(text: "¿Soy orgulloso?", isPositive: true),
          Question(text: "¿Agradezco a Dios no ser como otros?", isPositive: true),
          Question(text: "¿Guardo rencor?", isPositive: true),
          Question(text: "¿Me quejo constantemente?", isPositive: true),
          Question(text: "¿Es Cristo real para mí?"),
        ],
      ),
    };
  }
}
