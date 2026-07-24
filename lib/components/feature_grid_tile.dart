import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FeatureGridTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool hasFavoriteStar;
  final bool isFavorite;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFavoriteToggle;
  final int? badgeCount;

  const FeatureGridTile({
    super.key,
    required this.icon,
    required this.label,
    this.hasFavoriteStar = false,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.badgeCount,
  });

  @override
  State<FeatureGridTile> createState() => _FeatureGridTileState();
}

class _FeatureGridTileState extends State<FeatureGridTile>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: Material(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.icon, size: 36, color: AppColors.primaryRed),
                      const SizedBox(height: 8),
                      Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.tileLabel,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (widget.hasFavoriteStar)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => widget.onFavoriteToggle?.call(!widget.isFavorite),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, anim) => ScaleTransition(
                          scale: anim,
                          child: child,
                        ),
                        child: Icon(
                          widget.isFavorite ? Icons.star : Icons.star_border,
                          key: ValueKey(widget.isFavorite),
                          color: AppColors.starYellow,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                if (widget.badgeCount != null && widget.badgeCount! > 0)
                  Positioned(
                    top: 4,
                    right: widget.hasFavoriteStar ? 28 : 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: const BoxDecoration(
                        color: AppColors.badgeRed,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${widget.badgeCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
