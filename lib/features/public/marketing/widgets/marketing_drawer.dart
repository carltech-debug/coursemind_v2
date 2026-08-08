/*
==============================================================================
FILE: marketing_drawer.dart
MODULE: Marketing
COMPONENT: Marketing Drawer
==============================================================================
*/

import 'package:flutter/material.dart';

final class MarketingDrawer extends StatelessWidget {
  const MarketingDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          children: [
            const ListTile(
              title: Text(
                'CourseMind',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Divider(),

            _drawerItem(
              context,
              'Home',
            ),

            _drawerItem(
              context,
              'Features',
            ),

            _drawerItem(
              context,
              'Institutions',
            ),

            _drawerItem(
              context,
              'Pricing',
            ),

            _drawerItem(
              context,
              'Contact',
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    String title,
  ) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}