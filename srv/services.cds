using {ticketing.app.demo as my} from '../db/schema';

/**
 * Service used by personnel 'processors'
 */
@requires: 'authenticated-user'
service ProcessorService {

    @restrict: [{grant: ['READ'], to: ['Admin', 'Supporter']}]
    entity Users as projection on my.Users;

    @odata.draft.enabled
    @cds.redirection.target
    @restrict: [
        { grant: ['READ','CREATE','UPDATE','DELETE'], to: ['Admin','Supporter'] }
    ]
    entity TicketsAdm as projection on my.Tickets;

    @restrict: [
        { grant: ['READ','CREATE'], to: 'Viewer', where: 'createdBy = $user' }
    ]
    entity TicketsViewer as projection on my.Tickets {
        ID,
        title,
        description,
        createdBy,
        createdAt
        // Erstmal nur die einfachsten Felder - keine Associations
    };

    @readonly
    entity Status as projection on my.Status;

    @cds.redirection.target
    @restrict: [
        { grant: 'READ', to: ['Viewer','Admin'] },
        { grant: ['CREATE','UPDATE'], to: ['Admin'] }
    ]
    entity Answers as projection on my.Answers;
}