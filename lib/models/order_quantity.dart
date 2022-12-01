import 'package:demo/config.dart';

class OrderQuantity {
  final int min;
  final int max;
  final int step;
  OrderQuantity({
    this.min = minOrderQuantity,
    this.max = maxOrderQuantity,
    this.step = orderQuantityStep,
  });

  OrderQuantity copyWith({
    int? min,
    int? max,
    int? step,
  }) {
    return OrderQuantity(
      min: min ?? this.min,
      max: max ?? this.max,
      step: step ?? this.step,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'step': step,
    };
  }

  factory OrderQuantity.fromJson(Map<String, dynamic> map) {
    return OrderQuantity(
      min: map['min'],
      max: map['max'],
      step: map['step'],
    );
  }

  @override
  String toString() => 'ProductQuantity(min: $min, max: $max, step: $step)';

  String toCartQL() {
    return '''
      order_quantity: {
        min: $min
        max: $max
        step: $step
      }
    ''';
  }
}
