using {ticketing.app.demo as my} from '../db/schema';


@requires: ['Supporter', 'Admin', 'Viewer']
service ProcessorService {

    @readonly
    entity Users as projection on my.Users;

    @odata.draft.enabled
    @restrict: [
        { grant: ['READ', 'CREATE'], to: 'Viewer', where: 'createdBy = $user' },
        { grant: ['READ','CREATE','UPDATE', 'DELETE'], to: 'Admin' },
        { grant: ['READ', 'CREATE', 'UPDATE'], to: 'Supporter'}
    ]
    entity Tickets as projection on my.Tickets {
        ID,
        title,
        status,
        description,
        answers,
        user,
        createdBy
    };
    @readonly
    entity Status as projection on my.Status;

    @restrict: [
        { grant: 'READ', to: ['Viewer','Admin', 'Supporter'] },
        { grant: ['CREATE','UPDATE', 'DELETE'], to: ['Admin', 'Supporter']},
    ]
    entity Answers as projection on my.Answers;
}