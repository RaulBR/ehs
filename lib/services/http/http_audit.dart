import 'package:ehsfocus/models/action_model.dart';

class HttpAuditService {
  Audit _audit = Audit();

  Audit getAudit() {
    return _audit;
  }

  setAudit(auditin) {
    _audit = auditin;
  }

  deleteAudit(String id) {
    if (_audit == null) {
      return;
    }
    if (_audit.area != null) {
      _audit = _audit.area.id == id ? null : _audit;
    }
  }
}
