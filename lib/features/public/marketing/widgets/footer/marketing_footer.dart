/*
==============================================================================
FILE: marketing_footer.dart
MODULE: Marketing
COMPONENT: Marketing Footer
==============================================================================
*/

import 'package:flutter/material.dart';

final class MarketingFooter extends StatelessWidget {
  const MarketingFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isDesktop ? 64 : 48,
      ),
      color: const Color(0xFF191C1E),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: Column(
            children: [
              Flex(
                direction: isDesktop
                    ? Axis.horizontal
                    : Axis.vertical,
                crossAxisAlignment: isDesktop
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: isDesktop ? 2 : 0,
                    child: Column(
                      crossAxisAlignment: isDesktop
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'CourseMind',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Learn smarter. Study better.',
                          textAlign: isDesktop
                              ? TextAlign.left
                              : TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(
                              alpha: 0.65,
                            ),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 80),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Platform',
                        links: [
                          'Features',
                          'Institutions',
                          'Marketplace',
                        ],
                      ),
                    ),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Company',
                        links: [
                          'About',
                          'Contact',
                          'Help',
                        ],
                      ),
                    ),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Legal',
                        links: [
                          'Privacy Policy',
                          'Terms of Service',
                        ],
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 40),
                    const _FooterColumn(
                      title: 'Platform',
                      links: [
                        'Features',
                        'Institutions',
                        'Marketplace',
                      ],
                      centered: true,
                    ),
                    const SizedBox(height: 28),
                    const _FooterColumn(
                      title: 'Company',
                      links: [
                        'About',
                        'Contact',
                        'Help',
                      ],
                      centered: true,
                    ),
                    const SizedBox(height: 28),
                    const _FooterColumn(
                      title: 'Legal',
                      links: [
                        'Privacy Policy',
                        'Terms of Service',
                      ],
                      centered: true,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 48),
              Divider(
                color: Colors.white.withValues(
                  alpha: 0.12,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '© ${DateTime.now().year} CourseMind. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(
                    alpha: 0.5,
                  ),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _FooterColumn extends StatelessWidget {
  const _FooterColumn({
    required this.title,
    required this.links,
    this.centered = false,
  });

  final String title;
  final List<String> links;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        for (final link in links) ...[
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white70,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(link),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}