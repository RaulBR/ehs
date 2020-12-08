import 'package:ehsfocus/shared/constants.dart';

class AspectActionService {
  String getResponsable(aspect) {
    if (aspect != null &&
        aspect.action != null &&
        aspect.action.responsable != null) {
      return '${aspect.action.responsable.firstName ?? null} ${aspect.action.responsable.lastName ?? null}';
    }
    return Labels.notAdded;
  }

  String getCreatedBy(aspect) {
    if (aspect != null &&
        aspect.audit != null &&
        aspect.audit.employee != null &&
        aspect.audit.employee.firstName != null) {
      return '${aspect.audit.employee.firstName ?? null} ${aspect.audit.employee.lastName ?? null}';
    }
    return Labels.notAdded;
  }

  String getSubtitle(aspect) {
    if (aspect == null) {
      return Labels.unKnown;
    }
    return '${aspect.categoryType} -> ${aspect.category}';
  }
}
