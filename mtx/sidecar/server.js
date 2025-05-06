const cds = require('@sap/cds');
const { MTX } = require('@sap/low-code-event-handler/mtx');
const LOG = cds.log('lcap-mtx')
try {         
    MTX.initRoute();  
} catch (error) {
    LOG.error(error);
}

module.exports = cds.server;