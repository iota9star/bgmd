import 'package:url_launcher/url_launcher_string.dart';

import '../../bgmd.dart';

class DonatePanel extends StatelessWidget {
  const DonatePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
      (
        context.l10n.alipay,
        context.l10n.alipayDesc,
        'https://donate.bytex.space?p=alipay',
        Assets.alipay.image(width: 40.0)
      ),
      (
        context.l10n.wechat,
        context.l10n.wechatDesc,
        'https://donate.bytex.space/',
        Assets.wechatpay.image(width: 40.0)
      ),
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPinnedAppBar(title: context.l10n.supportMe),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = list[index];
                final title = Text(
                  item.$1,
                  style: context.textTheme.bodyLarge,
                );
                return RippleTap(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: item.$4,
                        ),
                        const Gap(16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title,
                            Text(
                              item.$2,
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    launchUrlString(
                      item.$3,
                      mode: LaunchMode.externalNonBrowserApplication,
                    );
                  },
                );
              },
              childCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
