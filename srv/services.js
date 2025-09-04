const cds = require('@sap/cds');

module.exports = (srv) => {
  srv.on('READ', 'Configuration', async (req) => {
    return {
      ID: 'singleton',
      isAdmin: req.user?.is('Admin') === true,
      isSupporter: req.user?.is('Supporter') === true
    };
  });
};
