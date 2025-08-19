sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/tickets/test/integration/FirstJourney',
		'ns/tickets/test/integration/pages/TicketsList',
		'ns/tickets/test/integration/pages/TicketsObjectPage'
    ],
    function(JourneyRunner, opaJourney, TicketsList, TicketsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/tickets') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheTicketsList: TicketsList,
					onTheTicketsObjectPage: TicketsObjectPage
                }
            },
            opaJourney.run
        );
    }
);