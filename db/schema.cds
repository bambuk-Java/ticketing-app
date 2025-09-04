using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace ticketing.app.demo;

entity Tickets : cuid, managed {
  user        : Association to Users;
  title       : String @title: 'Title' @mandatory;
  status      : Association to Status @mandatory default 'O';
  timestamp   : type of managed:createdAt @cds.on.insert: $now;
  description : String @mandatory;
  answers     : Composition of many Answers on answers.ticket = $self;
}

entity Answers : cuid, managed {
  author      : type of managed:createdBy;
  timestamp   : type of managed:createdAt @cds.on.insert: $now;
  message     : String;
  ticket      : Association to Tickets;
}

entity Users : cuid, managed {
  userName : String;
  email    : EmailAddress;
  tickets  : Association to many Tickets on tickets.user = $self ;
}

entity Status : CodeList {
  key code     : String;
  criticality  : Integer;
}

@odata.singleton @cds.persistence.skip
entity Configuration {
    key ID: String;
    isAdmin : Boolean;
}

type EmailAddress : String;
type PhoneNumber  : String;
