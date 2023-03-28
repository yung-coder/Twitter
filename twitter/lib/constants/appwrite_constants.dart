class AppwriteConstants {
  static const String databaseId = '6415f6e644ef26e01dcc';
  static const String projectId = '6415f5e482868699b5a6';
  static const String endPoint = 'http://192.168.1.7:3000/v1';
  static const String userscollectionId = '641b3161edd53d5ff970';
  static const String tweetcollectionId = '641b59b4856215956a59';
  static const String imagesBucket = '641b61c489571bb8f5ee';  
  static const String notificationsId = '64230ed4ae489fcd588e';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
