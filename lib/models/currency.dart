import 'enum_currency.dart';

class Currency {
  CurrencyCode? code;
  String? symbol;
  String? thousandsSeparator;
  String? decimalSeparator;
  int? decimalDigits;

  Currency({
    this.code,
    this.symbol,
    this.thousandsSeparator,
    this.decimalSeparator,
    this.decimalDigits,
  });

  Currency.fromJson(Map<String, dynamic> json) {
    code = json['code'] != null ? CurrencyCode.values[json['code']] : null;
    symbol = json['symbol'];
    thousandsSeparator = json['thousandsSeparator'];
    decimalSeparator = json['decimalSeparator'];
    decimalDigits = json['decimalDigits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code != null ? code!.index : null;
    data['symbol'] = symbol;
    data['thousandsSeparator'] = thousandsSeparator;
    data['decimalSeparator'] = decimalSeparator;
    data['decimalDigits'] = decimalDigits;
    return data;
  }

  @override
  String toString() {
    return 'Currency{code: $code, symbol: $symbol, thousandsSeparator: $thousandsSeparator, decimalSeparator: $decimalSeparator, decimalDigits: $decimalDigits}';
  }
}
