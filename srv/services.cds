using {ticketing.app.demo as my} from '../db/schema';

/**
 * Service used by personnel 'processors'
 */
@requires: ['Admin', 'Supporter']
service SupportAdminService {    
    @readonly
    entity Users as projection on my.Users;

    @odata.draft.enable
    @cds.redirection.target
    @restrict: [
        {grant: ['READ', 'UPDATE'], to: 'Supporter'},
        {grant: ['CREATE', 'READ', 'UPDATE', 'DELETE'], to: 'Admin'}
    ]

    entity Tickets as projection on my.Tickets  {
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
        { grant: ['CREATE','READ', 'UPDATE', 'DELETE'], to:[ 'Admin', 'Supporter']}
    ]
    entity Answers as projection on my.Answers;
}

service ViewerService{
@requires : 'Viewer'
    @restrict: [
        { grant: ['CREATE','READ','UPDATE','DELETE'], to: 'Viewer', where: 'createdBy = $user' },
    ]
    entity MyTickets as projection on my.Tickets{
        ID,
        title,
        status,
        description,
        answers,
        createdBy
    }

    @restrict: [
        { grant: ['READ'], to: 'Viewer'}
    ]
    entity Answers as projection on my.Answers;
    
}
