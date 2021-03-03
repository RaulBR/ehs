import 'package:ehsfocus/screens/side_menu/drower_header.dart';
import 'package:ehsfocus/screens/side_menu/navigation_tile.dart';
import 'package:ehsfocus/services/loacal_storage.dart';
import 'package:ehsfocus/services/repository/repo_service.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavogationService {
  final _repoService = RepoService();
  final _localStorageService = LocalStorageService();
  getMenu(role, logout) {
    List<Widget> stable = [
      DrowerHeader(),
      NavigationTile(
        title: Labels.mainPage,
        path: RoutPath.homeRout,
      ),
      NavigationTile(
        title: Labels.statistics,
        path: RoutPath.statsRout,
      ),
      NavigationTile(
        title: Labels.audits,
        path: RoutPath.myAudits,
      ),
      NavigationTile(
        title: Labels.myData,
        path: RoutPath.meRout,
      ),
      NavigationTile(
          title: Labels.refresh,
          path: RoutPath.homeRout,
          action: () async {
            await _repoService.clearAllHives();
          }),
    ];
    role = role ?? _localStorageService.readWithKey('role');
    if (role == 'ADMIN') {
      stable.add(NavigationTile(
        title: Labels.admin,
        path: RoutPath.adminRoute,
      ));
    }
    if (role == 'MANAGER' || role == 'ADMIN') {
      stable.add(NavigationTile(
        title: Labels.managerAuditis,
        path: RoutPath.managerAuditis,
      ));
    }
    return [
      ...stable,
      ListTile(
        title: Text(Labels.logout),
        onTap: () {
          logout();
        },
      ),
    ];
  }
}
