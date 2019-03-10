import 'package:tensor_isolates_depenedency_in/mock_repo.dart';
import 'package:tensor_isolates_depenedency_in/photo_repo.dart';
import 'package:tensor_isolates_depenedency_in/prod_repo.dart';

enum RepoType { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();

  static RepoType _repoType;

  static void configure(RepoType repoType) {
    _repoType = repoType;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  PhotoRepo get photoRepo {
    switch (_repoType) {
      case RepoType.MOCK:
        return MockRepo();
      default:
        return ProdRepo();
    }
  }
}
