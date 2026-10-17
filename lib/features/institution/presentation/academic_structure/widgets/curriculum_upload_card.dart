import 'package:flutter/material.dart';

class CurriculumUploadCard extends StatefulWidget {
  const CurriculumUploadCard({
    super.key,
    this.onUpload,
    this.onManualEntry,
  });

  final VoidCallback? onUpload;
  final VoidCallback? onManualEntry;

  @override
  State<CurriculumUploadCard> createState() =>
      _CurriculumUploadCardState();
}

class _CurriculumUploadCardState extends State<CurriculumUploadCard> {
  static const Color _navy = Color(0xFF272F43);
  ///static const Color _slate = Color(0xFF454E62);
  static const Color _lavender = Color(0xFFDCD6FF);
  static const Color _violet = Color(0xFF3525CD);

  String? _selectedFileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _navy,
            Color(0xFF292E4A),
            _violet,
          ],
          stops: [0.0, 0.58, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _navy.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card heading.
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF414B60),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: _lavender,
                      size: 27,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI-ASSISTED SETUP',
                        style: TextStyle(
                          color: _lavender,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'General curriculum',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Already have your curriculum document? Upload it and '
              'CourseMind can use it as the foundation for your '
              'academic structure.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 22),

            // Upload area.
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: _handleUpload,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF454E62),
                        Color(0xFF5148A0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.cloud_upload_outlined,
                          size: 34,
                          color: _lavender,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _selectedFileName ?? 'Click to upload document',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedFileName == null
                            ? 'PDF, DOCX up to 10MB'
                            : 'File selected for this preview.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: _lavender,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_selectedFileName != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: _lavender,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedFileName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Remove selected file',
                    onPressed: () {
                      setState(() {
                        _selectedFileName = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: _lavender,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),

            // OR divider.
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF49477F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Manual structure action.
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: widget.onManualEntry ?? _showManualEntryMessage,
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_note_rounded,
                          color: Colors.white,
                          size: 23,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Manually add basic structure',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleUpload() {
    if (widget.onUpload != null) {
      widget.onUpload!.call();
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Curriculum upload'),
        content: const Text(
          'File selection will be connected in the next integration step. '
          'PDF and DOCX files up to 10MB will be supported.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showManualEntryMessage() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Manual academic structure'),
        content: const Text(
          'Manual academic structure entry will be connected '
          'in the next integration step.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}