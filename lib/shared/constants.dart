import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: AppColors.field,
  filled: true,
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.field, width: 2)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.accent, width: 2)),
);

const labelFomat = TextStyle(fontSize: 12, color: AppColors.textSecundart);

const auditList = EdgeInsets.fromLTRB(12, 10, 12, 0);
const labelPadding = EdgeInsets.only(left: 10, right: 10, top: 10);

@immutable
class Lables {
  static String ok = 'ok';
  static String ehsTitle = 'EHS Focus';
  static String safty = 'Audit de Siguranta Muncii';
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
}

Map<String, String> dinamicTitles = {
  'ok': 'ok',
  'ehsTitle': Lables.ehsTitle,
  'safty': Lables.safty,
  'enviroment': Lables.enviroment,
  'helth': Lables.helth,
  'incident': Lables.incident,
  'areaId': Lables.areaId,
  'qrScannerMesasge': Lables.qrScannerMesasge,
  'positiveAcctionMessage': Lables.positiveAcctionMessage,
  'negativeAcctionMessage': Lables.negativeAcctionMessage,
  'insertPositive': Lables.insertPositive,
  'insertNegative': Lables.insertNegative,
  'corectiveAcction': Lables.corectiveAcction,
  'insertcorectiveAcction': Lables.insertcorectiveAcction,
  'responsibal': Lables.responsibal,
  'area1': Lables.area1,
  'area2': Lables.area2,
  'scanButton': Lables.scanButton,
  'pictureButton': Lables.pictureButton,
  'category': Lables.category,
  'addAudit': Lables.addAudit,
  'email': Lables.email,
  'resable': Lables.responsabile,
  'passwoard': Lables.passwoard,
  'add': Lables.add,
};

@immutable
class RoutPath {
  static const homeRout = '/';
  static const loadingRout = '/loading';
  static const safetyRout = '/safery';
  static const employeeRout = '/employee';
  static const statsRout = '/stats';
  static const helthRout = '/sanatate';
  static const enviromentRout = '/mediu';
  static const incidentRout = '/incident';
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
        'incident': RoutPath.incidentRout
      };
}

Map<String, String> routPathList() {
  return {
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
