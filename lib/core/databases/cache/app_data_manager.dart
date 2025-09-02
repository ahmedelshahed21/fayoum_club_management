import 'package:fayoum_club_management/core/databases/cache/cache_helper.dart';

class AppDataManager {
  final CacheHelper _cacheHelper;

  AppDataManager(this._cacheHelper);

  bool? _cachedIsSelectLanguageViewVisited;

  void saveIsSelectLanguageViewVisited({
    required bool isSelectLanguageViewVisited,
  }) {
    _cacheHelper.saveData(
      key: 'isSelectLanguageViewVisited',
      value: isSelectLanguageViewVisited,
    );
    _cachedIsSelectLanguageViewVisited = isSelectLanguageViewVisited;
  }

  bool? getIsSelectLanguageViewVisited() {
    _cachedIsSelectLanguageViewVisited ??= _cacheHelper.getData(
      key: 'isSelectLanguageViewVisited',
    );
    return _cachedIsSelectLanguageViewVisited;
  }

  void clearIsSelectLanguageViewVisited() {
    _cacheHelper.removeData(key: 'isSelectLanguageViewVisited');
    _cachedIsSelectLanguageViewVisited = null;
  }
}
