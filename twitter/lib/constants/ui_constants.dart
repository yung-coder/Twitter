import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/constants/constants.dart';
import 'package:twitter/features/explore/view/explore_view_dart.dart';
import 'package:twitter/features/notifications/views/notification_view.dart';
import 'package:twitter/features/tweet/widgets/tweet_list.dart';
import 'package:twitter/theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreView(),
    NotificationView(), 
  ];
}
