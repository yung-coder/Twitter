import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/common/error_page.dart';
import 'package:twitter/common/loading_page.dart';
import 'package:twitter/constants/constants.dart';
import 'package:twitter/core/enums/tweet_type_enum.dart';
import 'package:twitter/features/auth/controller/auth_controller.dart';
import 'package:twitter/features/tweet/controller/tweet_controller.dart';
import 'package:twitter/features/tweet/widgets/carousel_image.dart';
import 'package:twitter/features/tweet/widgets/hashtags_text.dart';
import 'package:twitter/features/tweet/widgets/tweet_icon_button.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:like_button/like_button.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curentuser = ref.watch(currentUserDetailsProvider).value;
    return curentuser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
              data: (user) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 35,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (tweet.retweetedBy.isNotEmpty)
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsConstants.retweetIcon,
                                      color: Pallete.greyColor,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '${tweet.retweetedBy} retweeted',
                                      style: const TextStyle(
                                        color: Pallete.greyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '@${user.name} . ${timeago.format(
                                      tweet.tweetedAt,
                                      locale: 'en_short',
                                    )}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Pallete.greyColor,
                                    ),
                                  )
                                ],
                              ),
                              // replied to
                              HashtagText(
                                text: tweet.text,
                              ),
                              if (tweet.tweetType == TweetType.image)
                                CarouselImage(imageLinks: tweet.imageLinks),

                              if (tweet.link.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                AnyLinkPreview(
                                    displayDirection:
                                        UIDirection.uiDirectionHorizontal,
                                    link: 'https://${tweet.link}'),
                              ],
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TweetIconButton(
                                      pathName: AssetsConstants.viewsIcon,
                                      text: (tweet.commentIds.length +
                                              tweet.reshareCount +
                                              tweet.likes.length)
                                          .toString(),
                                      onTap: () {},
                                    ),
                                    TweetIconButton(
                                      pathName: AssetsConstants.commentIcon,
                                      text:
                                          (tweet.commentIds.length).toString(),
                                      onTap: () {},
                                    ),
                                    TweetIconButton(
                                      pathName: AssetsConstants.retweetIcon,
                                      text: (tweet.reshareCount.bitLength)
                                          .toString(),
                                      onTap: () {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .reshareTweet(
                                              tweet,
                                              curentuser,
                                              context,
                                            );
                                      },
                                    ),
                                    LikeButton(
                                      size: 25,
                                      onTap: (isLiked) async {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .likeTweet(tweet, curentuser);
                                        return !isLiked;
                                      },
                                      isLiked:
                                          tweet.likes.contains(curentuser.uid),
                                      likeBuilder: (isLiked) {
                                        return isLiked
                                            ? SvgPicture.asset(
                                                AssetsConstants.likeFilledIcon,
                                                color: Pallete.redColor,
                                              )
                                            : SvgPicture.asset(
                                                AssetsConstants
                                                    .likeOutlinedIcon,
                                                color: Pallete.greyColor,
                                              );
                                      },
                                      likeCount: tweet.likes.length,
                                      countBuilder: (likeCount, isLiked, text) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Text(
                                            text,
                                            style: TextStyle(
                                              color: isLiked
                                                  ? Pallete.redColor
                                                  : Pallete.greyColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share_outlined,
                                        size: 25,
                                        color: Pallete.greyColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      color: Pallete.greyColor,
                    )
                  ],
                );
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            );
  }
}
