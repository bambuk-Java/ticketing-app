using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace ticketing.app.demo;

entity Tickets : cuid, managed {
  user        : Association to Users @restrict.to: ['Admin', 'Supporter'];
  title       : String @title: 'Title' @mandatory;
  status      : Association to Status @mandatory default 'Open';
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
  userName : String @restrict.to: ['Admin', 'Supporter'];
  email    : EmailAddress @restrict.to: ['Admin', 'Supporter'];
  tickets  : Association to many Tickets on tickets.user = $self ;
}

entity Status : CodeList {
  key code     : String;
  criticality  : Integer;
}

type EmailAddress : String;
type PhoneNumber  : String;
