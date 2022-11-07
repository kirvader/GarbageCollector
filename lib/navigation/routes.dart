abstract class Routes {
  static const main = Paths.main;
  static const camera = Paths.camera;
  static const categories = Paths.categories;
  static const objects = Paths.objects;
  static const settings = Paths.settings;
  static const map = Paths.map;
  static const info = Paths.categories + Paths.info;
  static const nodeAddMap = Paths.nodeAddMap;
  static const nodeAddForm = Paths.nodeAddForm;
}

abstract class Paths {
  static const main = '/';
  static const camera = '/camera';
  static const info = '/info';
  static const categories = '/categories';
  static const objects = '/objects';
  static const settings = '/settings';
  static const map = '/map';
  static const nodeAddMap = '/nodeAppMap';
  static const nodeAddForm = '/nodeAppForm';
}