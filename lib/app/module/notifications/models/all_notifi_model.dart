import 'package:firebase_messaging/firebase_messaging.dart';

class AllNotificationModel {
  int? totalMessage;
  int? totalRead;
  int? totalUnread;
  List<ListMessages>? listMessages;

  AllNotificationModel(
      {this.totalMessage, this.totalRead, this.totalUnread, this.listMessages});

  AllNotificationModel.fromJson(Map<String, dynamic> json) {
    totalMessage = json['totalMessage'];
    totalRead = json['totalRead'];
    totalUnread = json['totalUnread'];
    if (json['listMessages'] != null) {
      listMessages = <ListMessages>[];
      json['listMessages'].forEach((v) {
        listMessages!.add(new ListMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMessage'] = this.totalMessage;
    data['totalRead'] = this.totalRead;
    data['totalUnread'] = this.totalUnread;
    if (this.listMessages != null) {
      data['listMessages'] = this.listMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListMessages {
  String? id;
  String? ucode;
  String? bcode;
  String? lcode;
  String? rcode;
  String? date;
  String? title;
  String? body;
  int? mstatus;
  String? data;
  String? imgurl;

  ListMessages(
      {this.id,
      this.ucode,
      this.bcode,
      this.lcode,
      this.rcode,
      this.date,
      this.title,
      this.body,
      this.mstatus,
      this.data,
      this.imgurl});

  ListMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ucode = json['ucode'];
    bcode = json['bcode'];
    lcode = json['lcode'];
    rcode = json['rcode'];
    date = json['date'];
    title = json['title'];
    body = json['body'];
    mstatus = json['mstatus'];
    data = json['data'];
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ucode'] = this.ucode;
    data['bcode'] = this.bcode;
    data['lcode'] = this.lcode;
    data['rcode'] = this.rcode;
    data['date'] = this.date;
    data['title'] = this.title;
    data['body'] = this.body;
    data['mstatus'] = this.mstatus;
    data['data'] = this.data;
    data['imgurl'] = this.imgurl;
    return data;
  }
}

extension toJsonRemoteMessage on RemoteMessage {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'senderId': this.senderId,
        'category': this.category,
        'collapseKey': this.collapseKey,
        'contentAvailable': this.contentAvailable,
        'data': this.data,
        'from': this.from,
        'messageId': this.messageId,
        'messageType': this.messageType,
        'mutableContent': this.mutableContent,
        'notification': this.notification?.toJson(),
        'sentTime': this.sentTime?.millisecondsSinceEpoch,
        'threadId': this.threadId,
        'ttl': this.ttl,
      };
}

extension toJsonRemoteNotification on RemoteNotification {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'android': this.android?.toJson(),
        'apple': this.apple?.toJson(),
        // 'web': this.web?.toJson(),
        // TODO RemoteNotification web
        'web': null,
        'title': this.title,
        'titleLocArgs': this.titleLocArgs,
        'titleLocKey': this.titleLocKey,
        'body': this.body,
        'bodyLocArgs': this.bodyLocArgs,
        'bodyLocKey': this.bodyLocKey,
      };
}

extension toJsonAndroidNotification on AndroidNotification {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'channelId': this.channelId,
        'clickAction': this.clickAction,
        'color': this.color,
        'count': this.count,
        'imageUrl': this.imageUrl,
        'link': this.link,
        'priority': convertAndroidNotificationPriorityToInt(this.priority),
        'smallIcon': this.smallIcon,
        'sound': this.sound,
        'ticker': this.ticker,
        'visibility':
            convertAndroidNotificationVisibilityToInt(this.visibility),
        'tag': this.tag,
      };
}

extension toJsonAppleNotification on AppleNotification {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'badge': this.badge,
        'sound': this.sound?.toJson(),
        'imageUrl': this.imageUrl,
        'subtitle': this.subtitle,
        'subtitleLocArgs': this.subtitleLocArgs,
        'subtitleLocKey': this.subtitleLocKey,
      };
}

extension toJsonAppleNotificationSound on AppleNotificationSound {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'critical': this.critical,
        'name': this.name,
        'volume': this.volume,
      };
}

/// Converts an [AndroidNotificationPriority] into it's [int] representation.
int convertAndroidNotificationPriorityToInt(
    AndroidNotificationPriority? priority) {
  switch (priority) {
    case AndroidNotificationPriority.minimumPriority:
      return -2;
    case AndroidNotificationPriority.lowPriority:
      return -1;
    case AndroidNotificationPriority.defaultPriority:
      return 0;
    case AndroidNotificationPriority.highPriority:
      return 1;
    case AndroidNotificationPriority.maximumPriority:
      return 2;
    default:
      return 0;
  }
}

/// Converts an [AndroidNotificationVisibility] into it's [int] representation.
int convertAndroidNotificationVisibilityToInt(
    AndroidNotificationVisibility? visibility) {
  switch (visibility) {
    case AndroidNotificationVisibility.secret:
      return -1;
    case AndroidNotificationVisibility.private:
      return 0;
    case AndroidNotificationVisibility.public:
      return 1;
    default:
      return 0;
  }
}
