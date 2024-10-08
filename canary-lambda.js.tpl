var synthetics = require('Synthetics');
const log = require('SyntheticsLogger');

const pageLoadBlueprint = async function () {

    const URL = "${endpoint}";

    let page = await synthetics.getPage();
    const response = await page.goto(URL, { waitUntil: 'domcontentloaded', timeout: 30000 });

    // Wait for the page to render.
    // Increase or decrease wait time based on endpoint being monitored.
    // Using setTimeout wrapped in a promise for compatibility with older Puppeteer versions.
    await new Promise(resolve => setTimeout(resolve, 15000));

    await synthetics.takeScreenshot('loaded', 'loaded');
    let pageTitle = await page.title();
    log.info('Page title: ' + pageTitle);

    if (response.status() !== 200) {
        throw "Failed to load page!";
    }
};

exports.handler = async () => {
    return await pageLoadBlueprint();
};
