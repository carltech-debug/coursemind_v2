import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/registration/providers/institution_registration_provider.dart';
import '../../auth/registration/state/institution_registration_state.dart';

class AcademicStructureTreeCard extends ConsumerStatefulWidget {
  const AcademicStructureTreeCard({super.key});

  @override
  ConsumerState<AcademicStructureTreeCard> createState() =>
      _AcademicStructureTreeCardState();
}

class _AcademicStructureTreeCardState
    extends ConsumerState<AcademicStructureTreeCard> {
  static const Color _purple = Color(0xFF3525CD);
  static const Color _ink = Color(0xFF17213B);
  static const Color _lavender = Color(0xFFF0F1FF);
  static const Color _badge = Color(0xFFE7EAFF);
  static const Color _muted = Color(0xFF64748B);
  static const Color _green = Color(0xFF047857);

  final List<_FacultyNode> _faculties = [];

  final Set<String> _expandedFaculties = {};
  final Set<String> _expandedDepartments = {};
  final Set<String> _expandedProgrammes = {};

  bool _expandAll = false;

  @override
  void initState() {
    super.initState();

    final draft = ref
        .read(institutionRegistrationProvider)
        .academicSetupDraft;

    _faculties.addAll(
      draft.faculties.map(
        (faculty) => _FacultyNode(
          name: faculty.name,
          departments: faculty.departments
              .map(
                (department) => _DepartmentNode(
                  name: department.name,
                  code: department.code,
                  programmes: department.programmes
                      .map(
                        (programme) => _ProgrammeNode(
                          name: programme.name,
                          levels: List<String>.of(programme.levels),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        ),
      ),
    );

    for (final faculty in _faculties) {
      _expandedFaculties.add(faculty.name);

      for (final department in faculty.departments) {
        _expandedDepartments.add(department.name);

        for (final programme in department.programmes) {
          _expandedProgrammes.add(programme.name);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EAF5)),
        boxShadow: [
          BoxShadow(
            color: _ink.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 28),
          if (_faculties.isEmpty)
            _buildEmptyState()
          else
            ..._faculties.map(_buildFaculty),
          const SizedBox(height: 18),
          _buildAddFacultyButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: _badge,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.account_tree_outlined,
            color: _purple,
            size: 27,
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1),
              Text(
                'Academic structure',
                style: TextStyle(
                  color: _ink,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Add your faculties, departments and programmes.',
                style: TextStyle(
                  color: Color(0xFF34415D),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: _toggleAll,
          style: TextButton.styleFrom(
            backgroundColor: _badge,
            foregroundColor: _purple,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Icon(
            _expandAll ? Icons.unfold_less : Icons.unfold_more,
            size: 19,
          ),
          label: Text(_expandAll ? 'Collapse All' : 'Expand All'),
        ),
      ],
    );
  }

  
  Widget _buildFaculty(_FacultyNode faculty) {
    final expanded = _expandedFaculties.contains(faculty.name);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _lavender,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: _rowShadow,
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                leading: const Icon(
                  Icons.apartment,
                  color: _purple,
                  size: 24,
                ),
                title: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    Text(
                      faculty.name,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _countBadge(
                      '${faculty.departments.length} Dept • '
                      '${faculty.departments.fold<int>(
                        0,
                        (total, department) =>
                            total + department.programmes.length,
                      )} Programme',
                    ),
                  ],
                ),
                trailing: Wrap(
                  spacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Edit faculty',
                      onPressed: () => _renameFaculty(faculty),
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: _muted,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      tooltip: expanded
                          ? 'Collapse faculty'
                          : 'Expand faculty',
                      onPressed: () => _toggleFaculty(faculty),
                      icon: Icon(
                        expanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                        color: _muted,
                      ),
                    ),
                    PopupMenuButton<String>(
                      tooltip: 'Faculty actions',
                      onSelected: (value) {
                        if (value == 'remove') {
                          _removeFaculty(faculty);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'remove',
                          child: Text('Remove faculty'),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () => _toggleFaculty(faculty),
              ),
            ),
          ),
          if (expanded) ...[
            const SizedBox(height: 14),
            for (final department in faculty.departments)
              _buildDepartment(faculty, department),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  _smallAction(
                    icon: Icons.add,
                    label: 'Add department',
                    onPressed: () => _addDepartment(faculty),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }


  
  Widget _buildDepartment(_FacultyNode faculty, _DepartmentNode department) {
    final expanded = _expandedDepartments.contains(department.name);

    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 17),
            child: Icon(Icons.circle, size: 16, color: Color(0xFF5148E5)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: _rowShadow,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
                      ),
                      leading: const Icon(
                        Icons.apartment,
                        color: _purple,
                        size: 23,
                      ),
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 5,
                        children: [
                          Text(
                            department.name,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          _codeBadge('Dept Code: ${department.code}'),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconButton(
                            tooltip: 'Edit department',
                            onPressed: () =>
                                _renameDepartment(faculty, department),
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: _muted,
                            ),
                          ),
                          IconButton(
                            tooltip: expanded
                                ? 'Collapse department'
                                : 'Expand department',
                            onPressed: () => _toggleDepartment(department),
                            icon: Icon(
                              expanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right,
                              color: _muted,
                            ),
                          ),
                          PopupMenuButton<String>(
                            tooltip: 'Department actions',
                            onSelected: (value) {
                              if (value == 'remove') {
                                _removeDepartment(faculty, department);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove department'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () => _toggleDepartment(department),
                    ),
                  ),
                ),
                if (expanded) ...[
                  const SizedBox(height: 12),
                  for (final programme in department.programmes)
                    _buildProgramme(department, programme),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: _smallAction(
                        icon: Icons.add,
                        label: 'Add programme',
                        onPressed: () => _addProgramme(department),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }


  
  Widget _buildProgramme(_DepartmentNode department, _ProgrammeNode programme) {
    final expanded = _expandedProgrammes.contains(programme.name);

    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Icon(Icons.circle, size: 14, color: Color(0xFF5148E5)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: _rowShadow,
              ),
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      leading: const Icon(
                        Icons.school_outlined,
                        color: Color(0xFF047857),
                        size: 24,
                      ),
                      title: Text(
                        programme.name,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconButton(
                            tooltip: 'Edit programme',
                            onPressed: () =>
                                _renameProgramme(department, programme),
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: _muted,
                              size: 19,
                            ),
                          ),
                          IconButton(
                            tooltip: expanded
                                ? 'Collapse programme'
                                : 'Expand programme',
                            onPressed: () => _toggleProgramme(programme),
                            icon: Icon(
                              expanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right,
                              color: _muted,
                            ),
                          ),
                          PopupMenuButton<String>(
                            tooltip: 'Programme actions',
                            onSelected: (value) {
                              if (value == 'remove') {
                                _removeProgramme(department, programme);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove programme'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () => _toggleProgramme(programme),
                    ),
                  ),
                  if (expanded)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final level in programme.levels)
                            _levelBadge(programme, level),
                          IconButton(
                            tooltip: 'Add academic level',
                            visualDensity: VisualDensity.compact,
                            onPressed: () => _addLevel(programme),
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: _purple,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddFacultyButton() {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: _badge,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: _addFaculty,
          borderRadius: BorderRadius.circular(14),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_box_outlined, color: _purple, size: 22),
                SizedBox(width: 12),
                Text(
                  'Add another faculty',
                  style: TextStyle(
                    color: _purple,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _lavender,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        children: [
          Icon(Icons.account_tree_outlined, color: _purple, size: 32),
          SizedBox(height: 10),
          Text(
            'Your academic structure starts here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _ink, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            'Add a faculty to begin organising departments and programmes.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 13),
          ),
        ],
      ),
    );
  }

  List<BoxShadow> get _rowShadow => [
    BoxShadow(
      color: _ink.withValues(alpha: 0.035),
      blurRadius: 5,
      offset: const Offset(0, 2),
    ),
  ];

  Widget _countBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _badge,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF34415D),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _codeBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _badge,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _purple,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

 
  Widget _levelBadge(_ProgrammeNode programme, String level) {
    return PopupMenuButton<String>(
      tooltip: 'Level actions',
      onSelected: (value) {
        if (value == 'delete') {
          _removeLevel(programme, level);
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 8),
              Text('Delete level'),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: _badge,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check,
              color: _green,
              size: 14,
            ),
            const SizedBox(width: 5),
            Text(
              level,
              style: const TextStyle(
                color: _purple,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.more_vert,
              color: _purple,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _removeLevel(
    _ProgrammeNode programme,
    String level,
  ) async {
    final confirmed = await _confirmRemoval(
      'Delete academic level?',
      'Are you sure you want to delete Level $level? '
          'This action will remove it from this programme.',
    );

    if (!mounted || !confirmed) return;

    if (!programme.levels.contains(level)) return;

    setState(() {
      programme.levels.remove(level);
    });

    _saveAcademicDraft();

    _showMessage('Level $level deleted successfully.');
  }


  Widget _smallAction({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: TextButton.styleFrom(
        backgroundColor: _badge,
        foregroundColor: _purple,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _toggleAll() {
    setState(() {
      _expandAll = !_expandAll;
      _expandedFaculties.clear();
      _expandedDepartments.clear();
      _expandedProgrammes.clear();

      if (_expandAll) {
        for (final faculty in _faculties) {
          _expandedFaculties.add(faculty.name);
          for (final department in faculty.departments) {
            _expandedDepartments.add(department.name);
            for (final programme in department.programmes) {
              _expandedProgrammes.add(programme.name);
            }
          }
        }
      }
    });
  }

  void _toggleFaculty(_FacultyNode faculty) {
    setState(() {
      if (!_expandedFaculties.remove(faculty.name)) {
        _expandedFaculties.add(faculty.name);
      }
      _syncExpandAll();
    });
  }

  void _toggleDepartment(_DepartmentNode department) {
    setState(() {
      if (!_expandedDepartments.remove(department.name)) {
        _expandedDepartments.add(department.name);
      }
      _syncExpandAll();
    });
  }

  void _toggleProgramme(_ProgrammeNode programme) {
    setState(() {
      if (!_expandedProgrammes.remove(programme.name)) {
        _expandedProgrammes.add(programme.name);
      }
      _syncExpandAll();
    });
  }

  void _syncExpandAll() {
    _expandAll =
        _faculties.isNotEmpty &&
        _faculties.every(
          (faculty) =>
              _expandedFaculties.contains(faculty.name) &&
              faculty.departments.every(
                (department) =>
                    _expandedDepartments.contains(department.name) &&
                    department.programmes.every(
                      (programme) =>
                          _expandedProgrammes.contains(programme.name),
                    ),
              ),
        );
  }

  void _saveAcademicDraft() {
  final faculties = _faculties.map(
    (faculty) => AcademicFacultyDraft(
      name: faculty.name,
      departments: faculty.departments
          .map(
            (department) => AcademicDepartmentDraft(
              name: department.name,
              code: department.code,
              programmes: department.programmes
                  .map(
                    (programme) => AcademicProgrammeDraft(
                      name: programme.name,
                      levels: List<String>.unmodifiable(
                        programme.levels,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    ),
  ).toList();

  ref
      .read(institutionRegistrationProvider.notifier)
      .updateAcademicFaculties(faculties);
}

  Future<String?> _askForName({
    required String title,
    required String label,
    String initialValue = '',
    String? hint,
  }) async {
    final controller = TextEditingController(text: initialValue);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: label, hintText: hint),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              Navigator.of(dialogContext).pop(value.trim());
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                Navigator.of(dialogContext).pop(value);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    controller.dispose();
    return result;
  }

  Future<void> _addFaculty() async {
    final name = await _askForName(
      title: 'Add faculty',
      label: 'Faculty name',
      hint: 'e.g. Faculty of Engineering',
    );
    if (!mounted || name == null) return;

    if (_faculties.any(
      (item) => item.name.toLowerCase() == name.toLowerCase(),
    )) {
      _showMessage('A faculty with that name already exists.');
      return;
    }

    setState(() {
      _faculties.add(_FacultyNode(name: name));
      _expandedFaculties.add(name);
      _expandAll = false;
    });

    _saveAcademicDraft();
  }

  Future<void> _renameFaculty(_FacultyNode faculty) async {
    final oldName = faculty.name;
    final name = await _askForName(
      title: 'Edit faculty',
      label: 'Faculty name',
      initialValue: oldName,
    );
    if (!mounted || name == null) return;

    if (_faculties.any(
      (item) =>
          !identical(item, faculty) &&
          item.name.toLowerCase() == name.toLowerCase(),
    )) {
      _showMessage('A faculty with that name already exists.');
      return;
    }

    setState(() {
      faculty.name = name;
      if (_expandedFaculties.remove(oldName)) {
        _expandedFaculties.add(name);
      }
      _syncExpandAll();
    });

    _saveAcademicDraft();
  }

  Future<void> _removeFaculty(_FacultyNode faculty) async {
    final confirmed = await _confirmRemoval(
      'Remove faculty?',
      'Remove "${faculty.name}" and its departments and programmes?',
    );
    if (!mounted || !confirmed) return;

    setState(() {
      _faculties.remove(faculty);
      _expandedFaculties.remove(faculty.name);
      for (final department in faculty.departments) {
        _expandedDepartments.remove(department.name);
        for (final programme in department.programmes) {
          _expandedProgrammes.remove(programme.name);
        }
      }
      _syncExpandAll();
    });

    _saveAcademicDraft();
  }

  Future<void> _addDepartment(_FacultyNode faculty) async {
    final name = await _askForName(
      title: 'Add department',
      label: 'Department name',
      hint: 'e.g. Electrical Engineering',
    );
    if (!mounted || name == null) return;

    if (faculty.departments.any(
      (item) => item.name.toLowerCase() == name.toLowerCase(),
    )) {
      _showMessage('That department already exists in this faculty.');
      return;
    }

    final code = await _askForName(
      title: 'Department code',
      label: 'Code',
      hint: 'e.g. EE',
    );
    if (!mounted || code == null) return;

    setState(() {
      faculty.departments.add(_DepartmentNode(name: name, code: code));
      _expandedFaculties.add(faculty.name);
      _expandedDepartments.add(name);
      _expandAll = false;
    });

    _saveAcademicDraft();
  }

  Future<void> _renameDepartment(
    _FacultyNode faculty,
    _DepartmentNode department,
  ) async {
    final oldName = department.name;
    final name = await _askForName(
      title: 'Edit department',
      label: 'Department name',
      initialValue: oldName,
    );
    if (!mounted || name == null) return;

    if (faculty.departments.any(
      (item) =>
          !identical(item, department) &&
          item.name.toLowerCase() == name.toLowerCase(),
    )) {
      _showMessage('That department already exists in this faculty.');
      return;
    }

    final code = await _askForName(
      title: 'Edit department code',
      label: 'Department code',
      initialValue: department.code,
    );
    if (!mounted || code == null) return;

    setState(() {
      department.name = name;
      department.code = code;
      if (_expandedDepartments.remove(oldName)) {
        _expandedDepartments.add(name);
      }
      _syncExpandAll();
    });

    _saveAcademicDraft();
  }

  Future<void> _removeDepartment(
    _FacultyNode faculty,
    _DepartmentNode department,
  ) async {
    final confirmed = await _confirmRemoval(
      'Remove department?',
      'Remove "${department.name}" and its programmes?',
    );
    if (!mounted || !confirmed) return;

    setState(() {
      faculty.departments.remove(department);
      _expandedDepartments.remove(department.name);
      for (final programme in department.programmes) {
        _expandedProgrammes.remove(programme.name);
      }
      _syncExpandAll();
    });

    _saveAcademicDraft();
  }

  Future<void> _addProgramme(_DepartmentNode department) async {
    final name = await _askForName(
      title: 'Add programme',
      label: 'Programme name',
      hint: 'e.g. B.Tech Mechanical Engineering',
    );
    if (!mounted || name == null) return;

    if (department.programmes.any(
      (item) => item.name.toLowerCase() == name.toLowerCase(),
    )) {
      _showMessage('That programme already exists in this department.');
      return;
    }

    setState(() {
      department.programmes.add(
        _ProgrammeNode(name: name, levels: ['100', '200', '300', '400']),
      );
      _expandedDepartments.add(department.name);
      _expandedProgrammes.add(name);
      _expandAll = false;
    });

    _saveAcademicDraft();
  }

  Future<void> _renameProgramme(
    _DepartmentNode department,
    _ProgrammeNode programme,
  ) async {
    final oldName = programme.name;
    final name = await _askForName(
      title: 'Edit programme',
      label: 'Programme name',
      initialValue: oldName,
    );
    if (!mounted || name == null) return;

    if (department.programmes.any(
      (item) =>
          !identical(item, programme) &&
          item.name.toLowerCase() == name.toLowerCase(),
    )) {
      _showMessage('That programme already exists in this department.');
      return;
    }

    setState(() {
      programme.name = name;
      if (_expandedProgrammes.remove(oldName)) {
        _expandedProgrammes.add(name);
      }
      _syncExpandAll();
    });

    _saveAcademicDraft();
  }

  Future<void> _removeProgramme(
    _DepartmentNode department,
    _ProgrammeNode programme,
  ) async {
    final confirmed = await _confirmRemoval(
      'Remove programme?',
      'Remove "${programme.name}" from this preview?',
    );
    if (!mounted || !confirmed) return;

    setState(() {
      department.programmes.remove(programme);
      _expandedProgrammes.remove(programme.name);
      _syncExpandAll();
    });

    _saveAcademicDraft();
  }

  Future<void> _addLevel(_ProgrammeNode programme) async {
    final level = await _askForName(
      title: 'Add academic level',
      label: 'Level number',
      hint: 'e.g. 500',
    );
    if (!mounted || level == null) return;

    final normalized = level.replaceAll(
      RegExp(r'^(level\s*)', caseSensitive: false),
      '',
    );

    if (programme.levels.contains(normalized)) {
      _showMessage('That academic level already exists.');
      return;
    }

    setState(() {
      programme.levels.add(normalized);
      programme.levels.sort(
        (a, b) => (int.tryParse(a) ?? 0).compareTo(int.tryParse(b) ?? 0),
      );
    });

    _saveAcademicDraft();
  }

  Future<bool> _confirmRemoval(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    return result == true;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _FacultyNode {
  _FacultyNode({required this.name, List<_DepartmentNode>? departments})
    : departments = departments ?? [];

  String name;
  final List<_DepartmentNode> departments;
}

class _DepartmentNode {
  _DepartmentNode({
    required this.name,
    required this.code,
    List<_ProgrammeNode>? programmes,
  }) : programmes = programmes ?? [];

  String name;
  String code;
  final List<_ProgrammeNode> programmes;
}

class _ProgrammeNode {
  _ProgrammeNode({required this.name, required this.levels});

  String name;
  final List<String> levels;
}
