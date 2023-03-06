import 'package:intl/intl.dart' as intl;

formatCurrency(String? symbol) => intl.NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: symbol,
      decimalDigits: 2,
    );
