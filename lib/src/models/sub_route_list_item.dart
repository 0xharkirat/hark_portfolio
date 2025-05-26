

class SubRouteListItem {
  final String heading;
  final String description;
  final String routeId;
  final RouteType type;

  SubRouteListItem({
    required this.heading,
    required this.description,
    required this.routeId,
    required this.type,
  });
}

enum RouteType { subLab, subPoem }

enum LabSubRoute {
  holdToActionButton('hold-to-action-button'),
  animatedRotateButton('animated-rotate-button'),
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
        "This Flutter widget is based on [Emil Kowalski's](https://emilkowal.ski/ui/building-a-hold-to-delete-component) Hold to delete button.",
    routeId: LabSubRoute.holdToActionButton.routeId,
    type: RouteType.subLab,
  ),
  SubRouteListItem(
    heading: 'Rough Notation Flutter',
    description: "Create animated, hand-drawn-style annotations on widgets.",
    routeId: LabSubRoute.roughNotation.routeId,
    type: RouteType.subLab,
  ),
  SubRouteListItem(
    heading: 'Animated Rotate Button',
    description:
        "This Flutter widget is based on [Jakub Krehel's](https://x.com/jakubkrehel/status/1911816000107901308) tweet.",
    routeId: LabSubRoute.animatedRotateButton.routeId,
    type: RouteType.subLab,
  ),
];

enum PoemSubRoute {
  girlOnTheTrain("girl-on-the-train");

  final String routeId;
  const PoemSubRoute(this.routeId);
  static PoemSubRoute fromRouteId(String routeId) {
    return PoemSubRoute.values.firstWhere(
      (element) => element.routeId == routeId,
      orElse: () => throw Exception('Invalid route ID: $routeId'),
    );
  }
}

final List<SubRouteListItem> poemListItems = [
  SubRouteListItem(
    heading: "Girl on the train",
    description:
        "A real story of my three train rides with a kind & beautiful girl. It  captures the feeling of those moments just as they were.",
    routeId: PoemSubRoute.girlOnTheTrain.routeId,
    type: RouteType.subPoem,
  ),
];
