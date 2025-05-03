using { BusinessPartnerA2X } from './external/BusinessPartnerA2X.cds';

using { RiskManagement as my } from '../db/schema.cds';

@path : '/service/RiskManagementService'
service RiskManagementService
{
    annotate A_BusinessPartner with @restrict :
    [
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] },
        { grant : [ '*' ], to : [ 'RiskManager' ] }
    ];

    annotate Mitigations with @restrict :
    [
        { grant : [ '*' ], to : [ 'RiskManager' ] },
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] }
    ];

    annotate Risks with @restrict :
    [
        { grant : [ '*' ], to : [ 'RiskManager' ] },
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] }
    ];

    @readonly
    entity A_BusinessPartner as
        projection on BusinessPartnerA2X.A_BusinessPartner
        {
            BusinessPartner,
            Customer,
            Supplier,
            BusinessPartnerCategory,
            BusinessPartnerFullName,
            BusinessPartnerIsBlocked
        };

    @odata.draft.enabled
    entity Mitigations as
        projection on my.Mitigations;

    @odata.draft.enabled
    entity Risks as
        projection on my.Risks;
}

annotate RiskManagementService with @requires :
[
    'RiskViewer',
    'RiskManager'
];
