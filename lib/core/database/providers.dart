import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../models/label.dart';
import '../../models/note.dart';
import 'isar_service.dart';

// ---------------------------------------------------------------------------
// Core Isar provider
// ---------------------------------------------------------------------------

final isarServiceProvider = Provider<IsarService>((ref) => IsarService.instance);

final isarInitProvider = FutureProvider<Isar>((ref) async {
  final svc = ref.read(isarServiceProvider);
  return svc.open();
});

// ---------------------------------------------------------------------------
// Notes stream — reactive, no manual refresh needed
// ---------------------------------------------------------------------------

final notesStreamProvider = StreamProvider<List<Note>>((ref) {
  final svc = ref.read(isarServiceProvider);
  // If Isar not yet open, return memory cache as single emission.
  if (!svc.isOpen) return Stream.value(svc.memoryCache);
  return svc.watchNotes();
});

final labelsStreamProvider = StreamProvider<List<Label>>((ref) {
  final svc = ref.read(isarServiceProvider);
  if (!svc.isOpen) return Stream.value(svc.labelCache);
  return svc.watchLabels();
});

// ---------------------------------------------------------------------------
// Search: debounced in UI, this provider reacts to query changes
// ---------------------------------------------------------------------------

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredNotesProvider = FutureProvider<List<Note>>((ref) async {
  final query = ref.watch(searchQueryProvider).trim();
  final svc = ref.read(isarServiceProvider);
  if (!svc.isOpen) return svc.memoryCache;
  if (query.isEmpty) {
    // Use stream cache if available, else DB
    final notesAsync = ref.watch(notesStreamProvider);
    return notesAsync.when(
      data: (notes) => notes,
      loading: () => svc.memoryCache,
      error: (_, __) => svc.memoryCache,
    );
  }
  // FTS path (isolate-aware inside service)
  return svc.searchNotes(query);
});

// ---------------------------------------------------------------------------
// View toggle: masonry (2 cols) vs single column
// ---------------------------------------------------------------------------

enum HomeViewMode { masonry, singleColumn }

final homeViewModeProvider = StateProvider<HomeViewMode>((ref) => HomeViewMode.masonry);

// ---------------------------------------------------------------------------
// Selection mode (multi-select for bulk pin/archive/delete)
// ---------------------------------------------------------------------------

final selectedNoteIdsProvider = StateProvider<Set<int>>((ref) => {});

// ---------------------------------------------------------------------------
// Filtered helpers: pinned / others splits (computed, no extra DB hit)
// ---------------------------------------------------------------------------

final pinnedNotesProvider = Provider<List<Note>>((ref) {
  final notesAsync = ref.watch(filteredNotesProvider);
  return notesAsync.when(
    data: (notes) => notes.where((n) => n.isPinned).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

final unpinnedNotesProvider = Provider<List<Note>>((ref) {
  final notesAsync = ref.watch(filteredNotesProvider);
  return notesAsync.when(
    data: (notes) => notes.where((n) => !n.isPinned).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});
