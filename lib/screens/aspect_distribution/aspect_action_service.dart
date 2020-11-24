class AspectActionService {
  // TODO add to constants
  String getResponsable(aspect) {
    if (aspect != null &&
        aspect.action != null &&
        aspect.action.responsable != null) {
      return '${aspect.action.responsable.firstName ?? null} ${aspect.action.responsable.lastName ?? null}';
    }
    return 'NU A FOST ADAUGAT';
  }

  String getCreatedBy(aspect) {
    if (aspect != null &&
        aspect.audit != null &&
        aspect.audit.employee != null &&
        aspect.audit.employee.firstName != null) {
      return '${aspect.audit.employee.firstName ?? null} ${aspect.audit.employee.lastName ?? null}';
    }
    return 'NU A FOST ADAUGAT';
  }

  String getSubtitle(aspect) {
    if (aspect == null) {
      return 'Necunosct';
    }
    return '${aspect.categoryType} -> ${aspect.category}';
  }
}
