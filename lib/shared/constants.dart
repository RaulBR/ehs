import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: AppColors.field,
  filled: true,
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.textSecundart, width: 1)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.accent, width: 2)),
);
const searchTextDecorator = InputDecoration(
  fillColor: AppColors.field,
  filled: true,
  labelText: Labels.area,
  suffixIcon: Icon(Icons.search),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.textSecundart, width: 1)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.accent, width: 2)),
);

const textAreaStyle = InputDecoration(
  fillColor: AppColors.field,
  filled: true,
);

const labelFomat = TextStyle(fontSize: 12, color: AppColors.textSecundart);
const normallabelFomat = TextStyle(
    fontSize: 17,
    color: AppColors.textSecundart,
    fontWeight: FontWeight.normal);
const textFomat = TextStyle(fontSize: 17, color: AppColors.textPrimery);

const auditList = EdgeInsets.fromLTRB(12, 10, 12, 0);
const labelPadding = EdgeInsets.only(left: 10, right: 10, top: 10);

@immutable
class Labels {
  static const String ok = 'ok';
  static const String ehsTitle = 'EHS Focus';
  static const String safty = 'Audit EHS';
  static const String enviroment = 'Audit de Mediu';
  static const String helth = 'Audit de Sanatatea Muncii';
  static const String incident = 'Incident';
  static const String areaId = 'Identificare';
  static const String qrScannerMesasge = 'Utilizaa scanare QR sau alege zona';
  static const String positiveAcctionMessage = 'Aspecte pozitive';
  static const String negativeAcctionMessage = 'Aspecte Negative';
  static const String insertPositive = 'Introduceti o observatie pozitiva';
  static const String insertNegative = 'Introduceti o observatie negative';
  static const String corectiveAcction = 'Actiune corectiva';
  static const String insertcorectiveAcction =
      'Introduce-ti o Actiune ccorectiva';
  static const String setResposible = 'Seteaza responsabili';
  static const String responsibal = 'Responsabil';
  static const String area1 = 'Zona';
  static const String area2 = 'Echipamente din zona';
  static const String scanButton = 'QR scan';
  static const String pictureButton = 'Adauga poza';
  static const String category = 'Categorie';
  static const String admin = 'Administartatie';
  static const String addAudit = "Audit";
  static const String email = 'Email';
  static const String responsabile = 'Responsibil';
  static const String passwoard = 'Password';
  static const String add = 'Adauga';
  static const String save = 'Salveaza';
  static const String incidentDocumentation = 'Documenteaza incident';
  static const String selectGravitty = 'Selecteaza Gravitatea';
  static const String imidiateActtion = 'Actiune Imediata?';
  static const String galery = 'Galerie';
  static const String camera = 'Camera';
  static const String addAnother = 'Mai adauga';
  static const String back = 'Inapoi';
  static const String chose = 'Alege:';
  static const String addAspect = 'nici un aspect';
  static const String limitDate = 'Data limita';
  static const String addComment = 'Adauga Comentariu';
  static const String comment = 'Comentariu';
  static const String scan = 'Scaneaza';
  static const String addCorectiveAcction = 'Adauga actiune corectiva';
  static const String goTocorectiveAcction = 'Actiunea corectiva';
  static const String backToAspects = 'Inapoi la aspecte';
  static const String aspects = 'aspecte';
  static const String aspect = 'un aspect';
  static const String delete = 'Sterge';
  static const String send = 'Trimite';
  static const String audits = "Auditele mele";
  static const String mainPage = 'Pagina Principala';
  static const String settings = 'Setari';
  static const String statistics = 'Statistici';
  static const String aspectType = 'Tip audit';
  static const String myData = 'Contul Meu';
  static const String noData = 'Nu sunt date';
  static const String close = 'Inchide';
  static const String area = 'Area';
  static const String clear = 'Sterge';
  static const String addCategory = 'Adauga Categorie';
  static const String areYouShoure = 'Esti sigur?';
  static const String areYouShoureText = 'Va fi sterge definitiv!';
  static const String employees = 'Auditori';
  static const String name = 'Prenume';
  static const String surName = 'Nume';
  static const String role = 'Departament';
  static const String logout = 'Log out';
  static const String search = 'Cauta';
  static const String signIn = 'Sign in';
  static const String signup = 'Sign up';
  static const String auditTitle = 'Audituri';
  static const String aspectsResponsiBilittyTitle = 'Aspecte de rezolvat';
  static const String doneBy = 'Facut de:';
  static const String responsible = 'Responsabil:';
  static const String rejected = 'Respins';
  static const String acceped = 'Acceptat';
  static const String modify = 'Modifica';
  static const String aspectTitle = 'Aspect';
  static const String ditail = 'Detalii';
  static const String notAdded = 'NU A FOST ADAUGAT';
  static const String unKnown = 'Necunosct';
  static const String notSet = 'Nu s-a setat';
  static const String observation = 'Observatii: ';
  static const String acction = 'Actiuni: ';
  static const String duplicat = 'Duplicat?';
  static const String edit = 'Editeaza';
  static const String typeManager = 'Responsabil pe Tip';
  static const String managerMantanence = 'Manageri';
  static const String manager = 'Manager';
  static const String managerAuditis = 'Administrare audituri';
  static const String refresh = 'Reincarca datele';
  static const String next = 'urmatorul';
}

