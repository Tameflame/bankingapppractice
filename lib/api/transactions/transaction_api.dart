import 'package:cloud_firestore/cloud_firestore.dart';
import './models/transaction.dart';

// This will be an api for transactions
// The bloc will retrieve transactoins
// and update a master transaction list
// This will also contain methods for updating transactions

// Read all transactions for this user, for a specified period
// period comes in the form of {"Start Date" : DateTime, "End Date" : DateTime}
Future<List<BankTransaction>> getTransactions(/*String uid, Map<String, DateTime> period*/) async {
  List<BankTransaction> _transactions = [];

  QuerySnapshot _snapshot = await Firestore.instance
      // .collection("users/$uid/transactions")
      .collection("users/test/transactions")
      .getDocuments();

  _snapshot.documents.forEach((document) {
    BankTransaction _transaction = BankTransaction.fromMap(document.data);
    _transactions.add(_transaction);
  });

  _transactions.sort((a, b) => a.date.compareTo(b.date));
  _transactions = _transactions.reversed.toList();

  return _transactions;
}

// TODO: Get rid of thisor get this stream to work with my bloc
class TransactionStreamer {
  Stream<QuerySnapshot> transactions() {
    return Firestore.instance.collection("users/test/transactions").snapshots();
  }
}

// Add new transaction for this user

// Delete specified transaction
// note that this shouldn't be done on the user app
