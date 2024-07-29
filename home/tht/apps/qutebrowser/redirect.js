// ==UserScript==
// @name         Redirect to Farside
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Redirects YouTube and Reddit URLs to farside.link equivalents
// @author       Your Name
// @match        *://*.youtube.com/*
// @match        *://*.reddit.com/*
// @grant        none
// ==/UserScript==

(function () {
  'use strict';

  const currentUrl = window.location.href;
  const newUrl = 'https://farside.link/' + currentUrl;
  window.location.replace(newUrl);
})();