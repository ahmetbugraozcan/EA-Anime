abstract class IFirebaseMessagingService{


  Future<void> initService();

  Future<void> initLocalNotifications();

  Future<void> unsubscribeFromTopic(String topic);

}