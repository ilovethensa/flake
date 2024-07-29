// ==UserScript==
// @name         Redirect to Farside
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Redirects YouTube and Reddit URLs to farside.link equivalents
// @author       someone
// @match        *://*.youtube.com/*
// @match        *://*.reddit.com/*
// @run-at document-start
// @grant        none
// ==/UserScript==

(function () {
  'use strict';

  const currentUrl = window.location.href;
  const newUrl = 'https://farside.link/' + currentUrl;
  window.location.replace(newUrl);
})();