// ==UserScript==
// @name         Return Dislike Count Invidious
// @namespace    https://github.com/jesperbakhandskemager/Return-Invidious-Dislike-Count
// @encoding     utf-8
// @version      0.2.3
// @license      MIT
// @description  Return the dislike count to Invidious
// @author       Jesper Bak Handskemager
// @icon         https://t3.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=http://youtube.com&size=16
// @connect      returnyoutubedislikeapi.com
// @include      https://www.returnyoutubedislikeapi.com/*
// @grant        GM.xmlHttpRequest
// @run-at       document-end
// @match        *://invidious.snopyta.org/watch?v=*
// @match        *://yewtu.be/watch?v=*
// @match        *://vid.puffyan.us/watch?v=*
// @match        *://invidious.kavin.rocks/watch?v=*
// @match        *://invidio.xamh.de/watch?v=*
// @match        *://vid.mint.lgb/watch?v=*
// @match        *://invidious.osi.kr/watch?v=*
// @match        *://youtube.076.ne.jp/watch?v=*
// @match        *://yt.artemislena.eu/watch?v=*
// @match        *://invidious.mutahar.rocks/watch?v=*
// @match        *://inv.riverside.rocks/watch?v=*
// @match        *://invidious.namazso.eu/watch?v=*
// @match        *://inv.cthd.icu/watch?v=*
// @match        *://invidious.toot.koeln/watch?v=*
// @match        *://invidious.fdn.fr/watch?v=*
// @match        *://invidious.ggc-project.de/watch?v=*
// @match        *://invidious.13ad.de/watch?v=*
// @match        *://invidious.flokinet.to/watch?v=*
// @match        *://invidious.privacy.gd/watch?v=*
// @match        *://invidious.weblibre.org/watch?v=*
// @match        *://invidious.esmailelbob.xyz/watch?v=*
// @match        *://invidious.lunar.icu/watch?v=*
// @match        *://y.com.sb/watch?v=*
// @match        *://inv.bp.projectsegfau.lt/watch?v=*
// @match        *://yewtu.be/*
// @match        *://inv.in.projectsegfau.lt
// @match        *://inv.nadeko.net
// @match        *://inv.tux.pizza
// @match        *://invidious.darkness.services
// @match        *://invidious.fdn.fr
// @match        *://invidious.incogniweb.net
// @match        *://invidious.jing.rocks
// @match        *://invidious.materialio.us
// @match        *://invidious.nerdvpn.de
// @match        *://invidious.privacyredirect.com
// @match        *://invidious.private.coffee
// @match        *://invidious.reallyaweso.me
// @match        *://iv.datura.network
// @match        *://iv.melmac.space
// @match        *://yewtu.be
// @match        *://yt.artemislena.eu
// @match        *://yt.drgnz.club
// @match        http://u2cvlit75owumwpy4dj2hsmvkq7nvrclkpht7xgyye2pyoxhpmclkrad.onion/watch?v=*
// @match        http://osbivz6guyeahrwp2lnwyjk2xos342h4ocsxyqrlaopqjuhwn2djiiyd.onion/watch?v=*
// @match        http://hpniueoejy4opn7bc4ftgazyqjoeqwlvh2uiku2xqku6zpoa4bf5ruid.onion/watch?v=*
// @match        http://grwp24hodrefzvjjuccrkw3mjq4tzhaaq32amf33dzpmuxe7ilepcmad.onion/watch?v=*
// @match        http://kbjggqkzv65ivcqj6bumvp337z6264huv5kpkwuv6gu5yjiskvan7fad.onion/watch?v=*
// @match        http://c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion/watch?v=*
// @match        http://w6ijuptxiku4xpnnaetxvnkc5vqcdu7mgns2u77qefoixi63vbvnpnqd.onion/watch?v=*
// @downloadURL  https://update.greasyfork.org/scripts/438162/Return%20Dislike%20Count%20Invidious.user.js
// @updateURL    https://update.greasyfork.org/scripts/438162/Return%20Dislike%20Count%20Invidious.meta.js
// ==/UserScript==


var video_data = JSON.parse(document.getElementById('video_data').innerHTML);

GM.xmlHttpRequest({
  method: "GET",
  url: "https://returnyoutubedislikeapi.com/votes?videoId=" + video_data.id,
  onload: function (response) {
    var data = JSON.parse(response.responseText);
    document.getElementById("dislikes").style.display = 'block';
    document.getElementById("dislikes").style.visibility = 'visible';
    document.getElementById("dislikes").innerHTML = "<i class='icon ion-ios-thumbs-down'></i> " + data.dislikes.toLocaleString('en-US');
    document.getElementById("rating").innerHTML = "Rating: " + Math.round(data.rating * 10) / 10 + " / 5";
  }
});
