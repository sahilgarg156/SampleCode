import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:nlsapp/api/models/security/constants.dart';
import 'package:nlsapp/api/models/security/entity_type.dart';
import 'package:nlsapp/api/models/security/role_function.dart';
import 'package:nlsapp/api/models/security/roster.dart';
import 'package:nlsapp/api/models/security/user_role_entity.dart';
import 'package:nlsapp/api/models/user_response.dart';
import 'package:nlsapp/api/models/watchlist.dart';
import 'package:nlsapp/api/referense_repo.dart';
import 'package:nlsapp/api/user_repo.dart';
import 'package:nlsapp/app/app_event.dart';
import 'package:nlsapp/app/app_state.dart';
import 'package:nlsapp/base/datawrapper/data_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  static final Logger _logger = Logger("AppBloc");

  final SharedPreferences preferences;
  final ReferenceRepository referenceRepository;
  final UserRepository userRepository;

  Watchlist watchlist;
  UserData userData;

  // Reference data
  List<EntityType> entityTypes;
  List<RoleFunction> roleFunctions;

  AppBloc({
    @required this.preferences,
    @required this.referenceRepository,
    @required this.userRepository,
  }) {
    watchlist = Watchlist.fromPreferences(preferences, _userKey());
  }

  RoleFunction getRole(String roleName) {
    return roleFunctions.firstWhere(
      (rf) => rf.name.toLowerCase() == roleName,
      orElse: () => null,
    );
  }

  EntityType getEntityType(String entityTypeName) {
    return entityTypes.firstWhere(
      (e) => e.name.toLowerCase() == entityTypeName,
      orElse: () => null,
    );
  }

  List<UserRoleEntity> getManagedEntities([String entityTypeName]) {
    if (userData == null) {
      return [];
    }

    final RoleFunction manager = getRole(ROLE_MANAGER);

    final List<UserRoleEntity> managedEntities = []
      ..addAll(userData.userRoleEntities);
    managedEntities.retainWhere((ure) => ure.roleId == manager.id);
    if (entityTypeName != null) {
      final EntityType entityType = getEntityType(entityTypeName);
      managedEntities.retainWhere((ure) => ure.entityTypeId == entityType.id);
    }
    return managedEntities;
  }

  List<Roster> getRoster([String roleName]) {
    if (userData == null) {
      return [];
    }

    final List<Roster> roster = []..addAll(userData.roster);
    if (roleName != null) {
      final RoleFunction roleFunction = getRole(roleName);
      roster.retainWhere((rf) => rf.roleId == roleFunction.id);
    }
    return roster;
  }

  @override
  AppState get initialState => AppNotStarted();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStart) {
      yield AppNotStarted();
      // Will get user response from shared preferences if stored
      final UserResponse userResponse =
          UserResponse.fromSharedPreferences(preferences);
      if (userResponse != null) {
        DataWrapper.instance().authToken = userResponse.authToken;
        try {
          _loadRefs();
          final List<RoleFunction> roleFunctions =
              await userRepository.loadUserPermission();
          final List<UserRoleEntity> userEntities =
              await userRepository.loadUserEntity();
          final List<Roster> roster = await userRepository.loadUserRoster();
          userData = UserData(
            userResponse: userResponse,
            userRoleEntities: userEntities,
            roleFunctions: roleFunctions,
            roster: roster,
          );
          _logger.finer('USER DATA: $userData');
          yield AppStarted();
        } catch (e, stack) {
          _logger.shout(e);
          _logger.shout(stack);
          userData = null;
          entityTypes = null;
          roleFunctions = null;
          yield AppStartError(e);
        }
      } else {
        yield AppStarted();
      }
    } else if (event is AppAddToWatchlist) {
      watchlist = watchlist.add(event.players, event.clubs, event.teams);
      watchlist.toPreferences(preferences, _userKey());
      yield AppWatchlistChanged(watchlist);
    } else if (event is AppRemoveFromWatchlist) {
      watchlist = watchlist.remove(event.players, event.clubs, event.teams);
      watchlist.toPreferences(preferences, _userKey());
      yield AppWatchlistChanged(watchlist);
    } else if (event is AppUserChangeEvent) {
      userData = event.userData;
      // Store the user response into shared preferences on login event
      if (userData != null) {
        await userData.userResponse.toPreferences(preferences);
        DataWrapper.instance().authToken = userData.userResponse.authToken;
        try {
          _loadRefs();
        } catch (e, stack) {
          _logger.shout(e);
          _logger.shout(stack);
          entityTypes = null;
          roleFunctions = null;
        }
      } else {
        await UserResponse.removeFromPreferences(preferences);
        DataWrapper.instance().authToken = null;
      }
      watchlist = Watchlist.fromPreferences(preferences, _userKey());
      yield AppUserChanged(userData);
    }
  }

  String _userKey() =>
      userData == null ? 'Guest' : 'User${userData.userResponse.user.id}';

  void _loadRefs() async {
    entityTypes = await referenceRepository.loadEntityTypes();
    roleFunctions = await referenceRepository.loadRoleFunctions();
    _logger.finer('Reference data loaded: ${entityTypes.length} entity types,'
        ' ${roleFunctions.length} role functions');
  }
}
