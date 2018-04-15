var mockWebvfx = {
    params: {},
    getStringParameter: function(name) {
        return this.params[name];
    },
    getNumberParameter: function(name) {
        return parseFloat(this.params[name]);
    },
    readyRender: function(status) {
        console.log("webvfx.readyRender", status);

    },
    renderRequested: {
        connect: function(window, func) {
            console.log("webvfx.renderRequested.connect", window, func);
        }
    }
}