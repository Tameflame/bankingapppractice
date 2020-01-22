import 'package:meta/meta.dart';

@immutable
abstract class TransactionEvent {}

class GetTransactions extends TransactionEvent{

}

class UpdateTransactions extends TransactionEvent{

}