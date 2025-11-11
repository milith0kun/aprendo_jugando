import 'lib/services/mock_data_service.dart';

void main() {
  print('=== DIAGNÓSTICO DE DATOS ===\n');

  // Test 1: Verificar Subjects
  print('1. SUBJECTS (${MockDataService.mockSubjects.length} encontrados):');
  for (var subject in MockDataService.mockSubjects) {
    print('   - ${subject.id}: ${subject.name}');
    print('     Descripción: ${subject.description}');
    print('     Icon: ${subject.icon}');
    print('     Color: ${subject.color}');
    print('');
  }

  // Test 2: Verificar Topics
  print('2. TOPICS (${MockDataService.mockTopics.length} encontrados):');
  var topicsBySubject = <String, List<String>>{};
  for (var topic in MockDataService.mockTopics) {
    if (!topicsBySubject.containsKey(topic.subjectId)) {
      topicsBySubject[topic.subjectId] = [];
    }
    topicsBySubject[topic.subjectId]!.add(topic.name);
  }

  for (var subjectId in topicsBySubject.keys) {
    print('   Subject $subjectId:');
    for (var topicName in topicsBySubject[subjectId]!) {
      print('     - $topicName');
    }
    print('');
  }

  // Test 3: Verificar Activities
  print('3. ACTIVITIES (${MockDataService.mockActivities.length} encontradas):');
  var activitiesByTopic = <String, int>{};
  for (var activity in MockDataService.mockActivities) {
    activitiesByTopic[activity.topicId] =
        (activitiesByTopic[activity.topicId] ?? 0) + 1;
  }

  for (var topicId in activitiesByTopic.keys) {
    print('   Topic $topicId: ${activitiesByTopic[topicId]} actividades');
  }

  print('\n=== FIN DEL DIAGNÓSTICO ===');
}
