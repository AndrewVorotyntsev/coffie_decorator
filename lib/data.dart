abstract class Beverage {
  String get description;

  List<String> get composition;

  double cost();
}

abstract class CondimentDecorator extends Beverage {
  String get description;
}

class Espresso extends Beverage {
  @override
  String get description => 'Espresso';

  @override
  List<String> get composition => ['Espresso'];

  @override
  double cost() => 30;
}

class Cappuccino extends Beverage {
  @override
  String get description => 'Cappuccino';

  @override
  List<String> get composition => ['Cappuccino'];

  @override
  double cost() => 60;
}

class Latte extends Beverage {
  @override
  String get description => 'Latte';

  @override
  List<String> get composition => ['Latte'];

  @override
  double cost() => 70;
}

class Syrup extends CondimentDecorator {
  final Beverage beverage;

  Syrup(this.beverage);

  @override
  String get description => "${beverage.description} \nSyrup";

  @override
  List<String> get composition => beverage.composition + ['Syrup'];

  @override
  double cost() => beverage.cost() + 10;
}

class Milk extends CondimentDecorator {
  final Beverage beverage;

  @override
  List<String> get composition => beverage.composition + ['Milk'];

  Milk(this.beverage);

  @override
  String get description => "${beverage.description} \nMilk";

  @override
  double cost() => beverage.cost() + 20;
}
