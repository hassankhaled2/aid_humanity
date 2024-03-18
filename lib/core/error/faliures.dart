abstract class Failure
{
  final String message;

  Failure(this.message);
}

class OfflineFaliure extends Failure{
  OfflineFaliure(super.message);
}

class ServerFaliure extends Failure{
  ServerFaliure(super.message);
}

class NoDataFaliure extends Failure{
  NoDataFaliure(super.message);
  
}
