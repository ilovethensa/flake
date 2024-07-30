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

  const redirectPatterns = [
    { pattern: /^https?:\/\/(www\.)?youtube\.com\//, replacement: 'https://farside.link/invidious/' },
    { pattern: /^https?:\/\/(www\.)?reddit\.com\//, replacement: 'https://farside.link/libreddit/' }
  ];

  for (const { pattern, replacement } of redirectPatterns) {
    if (pattern.test(currentUrl)) {
      const newUrl = currentUrl.replace(pattern, replacement);
      window.location.replace(newUrl);
      break;
    }
  }
})();