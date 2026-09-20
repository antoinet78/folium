import 'package:flutter/material.dart';

class BottomCreateBar extends StatelessWidget {
  const BottomCreateBar({
    super.key,
    required this.onChecklist,
    required this.onDrawing,
    required this.onAudio,
    required this.onImage,
    required this.onText,
  });

  final VoidCallback onChecklist;
  final VoidCallback onDrawing;
  final VoidCallback onAudio;
  final VoidCallback onImage;
  final VoidCallback onText;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shadowColor: Colors.black26,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              _Action(icon: Icons.check_box_outlined, tooltip: 'New checklist', onTap: onChecklist),
              _Action(icon: Icons.brush_outlined, tooltip: 'New drawing', onTap: onDrawing),
              _Action(icon: Icons.mic_none_outlined, tooltip: 'New audio note', onTap: onAudio),
              _Action(icon: Icons.image_outlined, tooltip: 'New photo note', onTap: onImage),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: FloatingActionButton.small(
                  heroTag: 'create_text_fab',
                  elevation: 0,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  onPressed: onText,
                  child: const Icon(Icons.edit_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.tooltip, required this.onTap});
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(icon, size: 22, color: Theme.of(context).colorScheme.onSurfaceVariant), tooltip: tooltip, onPressed: onTap);
  }
}
