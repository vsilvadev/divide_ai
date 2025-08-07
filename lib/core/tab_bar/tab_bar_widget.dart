import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabBarWidget extends StatefulWidget {
  final Widget child;

  const TabBarWidget({
    super.key,
    required this.child,
  });

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int _selectedIndex = 0;
  final List<String> _routes = [
    'home',
    'add-item',
    'profile',
  ];

  void _onSelectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.goNamed(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => _onSelectedTab(index),

        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Conta',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'Novo Item',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
