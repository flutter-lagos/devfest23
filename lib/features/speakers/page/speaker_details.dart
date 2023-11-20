import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/core/widgets/on_screen_loader.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:devfest23/features/speakers/application/application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants.dart';
import '../../../core/data/data.dart';
import '../../../core/icons.dart';
import '../../../core/router/navigator.dart';
import '../../../core/router/routes.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' hide Text, List, Radius;

import '../../../core/providers/providers.dart';
import '../../home/widgets/speaker_action_card.dart';

typedef SocialIconWithUrl = ({Widget icon, String url});

class SpeakerDetailsPage extends ConsumerStatefulWidget {
  const SpeakerDetailsPage({super.key, required this.speaker});

  final Speaker speaker;

  @override
  ConsumerState<SpeakerDetailsPage> createState() => _SpeakerDetailsPageState();
}

class _SpeakerDetailsPageState extends ConsumerState<SpeakerDetailsPage> {
  @override
  void initState() {
    super.initState();

    ref.listenManual(
      speakerDetailsViewModelProvider.select((value) => value.viewState),
      (previous, next) {
        if (next == ViewState.success) {
          ref.read(scheduleViewModelProvider.notifier).fetchSessions();
        }
      },
    );

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref
          .read(speakerDetailsViewModelProvider.notifier)
          .initialiseSpeaker(widget.speaker);

      ref.read(speakerDetailsViewModelProvider.notifier).initialiseSession(
            ref.read(allSessionsProviderProvider).firstWhere((element) =>
                element.sessionId ==
                ref.read(speakerProvider).currentSessionId),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);
    final theme = DevFestTheme.of(context);
    return OnScreenLoader(
      isLoading: ref.watch(speakerDetailsViewModelProvider
              .select((value) => value.viewState)) ==
          ViewState.loading,
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: theme.backgroundColor,
          surfaceTintColor: theme.backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leadingWidth: 120,
          leading: const GoBackButton(),
          iconTheme: IconThemeData(
              color: isDark ? DevfestColors.background : DevfestColors.grey0),
          titleTextStyle: theme.textTheme?.button
              ?.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
          titleSpacing: 0,
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 148.h,
                  child: Row(
                    children: [
                      const _SpeakerAvatar(),
                      Constants.horizontalMargin.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ref.watch(speakerProvider).name,
                              style: theme.textTheme?.title02,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            8.verticalSpace,
                            Text(
                              ref.watch(speakerProvider).role,
                              style: theme.textTheme?.body03?.copyWith(
                                  color: isDark
                                      ? DevfestColors.grey80
                                      : DevfestColors.grey30),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            16.verticalSpace,
                            Row(
                              children: <SocialIconWithUrl>[
                                (
                                  icon: const Twitter(),
                                  url: ref.watch(speakerProvider).twitter
                                ),
                                (
                                  icon: const Linkedin(),
                                  url: ref.watch(speakerProvider).linkedIn
                                ),
                                (
                                  icon: const Link(),
                                  url: () {
                                    if (ref
                                        .watch(speakerProvider)
                                        .github
                                        .isNotEmpty) {
                                      return ref.watch(speakerProvider).github;
                                    }

                                    if (ref
                                        .watch(speakerProvider)
                                        .email
                                        .isNotEmpty) {
                                      return 'mailto:${ref.watch(speakerProvider).email}';
                                    }

                                    return '';
                                  }(),
                                ),
                              ]
                                  .map(
                                    (icon) => icon.url.isEmpty
                                        ? const SizedBox.shrink()
                                        : GestureDetector(
                                            onTap: () {
                                              _launchUrl(icon.url);
                                            },
                                            child: Container(
                                              width: 32.w,
                                              height: 32.w,
                                              padding:
                                                  const EdgeInsets.all(8).w,
                                              margin: const EdgeInsets.only(
                                                      right: 8)
                                                  .w,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFFDE293),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          120),
                                                ),
                                              ),
                                              child: icon.icon,
                                            ),
                                          ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Constants.largeVerticalGutter.verticalSpace,
                Text(
                  'SPEAKER BIO',
                  style: theme.textTheme?.body04,
                ),
                Constants.smallVerticalGutter.verticalSpace,
                Text(
                  ref.watch(speakerProvider).bio,
                  style: theme.textTheme?.body03?.copyWith(
                    color: isDark ? DevfestColors.grey80 : DevfestColors.grey10,
                  ),
                ),
                Constants.verticalGutter.verticalSpace,
                Text(
                  'TALK',
                  style: theme.textTheme?.body04,
                ),
                Constants.smallVerticalGutter.verticalSpace,
                StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return SpeakerActionCard(
                        session: ref.watch(speakerDetailsViewModelProvider
                            .select((value) => value.session)),
                        reserveSessionOnTap: ref
                            .read(speakerDetailsViewModelProvider.notifier)
                            .reserveSessionOnTap,
                      );
                    }

                    return SpeakerLoginActionCard(
                      session: ref.watch(speakerDetailsViewModelProvider
                          .select((value) => value.session)),
                      loginOnTap: () {
                        AppNavigator.pushNamedAndClear(RoutePaths.onboarding);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {}
  }
}

class _SpeakerAvatar extends ConsumerWidget {
  const _SpeakerAvatar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    var borderColor =
        isDark ? const Color(0xFFFDE293) : const Color(0xFF331B00);
    return CachedNetworkImage(
      imageUrl: ref
          .watch(
              speakerDetailsViewModelProvider.select((value) => value.speaker))
          .avatar,
      errorWidget: (context, url, error) => Container(
        width: 133.w,
        height: 148.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: borderColor,
            ),
            top: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: borderColor,
            ),
            right: BorderSide(
              width: 6,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: borderColor,
            ),
            bottom: BorderSide(
              width: 6,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: borderColor,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AppIcons.devfestLogo,
          height: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 133.w,
          height: 148.w,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: borderColor,
              ),
              top: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: borderColor,
              ),
              right: BorderSide(
                width: 6,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: borderColor,
              ),
              bottom: BorderSide(
                width: 6,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: borderColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
