class ElectricDigitalSketchException implements Exception{

  ElectricDigitalSketchException(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() {
    if(stackTrace == null){
      return '$message\n$stackTrace';
    }
    return message;
  }

}