class HiveName {
  static const String mySelf = 'mySelf';
  static const String employees = 'employees';
  static const String categoryType = 'categoryType';
  static const String categoryTypeSelected = 'categoryTypeSelected';
  static const String area = 'area';
  static const String selectedArea = 'selectedArea';
  static const String aspect = 'aspect';
  static const String aspectAdd = 'aspectAdd';
  static const String aspectUpdate = 'aspectUpdate';
  static const String aspectDelete = 'aspectDelete';
  static const String audit = 'audit';
  List<String> toListElements() {
    return [
      mySelf,
      employees,
      categoryType,
      categoryTypeSelected,
      area,
      selectedArea,
      aspect,
      aspectAdd,
      aspectUpdate,
      aspectDelete,
      audit
    ];
  }
}

class Errors {
  static const String getError = 'get error';
  static const String setError = 'set error';
  static const String deleteError = 'delete error';
}

Map<String, String> dinamicTitles = {
  'ok': 'ok',
  'ehsTitle': Labels.ehsTitle,
  'safty': Labels.safty,
  'enviroment': Labels.enviroment,
  'helth': Labels.helth,
  'incident': Labels.incident,
  'areaId': Labels.areaId,
  'qrScannerMesasge': Labels.qrScannerMesasge,
  'positiveAcctionMessage': Labels.positiveAcctionMessage,
  'negativeAcctionMessage': Labels.negativeAcctionMessage,
  'insertPositive': Labels.insertPositive,
  'insertNegative': Labels.insertNegative,
  'corectiveAcction': Labels.corectiveAcction,
  'insertcorectiveAcction': Labels.insertcorectiveAcction,
  'responsibal': Labels.responsibal,
  'area1': Labels.area1,
  'area2': Labels.area2,
  'scanButton': Labels.scanButton,
  'pictureButton': Labels.pictureButton,
  'category': Labels.category,
  'addAudit': Labels.addAudit,
  'email': Labels.email,
  'resable': Labels.responsabile,
  'passwoard': Labels.passwoard,
  'audits': Labels.audits,
  'add': Labels.add,
};

@immutable
class RoutPath {
  static const homeRout = '/';
  static const loadingRout = '/loading';
  static const safetyRout = '/ehs';
  static const employeeRout = '/employee';
  static const meRout = '/me';
  static const statsRout = '/stats';
  static const helthRout = '/sanatate';
  static const enviromentRout = '/mediu';
  static const incidentRout = '/incident';
  static const auditsRoute = '/audits';
  static const categoryRoute = '/category';
  static const adminRoute = '/admin';
  static const areaRoute = '/area';
  static const login = '/login';
  static const signup = '/signup';
  static const loading = '/loading';
  static const overwiewAudits = '/overwiewAudits';
  static const myResponsibility = '/myResponsibility';
  static const myRejectedAspects = '/myRejected';
  static const myAudits = '/myAudits';
  static const myManaagers = '/myManaagers';
  static const managerAuditis = '/managerAuditis';
}

class CurrentPath {
  get() => {
        'homeRout': RoutPath.homeRout,
        'loadingRout': RoutPath.loadingRout,
        'safty': RoutPath.safetyRout,
        'employee': RoutPath.employeeRout,
        'statsRout': RoutPath.statsRout,
        'helth': RoutPath.helthRout,
        'enviroment': RoutPath.enviromentRout,
        'incident': RoutPath.incidentRout,
        'audits': RoutPath.auditsRoute,
        'myAudits': RoutPath.myAudits
      };
  routPathList() => {
        'homeRout': '/',
        'loadingRout': '/loading',
        'safty': '/safery',
        'employeeRout': '/employee',
        'statsRout': '/stats',
        'helthRout': '/sanatate',
        'helth': '/audit'
      };
}

class PageTitles {
  String ok = 'ok';
}

// enum FooterStates { delete, save, send }
enum PopupStates { ok, cancel }

// Map<FooterStates, String> footerLagels = {
//   FooterStates.delete: Labels.delete,
//   FooterStates.save: Labels.save,
//   FooterStates.send: Labels.send,
// };
