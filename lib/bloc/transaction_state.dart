import 'package:banking_app/api/transactions/models/transaction.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionState {
}
  
class InitialTransactionState extends TransactionState {

}

class TransactionsNotLoaded extends TransactionState{}

class TransactionsLoading extends TransactionState{}

class TransactionsLoaded extends TransactionState{
  final List<BankTransaction> transactionList;
  TransactionsLoaded({this.transactionList});
}
