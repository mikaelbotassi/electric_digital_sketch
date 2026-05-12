import 'dart:io';

import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({required this.file, super.key});

  final File file;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {

  bool _isDownloading = false;

  String get _suggestedFileName {
    final segments = widget.file.uri.pathSegments;
    final currentName = segments.isEmpty ? '' : segments.last;
    if (currentName.isNotEmpty) {
      return currentName;
    }
    return 'electric_sketch_${DateTime.now().millisecondsSinceEpoch}.png';
  }

  Future<File?> _saveOrShareImage() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final result = await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile(
              widget.file.path,
              mimeType: 'image/png',
              name: _suggestedFileName,
            ),
          ],
          fileNameOverrides: [_suggestedFileName],
          title: 'Salvar imagem',
          text: 'Imagem exportada',
        ),
      );
      if (result.status == ShareResultStatus.dismissed) {
        return null;
      }
      return widget.file;
    }

    final location = await getSaveLocation(
      suggestedName: _suggestedFileName,
      acceptedTypeGroups: const [
        XTypeGroup(
          label: 'PNG',
          extensions: ['png'],
          mimeTypes: ['image/png'],
          uniformTypeIdentifiers: ['public.png'],
        ),
      ],
      confirmButtonText: 'Salvar',
    );

    if (location == null) {
      return null;
    }

    return widget.file.copy(location.path);
  }

  Future<void> _downloadImage() async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);
    try {
      final savedFile = await _saveOrShareImage();
      if (!mounted) return;

      final message = savedFile == null
          ? 'Salvamento cancelado.'
          : 'Imagem salva em ${savedFile.path}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButtonWidget(
      onPressed: _isDownloading ? null : _downloadImage,
      color: colors.primary,
      enabled: !_isDownloading,
      icon: defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform ==
              TargetPlatform.iOS
          ? PhosphorIconsRegular.export
          : PhosphorIconsRegular.download,
    );
  }
}
