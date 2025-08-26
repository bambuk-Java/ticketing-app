using SupportAdminService as SupportAdminService from '../../srv/services';
using ViewerService as ViewerService from '../../srv/services';
using from '../../db/schema';

// --------------------
// Tickets (Detail + List) -> nur Admin/Supporter

// --------------------
annotate SupportAdminService.Tickets with @(

    // ---- Detailansicht (Object Page) ----
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'User',
                Value : user.userName
            },
            {
                $Type : 'UI.DataField',
                Value : title
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Status}',
                Value : status
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Description}',
                Value : description
            }
        ]
    },

    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInformation',
            Label : '{i18n>GeneralInformation}',
            Target: '@UI.FieldGroup#GeneratedGroup'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AnswersFacet',
            Label : '{i18n>Answers}',
            Target: 'answers/@UI.LineItem#i18nAnswers'
        }
    ],

    // ---- Listenansicht (Worklist/Table) ----
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>User}',
            Value : user.userName,
            ![@HTML5.CssDefaults]: {width: '25%'}
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
            ![@HTML5.CssDefaults]: {width: '25%'}
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Status}',
            Value : status,
            ![@HTML5.CssDefaults]: {width: '25%'}
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : description,
            ![@HTML5.CssDefaults]: {width: '25%'}
        }
    ],

    // ---- Filterfelder ----
    UI.SelectionFields: [ status ],

    // ---- Header-Info ----
    UI.HeaderInfo: {
        Title: {
            $Type: 'UI.DataField',
            Value: title
        },
        TypeName      : '',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: user.userName
        }
    },

    UI.FieldGroup #Details: {
        $Type: 'UI.FieldGroupType',
        Data : []
    }
);

// ---- Value Help für User -> nur für Admin/Supporter ----
annotate SupportAdminService.Tickets with {
    user @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Users',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: user_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'userName'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'email'
            }
        ]
    }
};

// ---- Status Feld ----
annotate SupportAdminService.Tickets with {
    status @(
        Common.Label                   : '{i18n>Status}',
        Common.ValueListWithFixedValues: true
    )
};

// --------------------
// MyTickets (Viewer Sicht)
// --------------------
annotate ViewerService.MyTickets with @(

    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
            ![@HTML5.CssDefaults]: {width: '40%'}
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Status}',
            Value : status,
            ![@HTML5.CssDefaults]: {width: '20%'}
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : description,
            ![@HTML5.CssDefaults]: {width: '40%'}
        }
    ],

    UI.SelectionFields: [ status ],

    UI.HeaderInfo: {
        Title: {
            $Type: 'UI.DataField',
            Value: title
        },
        Description: {
            $Type: 'UI.DataField',
            Value: createdBy
        }
    }
);

// ---- Status für beide Services ----
annotate SupportAdminService.Status with {
    code @Common.Text: descr
};
annotate ViewerService.Status with {
    code @Common.Text: descr
};

// --------------------
// Answers (Tabelle im Ticket) für beide
// --------------------
annotate SupportAdminService.Answers with @(
    UI.LineItem #i18nAnswers: [
        {
            $Type : 'UI.DataField',
            Value : author,
            ![@HTML5.CssDefaults]: {width: '33.33%'}
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            ![@HTML5.CssDefaults]: {width: '33.33%'}
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Message}',
            Value : message,
            ![@HTML5.CssDefaults]: {width: '33.33%'}
        }
    ]
);
annotate ViewerService.Answers with @(
    UI.LineItem #i18nAnswers: [
        {
            $Type : 'UI.DataField',
            Value : author,
            ![@HTML5.CssDefaults]: {width: '33.33%'}
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            ![@HTML5.CssDefaults]: {width: '33.33%'}
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Message}',
            Value : message,
            ![@HTML5.CssDefaults]: {width: '33.33%'}
        }
    ]
);
