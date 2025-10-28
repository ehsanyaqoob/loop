import 'package:loop/export.dart';
class AppSizes {
  // Default padding
  static const DEFAULT = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
  static const HORIZONTAL = EdgeInsets.symmetric(horizontal: 20);
  static const VERTICAL = EdgeInsets.symmetric(vertical: 16);

  // Screen edge padding variations
  static const SCREEN_PADDING = EdgeInsets.all(20);
  static const SCREEN_PADDING_SMALL = EdgeInsets.all(16);
  static const SCREEN_PADDING_LARGE = EdgeInsets.all(24);

  // Horizontal padding variations
  static const HORIZONTAL_SMALL = EdgeInsets.symmetric(horizontal: 16);
  static const HORIZONTAL_LARGE = EdgeInsets.symmetric(horizontal: 24);
  static const HORIZONTAL_XLARGE = EdgeInsets.symmetric(horizontal: 32);

  // Vertical padding variations
  static const VERTICAL_SMALL = EdgeInsets.symmetric(vertical: 12);
  static const VERTICAL_LARGE = EdgeInsets.symmetric(vertical: 20);
  static const VERTICAL_XLARGE = EdgeInsets.symmetric(vertical: 24);

  // Symmetric padding combinations
  static const SYMMETRIC_SMALL = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const SYMMETRIC_MEDIUM = EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  static const SYMMETRIC_LARGE = EdgeInsets.symmetric(horizontal: 24, vertical: 20);

  // All sides equal
  static const ALL_SMALL = EdgeInsets.all(8);
  static const ALL_MEDIUM = EdgeInsets.all(16);
  static const ALL_LARGE = EdgeInsets.all(24);
  static const ALL_XLARGE = EdgeInsets.all(32);

  // Left/Right only
  static const LEFT_RIGHT_SMALL = EdgeInsets.only(left: 16, right: 16);
  static const LEFT_RIGHT_MEDIUM = EdgeInsets.only(left: 20, right: 20);
  static const LEFT_RIGHT_LARGE = EdgeInsets.only(left: 24, right: 24);

  // Top/Bottom only
  static const TOP_BOTTOM_SMALL = EdgeInsets.only(top: 12, bottom: 12);
  static const TOP_BOTTOM_MEDIUM = EdgeInsets.only(top: 16, bottom: 16);
  static const TOP_BOTTOM_LARGE = EdgeInsets.only(top: 20, bottom: 20);

  // Individual sides
  static const TOP_SMALL = EdgeInsets.only(top: 8);
  static const TOP_MEDIUM = EdgeInsets.only(top: 16);
  static const TOP_LARGE = EdgeInsets.only(top: 24);

  static const BOTTOM_SMALL = EdgeInsets.only(bottom: 8);
  static const BOTTOM_MEDIUM = EdgeInsets.only(bottom: 16);
  static const BOTTOM_LARGE = EdgeInsets.only(bottom: 24);

  static const LEFT_SMALL = EdgeInsets.only(left: 8);
  static const LEFT_MEDIUM = EdgeInsets.only(left: 16);
  static const LEFT_LARGE = EdgeInsets.only(left: 24);

  static const RIGHT_SMALL = EdgeInsets.only(right: 8);
  static const RIGHT_MEDIUM = EdgeInsets.only(right: 16);
  static const RIGHT_LARGE = EdgeInsets.only(right: 24);

  // Card padding
  static const CARD_PADDING = EdgeInsets.all(16);
  static const CARD_PADDING_SMALL = EdgeInsets.all(12);
  static const CARD_PADDING_LARGE = EdgeInsets.all(20);

  // List tile padding
  static const LIST_TILE_PADDING = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const LIST_TILE_DENSE = EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  // Button padding
  static const BUTTON_PADDING = EdgeInsets.symmetric(horizontal: 24, vertical: 12);
  static const BUTTON_PADDING_SMALL = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const BUTTON_PADDING_LARGE = EdgeInsets.symmetric(horizontal: 32, vertical: 16);

  // Input field padding
  static const INPUT_FIELD_PADDING = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const INPUT_FIELD_DENSE = EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  // Section spacing
  static const SECTION_SPACING = EdgeInsets.only(bottom: 32);
  static const SECTION_SPACING_SMALL = EdgeInsets.only(bottom: 24);
  static const SECTION_SPACING_LARGE = EdgeInsets.only(bottom: 40);

  // Grid spacing
  static const GRID_PADDING = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const GRID_ITEM_PADDING = EdgeInsets.all(8);
}