import 'package:flutter/foundation.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(title: context.l10n.license);
  }
}

@immutable
class LicenseList extends StatelessWidget {
  LicenseList({super.key});

  final Future<_LicenseData> _licenses = LicenseRegistry.licenses
      .fold<_LicenseData>(
        _LicenseData(),
        (_LicenseData prev, LicenseEntry license) => prev..addLicense(license),
      )
      .then((_LicenseData licenseData) => licenseData..sortPackages());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _Title(),
          FutureBuilder<_LicenseData>(
            future: _licenses,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Assets.bgmd.provider(),
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return SliverFillRemaining(
                    child: Center(
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                          color: theme.secondary,
                        ),
                      ),
                    ),
                  );
                case ConnectionState.done:
                  final data = snapshot.data!;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    sliver: SliverWaterfallFlow(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          final String packageName = data.packages[index];
                          final List<int> bindings =
                              data.packageLicenseBindings[packageName]!;
                          return TransitionContainer(
                            next: LicenseDetail(
                              packageName: packageName,
                              licenseEntries: bindings
                                  .map((int i) => data.licenses[i])
                                  .toList(growable: false),
                            ),
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            builder: (context, open) {
                              return ScalableCard(
                                onTap: open,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        packageName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                          height: 1.25,
                                          fontFamily: 'mono',
                                        ),
                                      ),
                                      const Gap(8),
                                      Text(
                                        '${bindings.length}条协议',
                                        style: const TextStyle(
                                          fontFamily: 'mono',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        childCount: data.packages.length,
                      ),
                      gridDelegate:
                          SliverWaterfallFlowDelegateWithMinCrossAxisExtent(
                        crossAxisSpacing: context.margins,
                        mainAxisSpacing: context.margins,
                        minCrossAxisExtent: 240.0,
                      ),
                    ),
                  );
              }
            },
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 24.0,
                  bottom: 24.0 + context.navBarHeight,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.bgmd.path,
                      width: 36.0,
                    ),
                    const Gap(12.0),
                    const Text(
                      '❤',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                      ),
                    ),
                    const Gap(12.0),
                    const FlutterLogo(
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LicenseData {
  final List<LicenseEntry> licenses = <LicenseEntry>[];
  final Map<String, List<int>> packageLicenseBindings = <String, List<int>>{};
  final List<String> packages = <String>[];

  // Special treatment for the first package since it should be the package
  // for delivered application.
  String? firstPackage;

  void addLicense(LicenseEntry entry) {
    // Before the license can be added, we must first record the packages to
    // which it belongs.
    for (final String package in entry.packages) {
      _addPackage(package);
      // Bind this license to the package using the next index value. This
      // creates a contract that this license must be inserted at this same
      // index value.
      packageLicenseBindings[package]!.add(licenses.length);
    }
    licenses.add(entry); // Completion of the contract above.
  }

  /// Add a package and initialize package license binding. This is a no-op if
  /// the package has been seen before.
  void _addPackage(String package) {
    if (!packageLicenseBindings.containsKey(package)) {
      packageLicenseBindings[package] = <int>[];
      firstPackage ??= package;
      packages.add(package);
    }
  }

  /// Sort the packages using some comparison method, or by the default manner,
  /// which is to put the application package first, followed by every other
  /// package in case-insensitive alphabetical order.
  void sortPackages([int Function(String a, String b)? compare]) {
    packages.sort(
      compare ??
          (String a, String b) {
            // Based on how LicenseRegistry currently behaves, the first package
            // returned is the end user application license. This should be
            // presented first in the list. So here we make sure that first package
            // remains at the front regardless of alphabetical sorting.
            if (a == firstPackage) {
              return -1;
            }
            if (b == firstPackage) {
              return 1;
            }
            return a.toLowerCase().compareTo(b.toLowerCase());
          },
    );
  }
}
