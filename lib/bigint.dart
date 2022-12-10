late List<BigInt?> cache;

void main(List<String> arguments) {
  // calculate the first 50,000 indexes in the fibonacci sequence
  final count = 50000;

  // pre-allocate enough space to hold all the results
  cache = List.filled(count + 1, null);
  cache[0] = BigInt.zero;
  cache[1] = BigInt.one;

  final stopWatch = Stopwatch()..start();

  /// recursive fibonacci sequencer
  /// requires: cache[0] and cache[1] to be pre-initialized
  BigInt fibonacci(int n) {
    return cache[n] ?? (fibonacci(n - 2) + fibonacci(n - 1));
  }

  for (int n = 2; n <= count; n++) {
    cache[n] = fibonacci(n);
  }

  stopWatch.stop();

  // display every 50th entry
  final step = count ~/ 50;
  for (int n = 0; n <= count; n += step) {
    final value = cache[n].toString();
    print('fibonacci[$n] = (${value.length} digits) $value\n');
  }

  print('completed in ${stopWatch.elapsedMicroseconds / Duration.microsecondsPerSecond} '
      'seconds aka ${stopWatch.elapsedMilliseconds}ms');
}
