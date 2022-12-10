import 'dart:typed_data';

/// ASCII character code for '0'
const $0 = 48;

/// ASCII character code for '1'
const $1 = 49;

/// ASCII character code for '9'
const $9 = 57;

/// Only supports unsigned decimal values
class BigNum {
  BigNum._(this._digits, this._used);

  static final zero = BigNum._(Uint8List.fromList([0]), 1);

  static final one = BigNum._(Uint8List.fromList([1]), 1);

  Uint8List _digits;
  int _used;

  bool get isZero => (this == zero || (_used == 1 && _digits[0] == 0));

  factory BigNum.fromInt(int value) {
    return parse(value.toString()); // ugh
  }

  /// Only supports decimal values
  static BigNum parse(String value) {
    final codeUnits = value.codeUnits;
    final digits = Uint8List(value.length * 2);
    for (var j = 0, i = value.length - 1; i >= 0; i--) {
      final char = codeUnits[i];
      if (char >= $0 && char <= $9) {
        digits[j++] = char - $0;
      } else {
        throw 'Invalid decimal number';
      }
    }
    return BigNum._(digits, value.length);
  }

  BigNum operator +(BigNum other) {
    if (isZero) return other;
    if (other.isZero) return this;
    var end = (_used > other._used) ? _used : other._used;
    final digits = Uint8List(end * 2);
    digits.fillRange(0, digits.length, 0);
    for (var i = 0; i < end; i++) {
      var value = (digits[i] + _digits[i] + other._digits[i]);
      if (value >= 10) {
        value -= 10;
        if (i == end - 1) {
          end++;
        }
        digits[i + 1]++;
      }
      digits[i] = value;
    }
    return BigNum._(digits, end);
  }

  @override
  String toString() {
    final buffer = Uint8List(_used);
    for (var j = 0, i = _used - 1; i >= 0; i--) {
      buffer[j++] = $0 + _digits[i];
    }
    return String.fromCharCodes(buffer);
  }
}
