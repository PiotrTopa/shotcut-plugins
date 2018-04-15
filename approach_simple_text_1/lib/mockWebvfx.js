var mockWebvfx = {
    params: {},
    sourceImage: null,
    init: function() {
        sourceImage = new Image();
        sourceImage.src = './res/test.jpg';
    },
    getStringParameter: function(name) {
        return this.params[name];
    },
    getNumberParameter: function(name) {
        return parseFloat(this.params[name]);
    },
    readyRender: function(status) {
        console.log("webvfx.readyRender", status);

    },
    getImage: function(name) {
        return {
            assignToHTMLImageElement: function(imageObject) {
                imageObject.src = './res/test.jpg';
            }
        }
    },
    renderRequested: {
        connect: function(window, func) {
            console.log("webvfx.renderRequested.connect", window, func);
        }
    }
}