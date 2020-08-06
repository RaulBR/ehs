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

const textAreaStyle = InputDecoration(
  fillColor: AppColors.field,
  filled: true,
  // enabledBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(color: AppColors.field, width: 1)),
  // focusedBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(color:AppColors.field, width: 2)),
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
  static String ok = 'ok';
  static String ehsTitle = 'EHS Focus';
  static String safty = 'Audit EHS';
  static String enviroment = 'Audit de Mediu';
  static String helth = 'Audit de Sanatatea Muncii';
  static String incident = 'Incident';
  static String areaId = 'Identifica Zona';
  static String qrScannerMesasge = 'Utilizaa scanare QR sau alege zona';
  static String positiveAcctionMessage = 'Aspecte pozitive';
  static String negativeAcctionMessage = 'Aspecte Negative';
  static String insertPositive = 'Introduceti o observatie pozitiva';
  static String insertNegative = 'Introduceti o observatie negative';
  static String corectiveAcction = 'Actiune corectiva';
  static String insertcorectiveAcction = 'Introduce-ti o Actiune ccorectiva';
  static String responsibal = 'Responsabil';
  static String area1 = 'Zona';
  static String area2 = 'Pas proces';
  static String scanButton = 'QR scan';
  static String pictureButton = 'Adauga poza';
  static String category = 'Categorie';
  static String addAudit = "Audit";
  static String email = 'Email';
  static String responsabile = 'Responsibil';
  static String passwoard = 'Password';
  static String add = 'Adauga';
  static String save = 'Salveaza';
  static String incidentDocumentation = 'Documenteaza incident';
  static String selectGravitty = 'Selecteaza Gravitatea';
  static String imidiateActtion = 'Actiune Imediata?';
  static String galery = 'Galerie';
  static String camera = 'Camera';
  static String addAnother = 'Mai adauga';
  static String back = 'Inapoi';
  static String chose = 'Alege:';
  static String addAspect = 'nici un aspect';
  static String limitDate = 'Data limita';
  static String addComment = 'Adauga Comentariu';
  static String comment = 'Comentariu';
  static String scan = 'Scaneaza';
  static String addCorectiveAcction = 'Adauga Actiune corectiva';
  static String goTocorectiveAcction = 'Actiunea corectiva';
  static String backToAspects = 'Inapoi la aspecte';
  static String aspects = 'aspecte';
  static String aspect = 'un aspect';
  static String delete = 'Sterge';
  static String send = 'Trimite';
  static String audits = "Auditele mele";
  static String mainPage = 'Pagina Principala';
  static String settings = 'Setari';
  static String statistics = 'Statistici';
  static String aspectType = 'Tip audit';
  static String myData = 'Contul Meu';
  static String noData = 'Nu sunt date';
  static String close = 'Inchide';
  static String area = 'Area';
  static String clear = 'Sterge';
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
  static const statsRout = '/stats';
  static const helthRout = '/sanatate';
  static const enviromentRout = '/mediu';
  static const incidentRout = '/incident';
  static const auditsRoute = '/audits';
  static const categoryRoute = '/category';
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
        'audits': RoutPath.auditsRoute
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

enum FooterStates { delete, save, send }

Map<FooterStates, String> footerLagels = {
  FooterStates.delete: Labels.delete,
  FooterStates.save: Labels.save,
  FooterStates.send: Labels.send,
};
