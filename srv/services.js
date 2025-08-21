const cds = require('@sap/cds');

module.exports = srv => {
  srv.after('READ', 'Tickets', (data, req) => {
    const deletable = req.user && req.user.is('Admin');
    if (Array.isArray(data)) {
      data.forEach(t => t.IsDeletable = deletable);
    } else if (data) {
      data.IsDeletable = deletable;
    }
  });
};