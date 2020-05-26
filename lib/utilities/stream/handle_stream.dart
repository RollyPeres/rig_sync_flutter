class HandleStream {
  final String incomingData;

  HandleStream(this.incomingData);

  // incomingData format: "[V1](014816.00,000002.44)*[D1](014816.00,-00005.83)*"

// Prase out the data string to find the naming keys, returns a list of strings
  List<String> dataKeys() {
    List<String> keys = [];

    List<String> parsedBuffer = incomingData.split("*");
    parsedBuffer.removeLast();
    // PARSED BUFFER - [V1(000358.00,-00001.09), D1(000358.00,-00002.07)]

    RegExp keysRegx = new RegExp(r'(?<=\[)(.*?)(?=\])');

    Iterable<RegExpMatch> matches = keysRegx.allMatches(incomingData);

    matches.forEach((match) {
      keys.add(incomingData.substring(match.start, match.end));
    });
    print(keys);
    return keys;
  }

  // Function that uses the key to pull out the data related to that key
  List<double> getKeyData(key) {
    double x;
    double y;

    try {
      //incoming data format - [V1](000019.00,000007.23)*[D1](000019.00,000010.27)*
      print('incoming: $incomingData');
      List<String> parsedBuffer = incomingData.split("*");
      parsedBuffer.removeLast();
      // PARSED BUFFER - [[V1](000358.00,-00001.09), [D1](000358.00,-00002.07)]
      print('Parsed Buff: $parsedBuffer');
      for (var string in parsedBuffer) {
        if (string.startsWith('[$key]')) {
          RegExp regex = new RegExp(r"\(([^)]+)\)");
          String v1String = regex.firstMatch(string).group(1);

          List v1List = v1String.split(',');
          print('in here');
          x = double.parse(v1List[0]);
          y = double.parse(v1List[1]);
        }
      }
    } catch (e) {
      print(e);
    }
    return [x, y];
  }
}
