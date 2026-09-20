import 'package:flutter/material.dart';

class KeepSearchBar extends StatelessWidget {
  const KeepSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onViewToggle,
    required this.isMasonry,
    this.onMenuTap,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onViewToggle;
  final bool isMasonry;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(28),
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.menu), onPressed: onMenuTap ?? () => Scaffold.of(context).openDrawer()),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: const InputDecoration(
                  hintText: 'Search your notes',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
            if (controller.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              ),
            IconButton(
              icon: Icon(isMasonry ? Icons.view_agenda_outlined : Icons.grid_view),
              tooltip: isMasonry ? 'Single column view' : 'Multi-column view',
              onPressed: onViewToggle,
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text('K', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
