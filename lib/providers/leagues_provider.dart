import 'dart:async';
import 'package:loop/core/models/league_model.dart';
import 'package:loop/core/services/api_endpoint/endpoints.dart';
import 'package:loop/core/services/api_services/api_service.dart';
import 'package:loop/export.dart';

class LeaguesProvider with ChangeNotifier {
  final ApiService apiService;
  
  List<League> _leagues = [];
  bool _isLoading = false;
  String _error = '';

  List<League> get leagues => _leagues;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Get leagues sorted by date (nearest first)
  List<League> get sortedLeagues => _leagues..sort((a, b) => 
    a.expectedStartDate.compareTo(b.expectedStartDate)
  );

  // Get the nearest upcoming league
  League? get nearestLeague => sortedLeagues
      .where((league) => league.expectedStartDate.isAfter(DateTime.now()))
      .firstOrNull;

  LeaguesProvider({required this.apiService});

  Future<void> fetchLeagues() async {
    if (_isLoading) return; // Prevent multiple calls
    
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await apiService.get<List<League>>(
        EndPoints.leagues,
        false, 
        (data) {
          if (data is List) {
            return data.map((leagueJson) => League.fromJson(leagueJson)).toList();
          }
          return [];
        },
      );

      if (response.success && response.data != null) {
        _leagues = response.data!;
      } else {
        _error = response.message.isNotEmpty ? response.message : 'Failed to load leagues';
      }
    } catch (e) {
      _error = 'Network error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}