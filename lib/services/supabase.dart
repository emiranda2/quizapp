import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:crudapp/services/auth.dart';
import 'package:crudapp/services/models.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Reads all documents from the topics table
  Future<List<Topic>> getTopics() async {
    final response = await _client.from('topics').select('*, quizzes(*)');
    return response.map((data) => Topic.fromJson(data)).toList();
  }

  /// Retrieves a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    final response = await _client.from('quiz_document').select().eq('quizid', quizId).single();
    return Quiz.fromJson(response);
  }

  /// Listens to current user's report document in Supabase
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((authState) {
      final userId = authState.session?.user.id;

      if (userId != null) {
        return _client
            .from('reports')
            .stream(primaryKey: ['userid'])
            .eq('userid', userId)
            .asyncMap((_) async {
              final response = await _client
                  .from('completed_quizzes')
                  .select()
                  .eq('userid', userId);
              return response.isNotEmpty
                  ? Report.fromJson(response.first)
                  : Report();
            });
      } else {
        return Stream.value(Report());
      }
    });
  }

  /// Updates the current user's report document after completing a quiz
  Future<void> updateUserReport(Quiz quiz) async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) return;
    final data = {
      'userid': userId, // Ensure user_id is included in the data
      'quizid': quiz.id
    };

    await _client.from('reports').upsert(data);
  }
}