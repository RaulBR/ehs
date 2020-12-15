import 'package:ehsfocus/screens/home/home_card.dart';
import 'package:ehsfocus/services/websocket_service.dart/audit_socket_bloc/audit_socket_bloc.dart';

import 'package:ehsfocus/shared/constants.dart';

import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMenu extends StatelessWidget with Labels {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          HomeCard(
            icon: 62389,
            title: Labels.safty,
            acction: () {
              Navigator.pushNamed(context, RoutPath.safetyRout);
            },
          ),
          HomeCard(
            color: AppColors.fieldInFocus,
            icon: 58949,
            title: Labels.incident,
            acction: () {
              Navigator.pushNamed(context, RoutPath.incidentRout);
            },
          ),
          BlocBuilder<AuditSocketBloc, AuditSocketState>(
            buildWhen: (previous, current) => current is AuditCountState,
            builder: (context, state) {
              int count = 0;
              if (state is AuditCountState)
                count = state.auditCount == 0 ? null : state.auditCount;
              if (count == 0 || count == null) return Text('');
              return HomeCard(
                expanded: true,
                color: AppColors.accent,
                icon: 58828,
                title: 'Aveti $count actiuni',
                acction: () {
                  Navigator.pushNamed(context, RoutPath.myResponsibility);
                },
              );
            },
          ),
          BlocBuilder<AuditSocketBloc, AuditSocketState>(
            buildWhen: (previous, current) =>
                current is AuditDistributionCountState,
            builder: (context, state) {
              int distributinCount = 0;
              if (state is AuditDistributionCountState)
                distributinCount = state.distributeAuditCount == 0
                    ? null
                    : state.distributeAuditCount;
              if (distributinCount == 0 || distributinCount == null)
                return Text('');
              return HomeCard(
                expanded: true,
                color: AppColors.pending,
                icon: 58828,
                title: 'Aveti $distributinCount actiune/i de distribuit',
                acction: () {
                  Navigator.pushNamed(context, RoutPath.overwiewAudits);
                },
              );
            },
          ),
          BlocBuilder<AuditSocketBloc, AuditSocketState>(
            buildWhen: (previous, current) =>
                current is AuditRejectedCountState,
            builder: (context, state) {
              int distributinCount = 0;
              if (state is AuditRejectedCountState)
                distributinCount = state.distributeAuditCount == 0
                    ? null
                    : state.distributeAuditCount;
              if (distributinCount == 0 || distributinCount == null)
                return Text('');
              return HomeCard(
                expanded: true,
                color: AppColors.fieldInFocus,
                icon: 58828,
                title: 'Aveti $distributinCount actiuni rejectate',
                acction: () =>
                    Navigator.pushNamed(context, RoutPath.myRejectedAspects),
              );
            },
          ),
        ],
      ),
    );
  }
}
