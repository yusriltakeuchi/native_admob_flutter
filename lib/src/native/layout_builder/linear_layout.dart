part of 'layout_builder.dart';

const String HORIZONTAL = 'horizontal';
const String VERTICAL = 'vertical';

class AdLinearLayout extends AdView {
  final String orientation;
  final List<AdView> children;

  final LayoutGravity gravity;

  AdLinearLayout({
    this.orientation = VERTICAL,
    @required this.children,
    EdgeInsets padding,
    EdgeInsets margin,
    AdDecoration decoration,
    double width,
    double height,
    double elevation,
    Color elevationColor,
    this.gravity,
  }) : super(
          id: 'linear_layout',
          viewType: 'linear_layout',
          padding: padding,
          margin: margin,
          decoration: decoration,
          width: width ?? MATCH_PARENT,
          height: height ?? WRAP_CONTENT,
          elevation: elevation,
          elevationColor: elevationColor,
        );

  Map<String, dynamic> toJson() {
    final json = super.toJson();
    List<Map<String, dynamic>> childrenData = [];
    for (final child in children) childrenData.add(child.toJson());
    json.addAll({
      'children': childrenData,
      'orientation': orientation,
      'gravity': _layoutGravityName(gravity ?? LayoutGravity.top),
    });
    return json;
  }
}

enum LayoutGravity {
  center,
  center_horizontal,
  center_vertical,
  left,
  right,
  top,
  bottom
}

String _layoutGravityName(LayoutGravity g) {
  return g.toString().replaceAll('LayoutGravity.', '').toLowerCase();
}

class AdSingleChildView extends AdLinearLayout {
  AdSingleChildView({@required AdView child}) : super(children: [child]);
}

class AdExpanded extends AdSingleChildView {
  final double flex;

  AdExpanded({
    @required this.flex,
    @required AdView child,
  })  : assert(flex >= 0),
        super(child: child);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({'layout_weight': flex});
    return json;
  }
}
