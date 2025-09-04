using ProcessorService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Tickets with @(
    UI.DeleteHidden : { $edmJson: { $Not: { $Path: '/ProcessorService.EntityContainer/Configuration/isAdmin' } } },

    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label: Title,
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status code',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Description1}',
                Value : description,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>GeneralInformation}',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Answers}',
            ID : 'i18nAnswers',
            Target : 'answers/@UI.LineItem#i18nAnswers',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : '{i18n>Ticket ID}',
            ![@HTML5.CssDefaults]: {
                width: '30%'
            }
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
            ![@HTML5.CssDefaults]: {
                width: '30%'
            }
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
            ![@HTML5.CssDefaults]: {
                width: '30%'
            }
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Status code}',
            Value : status_code,
            ![@HTML5.CssDefaults]: {
                width: '10%'
            }
        },
    ],
    UI.SelectionFields : [
        status_code,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : ID,
        },
    },
    UI.FieldGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
);

annotate service.Tickets with {
    
    user @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Users',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : user_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'userName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
        ],
    }
};

annotate service.Tickets with {
    status @(
        Common.Label : '{i18n>Status code}',
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Answers with @(
    UI.LineItem #i18nAnswers : [
        {
            $Type : 'UI.DataField',
            Value : author,
            ![@HTML5.CssDefaults]: {
                width: '10%'
            }
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : 'message',
            ![@HTML5.CssDefaults]: {
                width: '75%'
            }
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            ![@HTML5.CssDefaults]: {
                width: '15%'
            }
        },
    ]
);
