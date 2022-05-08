
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:usoundradio/ui/mainwidgets/currentwidgets/manager.dart';

class NotificationUtil {
  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }
  static void updateNotificationMediaPlayer(String? artist, String? img,String? title) {
    if (img == null) {
      cancelNotification(4);
      return;
    }

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 4,
            channelKey: 'media_player_tests',
            category: NotificationCategory.Transport,
            title: artist,
            body: title,
            summary: Manager.isPlaying ? 'Now playing' : '',
            notificationLayout: NotificationLayout.MediaPlayer,
            largeIcon: img,
            autoDismissible: false,
            showWhen: false),
        actionButtons: [

          Manager.isPlaying
              ? NotificationActionButton(
              key: 'MEDIA_PAUSE',
              icon: 'resource://drawable/ic_pauseb',
              label: 'Pause',
              autoDismissible: false,
              showInCompactView: true,
              buttonType: ActionButtonType.KeepOnTop)
              : NotificationActionButton(
              key: 'MEDIA_PLAY',
              icon: 'resource://drawable/ic_playb',
              label: 'Play',
              autoDismissible: false,
              showInCompactView: true,
              enabled: true,
              buttonType: ActionButtonType.KeepOnTop),
          Manager.isFavorite ? NotificationActionButton(
              key: 'MEDIA_LIKE', label: 'like',
              autoDismissible: false,
              icon: 'resource://drawable/ic_unliked',
              showInCompactView: true,
              buttonType: ActionButtonType.KeepOnTop):
          NotificationActionButton(
              key: 'MEDIA_UNLIKE', label: 'unlike',
          autoDismissible: false,
              icon: 'resource://drawable/ic_liked',
          showInCompactView: true,
          enabled: true,
          buttonType: ActionButtonType.KeepOnTop)

        ]);
  }
}