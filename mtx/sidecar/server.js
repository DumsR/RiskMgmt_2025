const cds = require('@sap/cds');
const { MTX } = require('@sap/low-code-event-handler/mtx');
const LOG = cds.log('lcap-mtx')
const xsenv = require('@sap/xsenv');
cds.on('served', async () => {
  const { 'cds.xt.SaasProvisioningService':provisioning } = cds.services
    await provisioning.prepend(() => {
      provisioning.on('dependencies', async (req, next) => {
        await next()
        const services = xsenv.getServices({
          dest: { label: 'destination' }
        })
        let dependencies = [
          {
            xsappname: services.dest.xsappname
          }
        ]
        return dependencies
      })
    })
})

try {         
    MTX.initRoute();  
} catch (error) {
    LOG.error(error);
}

module.exports = cds.server;