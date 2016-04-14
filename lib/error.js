'use strict';

module.exports = function* error(next) {
    try {
        yield next;
        if (this.response.status === 404 && !this.response.body) {
            if (this.log) {
                this.log.info('404 - Route not found. %s', this.url);
            } else {
                debug('404 - Route not found. %s', this.url);
            }
            this.throw(404);
        }
    } catch (err) {
        this.response.status = err.status || err.statusCode || 500;
        if (this.log) {
            this.log.error(
                "Name:", err.name,
                "\nMessage:", err.message,
                "\nError:", JSON.stringify(err, null, 2),
                "\nStack:", err.stack
            );
        } else {
            debug("Name: %s", err.name);
            debug("Message: %s", err.message);
            debug("Error: %j", err);
            debug("Stack: %s", err.stack);
        }

        this.response.body = {
            message: err.message,
            error: err,
            stack: this.app.env === 'development' ? err.stack.split("\n") : []
        };
    }
};
