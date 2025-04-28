class SubRouteListItem {
  final String heading;
  final String description;
  final String routeId;

  SubRouteListItem({
    required this.heading,
    required this.description,
    required this.routeId,
  });
}

enum LabSubRoute {
  holdToActionButton('hold-to-action-button'),
  roughNotation('rough-notation');

  final String routeId;
  const LabSubRoute(this.routeId);

  static LabSubRoute fromRouteId(String routeId) {
    return LabSubRoute.values.firstWhere(
      (element) => element.routeId == routeId,
      orElse: () => throw Exception('Invalid route ID: $routeId'),
    );
  }
}

final List<SubRouteListItem> labListItems = [
  SubRouteListItem(
    heading: 'Hold To Action Button',
    description:
        "This Flutter widget is based on the [Emil Kowalski's](https://emilkowal.ski/ui/building-a-hold-to-delete-component) Hold to delete button.",
    routeId: LabSubRoute.holdToActionButton.routeId,
  ),
  SubRouteListItem(
    heading: 'Rough Notation Flutter',
    description:
        "Create animated, hand-drawn-style annotations on widgets.",
    routeId: LabSubRoute.roughNotation.routeId,
  ),
];
