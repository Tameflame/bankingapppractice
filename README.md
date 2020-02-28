# banking_app

Developing a fictional banking app.

Trying to implement a nice Monzo-like UI, with Google Firebase backend.

Features: 
- Authentication Flow
    - Fully implemented username+password using firebaseAuth
    - Need to add: Apple Sign in Google Sign in
- See transactions 
    - Got it linked to a firebase database (cloud firestore) with streamed real time updates
- Graph of account value 
    - shows mock data, need to implement fetching account values from cloud
- Instant updates to transactions
    - Mostly implemented
    - Need to standardise information.
    - Need to make sure data transfer is encrypted
- Push notifications
    - Not yet implemented

