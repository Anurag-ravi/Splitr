import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('http://localhost/v1') // Your Appwrite Endpoint
    .setProject('63bbf62552c988a6a113')         // Your project ID
    .setSelfSigned(status: true);        // For self signed certificates, only use for development

Account account = Account(client);
Storage storage = Storage(client);
Realtime realtime = Realtime(client);