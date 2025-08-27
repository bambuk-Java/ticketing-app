using {ticketing.app.demo as my} from '../db/schema';


@requires: 'authenticated-user'
service ProcessorService {

    @restrict: [{grant: ['READ'], to: ['Admin', 'Support']}]
    entity Users as projection on my.Users;

    @odata.draft.enabled
    @restrict: [
        { grant: ['READ', 'CREATE'], to: 'Viewer', where: 'createdBy = $user' },
        { grant: ['READ','CREATE','UPDATE', 'DELETE'], to: 'Admin' }
    ]
    entity Tickets as projection on my.Tickets {
        ID @(restrict.to: ['Admin','Supporter']),
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
        { grant: 'READ', to: ['Viewer','Admin'] },
        { grant: ['CREATE','UPDATE'], to: ['Admin'] }
    ]
    entity Answers as projection on my.Answers;
}