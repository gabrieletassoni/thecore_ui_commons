// This file can be overridden in your engine

let currentURL = new URL(window.location.href);

$(document).on('turbo:load', function (event) {
    currentURL = new URL(event.originalEvent.detail.url);
    console.log("Page loaded listening to turbo:load event", currentURL.href);
    console.log(" - Protocol:", currentURL.protocol);
    console.log(" - Username:", currentURL.username);
    console.log(" - Password:", currentURL.password);
    console.log(" - Host:", currentURL.host);
    console.log(" - Hostname:", currentURL.hostname);
    console.log(" - Port:", currentURL.port);
    console.log(" - Pathname:", currentURL.pathname);
    console.log(" - Search:", currentURL.search);
    currentURL.searchParams.forEach((v, k) => {
        console.log(`  - ${k}: ${v}`);
    })
    console.log(" - Hash:", currentURL.hash);
});