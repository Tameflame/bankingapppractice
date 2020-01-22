import 'dart:async';
import 'package:banking_app/api/transactions/models/transaction.dart';
import 'package:banking_app/api/transactions/transaction_api.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  // final TransactionStreamer streamer;
  // StreamSubscription subscription;

  // TransactionBloc(this.streamer);

  @override
  TransactionState get initialState => InitialTransactionState();

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is GetTransactions) {
      // List<BankTransaction> _transactions2 = [];

      // // TODO: FIGURE HOW TO HOOK UP A STREAM TO FUCKING BLOC
      // subscription?.cancel();
      // subscription = streamer.transactions().listen((onData) {
      //   // either  it's documentchanges or documents
      //   onData.documents.forEach((documentSnapshot) {
      //     BankTransaction _transaction = BankTransaction.fromMap(documentSnapshot.data);
      //     _transactions2.add(_transaction);
      //   });
      // });
      // yield TransactionsLoaded(transactionList: _transactions2);

      // this is the normal code, so don't fuck it  up
      List<BankTransaction> _transactions = await getTransactions();
      yield TransactionsLoaded(transactionList: _transactions);
    }
  }

  @override Future<void> close() {
    // subscription.cancel();
    return super.close();
  }
}
