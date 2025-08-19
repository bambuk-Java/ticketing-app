using {ticketing.app.demo as my} from '../db/schema';

/**
 * Service used by personell 'processors'
 */


service ProcessorService {
    @readonly
    entity Users   as projection on my.Users;

    @restrict: [
        {
            grant: ['READ'],
            to   : [
                'Viewer',
                'Admin'
            ]
        },
        {
            grant: [
                'CREATE',
                'UPDATE'
            ],
            to   : ['Admin']
        }
    ]
    entity Tickets as
        projection on my.Tickets {
            ID,
            title,
            status,
            description,
            answers,
            user
        }

    annotate Tickets with @odata.draft.enabled;


    @readonly
    entity Status  as projection on my.Status;

    
    @restrict: [
        {
            grant: ['READ'],
            to   : [
                'Viewer',
                'Admin'
            ]
        },
        {
            grant: [
                'CREATE',
                'UPDATE'
            ],
            to   : ['Admin']
        }
    ]
    entity Answers as projection on my.Answers;
}
