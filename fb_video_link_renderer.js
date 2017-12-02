var system = require('system');
var link = system.args[1];
var page = require('webpage').create();

function onPageReady() {
    var htmlContent = page.evaluate(function() {
        return document.documentElement.outerHTML;
    });

    console.log(htmlContent);

    phantom.exit();
}

page.open(link, function(status) {
    function checkReadyState() {
        setTimeout(function() {
            var readyState = page.evaluate(function() {
                return document.readyState;
            });

            if ("complete" === readyState) {
                onPageReady();
            } else {
                checkReadyState();
            }
        });
    }

    checkReadyState();
});


// page.open(link, function(status) {
//     if (status !== 'success') {
//         console.log('Unable to access network');
//     } else {
//         var ua = page.evaluate(function() {
//             return document.documentElement.outerHTML;
//         });
//         console.log(ua);
//     }
//     phantom.exit();
// });