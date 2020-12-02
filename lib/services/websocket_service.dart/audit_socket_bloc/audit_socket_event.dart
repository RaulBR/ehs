part of 'audit_socket_bloc.dart';

abstract class AuditSocketEvent {
  const AuditSocketEvent();
}

class ConnectToSocketEvent extends AuditSocketEvent {}

class AspectAddedEvent extends AuditSocketEvent {
  final int count;

  AspectAddedEvent(this.count);
}

class AuditDistributionCountEvent extends AuditSocketEvent {
  final int count;

  AuditDistributionCountEvent(this.count);
}

class DisconnectFromSocketEvent extends AuditSocketEvent {}

class AlertUserEvent extends AuditSocketEvent {}

class CheckConenctionEvent extends AuditSocketEvent {}
