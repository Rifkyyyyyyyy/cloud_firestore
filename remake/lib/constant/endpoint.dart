enum Endpoint {
  home,
  addTask,
  profile,
  analytics,
  calendar
} 

String pathEndpoint({required Endpoint endpoints, String? params}) {
  String path = '';
  switch (endpoints) {
    case Endpoint.home:
      path = '/homepage';
      break;

    case Endpoint.addTask:
      path = '/addTask'; 
      break;

    case Endpoint.profile:
      path = '/profile';
      break;

    case Endpoint.analytics:
      path = '/analytics';
      break;

    case Endpoint.calendar:
      path = '/calendar';
      break;
  }
  return path;
}
