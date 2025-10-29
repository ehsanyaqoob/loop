import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loop/export.dart';
import 'package:loop/widget/common/dot-loader.dart';

class CommonImageView extends StatefulWidget {
  final String? url;
  final String? imagePath;
  final String? svgPath;
  final File? file;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit fit;
  final Color? color;

  const CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.color,
  });

  @override
  State<CommonImageView> createState() => _CommonImageViewState();
}

class _CommonImageViewState extends State<CommonImageView> {
  static final Set<String> _failedUrls = {}; // Static cache for failed URLs
  
  bool get _isUrlFailed {
    final url = widget.url ?? widget.imagePath;
    return url != null && _failedUrls.contains(url);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    // Priority 1: SVG Path
    if (widget.svgPath != null && widget.svgPath!.isNotEmpty) {
      return SvgPicture.asset(
        widget.svgPath!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        color: widget.color,
      );
    }

    // Priority 2: File
    if (widget.file != null && widget.file!.path.isNotEmpty) {
      return Image.file(
        widget.file!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        color: widget.color,
      );
    }

    // Priority 3: URL (Network Image) - Check if URL already failed
    final url = widget.url ?? widget.imagePath;
    if (url != null && url.isNotEmpty) {
      if (_isUrlFailed) {
        return _buildErrorWidget(); // Skip loading if URL already failed
      }

      if (_isNetworkImage(url)) {
        return CachedNetworkImage(
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          imageUrl: url,
          color: widget.color,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) {
            // Cache the failed URL
            _failedUrls.add(url);
            return _buildErrorWidget();
          },
        );
      } else {
        // It's a local asset path
        return Image.asset(
          url,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
          errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
        );
      }
    }

    // Fallback: Error Widget
    return _buildErrorWidget();
  }

  Widget _buildPlaceholder() {
    return Container(
      height: widget.height,
      width: widget.width,
      color: context.card,
      child: Center(
        child: LoopLoader(size: 20), // Use LoopLoader for loading state
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: widget.height,
      width: widget.width,
      color: context.card,
      child: Center(
        child: LoopLoader(size: 20), // FIX: Use LoopLoader instead of icon for 404
      ),
    );
  }

  bool _isNetworkImage(String path) {
    return path.startsWith('http://') ||
        path.startsWith('https://') ||
        path.startsWith('www.') ||
        path.contains('.com') ||
        path.contains('.net') ||
        path.contains('.org');
  }
}