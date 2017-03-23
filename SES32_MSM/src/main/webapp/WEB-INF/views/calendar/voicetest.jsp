<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js consumer" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta content="initial-scale=1, minimum-scale=1, width=device-width"
	name="viewport">
<meta
	content="Google Chrome is a browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier."
	name="description">
<title>Chrome Browser</title>
<script>
(function(e, p){
    var m = location.href.match(/platform=(win8|win|mac|linux|cros)/);
    e.id = (m && m[1]) ||
           (p.indexOf('Windows NT 6.2') > -1 ? 'win8' : p.indexOf('Windows') > -1 ? 'win' : p.indexOf('Mac') > -1 ? 'mac' : p.indexOf('CrOS') > -1 ? 'cros' : 'linux');
    e.className = e.className.replace(/\bno-js\b/,'js');
  })(document.documentElement, window.navigator.userAgent)
    </script>
<link href="https://plus.google.com/100585555255542998765"
	rel="publisher">
<link href="//www.google.com/images/icons/product/chrome-32.png"
	rel="icon" type="image/ico">
<link
	href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700&amp;subset=latin"
	rel="stylesheet">
<script src="//www.google.com/js/gweb/analytics/autotrack.js">
</script>
<script>
new gweb.analytics.AutoTrack({
          profile: 'UA-26908291-1'
        });
    </script>
<style>
#info {
	font-size: 20px;
}

#div_start {
	float: right;
}

#headline {
	text-decoration: none
}

#results {
	font-size: 14px;
	font-weight: bold;
	border: 1px solid #ddd;
	padding: 15px;
	text-align: left;
	min-height: 150px;
}

#start_button {
	border: 0;
	background-color: transparent;
	padding: 0;
}

.interim {
	color: gray;
}

.final {
	color: black;
	padding-right: 3px;
}

.button {
	display: none;
}

.marquee {
	margin: 20px auto;
}

#buttons {
	margin: 10px 0;
	position: relative;
	top: -50px;
}

#copy {
	margin-top: 20px;
}

#copy>div {
	display: none;
	margin: 0 70px;
}
#div_start{
width: 20%;
height: 20%;

}
#start_img {
width: 10%;
height: 10%;

}

</style>
<style>
a.c1 {
	font-weight: normal;
}
</style>
</head>


<body class="" id="grid">
	<div class="browser-landing" id="main">
		<div class="compact marquee-stacked" id="marquee">
			<div class="marquee-copy">
				<h1>
					WebSpeech
				</h1>
			</div>
		</div>
		<div class="compact marquee">
			<div id="info">
				<p id="info_start">Click on the microphone icon and begin
					speaking for as long as you like.</p>
				<p id="info_speak_now" style="display: none">Speak now.</p>
				<p id="info_no_speech" style="display: none">
					No speech was detected. You may need to adjust your <a
						href="//support.google.com/chrome/bin/answer.py?hl=en&amp;answer=1407892">microphone
						settings</a>.
				</p>
				<p id="info_no_microphone" style="display: none">
					No microphone was found. Ensure that a microphone is installed and
					that <a
						href="//support.google.com/chrome/bin/answer.py?hl=en&amp;answer=1407892">
						microphone settings</a> are configured correctly.
				</p>
				<p id="info_allow" style="display: none">Click the "Allow"
					button above to enable your microphone.</p>
				<p id="info_denied" style="display: none">Permission to use
					microphone was denied.</p>
				<p id="info_blocked" style="display: none">Permission to use
					microphone is blocked. To change, go to
					chrome://settings/contentExceptions#media-stream</p>
				<p id="info_upgrade" style="display: none">
					Web Speech API is not supported by this browser. Upgrade to <a
						href="//www.google.com/chrome">Chrome</a> version 25 or later.
				</p>
			</div>
			<div id="div_start">
				<button id="start_button" onclick="startButton(event)">
					<img alt="Start" id="start_img"
						src="./resources/microphone.png">
				</button>
			</div>
			<div id="results">
				<span class="final" id="final_span"></span> <span class="interim"
					id="interim_span"></span>
			</div>

			<div class="compact marquee" id="div_language">
				<select id="select_language" onchange="updateCountry()">
				</select>
			</div>
		</div>
	</div>


	<script>

  window.___gcfg = { lang: 'en' };
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();


/*       var doubleTracker = new gweb.analytics.DoubleTrack('floodlight', {
          src: 2542116,
          type: 'clien612',
          cat: 'chrom0'
      });
      doubleTracker.track();

      doubleTracker.trackClass('doubletrack', true); */
    </script>
	<script>
	
/*언어 종류  */	
var langs =
[['English',       ['en-US', 'United States']],
 ['한국어',          ['ko-KR']],
 ['日本語',          ['ja-JP']]];

for (var i = 0; i < langs.length; i++) {
  select_language.options[i] = new Option(langs[i][0], i);
}
updateCountry();
showInfo('info_start');

function updateCountry() {
  var list = langs[select_language.selectedIndex];
  }

var final_transcript = '';
var recognizing = false;
var ignore_onend;
var start_timestamp;
if (!('webkitSpeechRecognition' in window)) {
  upgrade();
} else {
  start_button.style.display = 'inline-block';
  var recognition = new webkitSpeechRecognition();
  recognition.continuous = true;
  recognition.interimResults = true;

  /* 음석인식 서비스가 음성을 듣기 시작했을 때 발생하는 콜백을 설정 */
  recognition.onstart = function() {
    recognizing = true;
    showInfo('info_speak_now');
    start_img.src = './resources/microphone.png';
  };

  /* 음석인식 오류가 발생하면 시작되는 콜백을 설정 */
  recognition.onerror = function(event) {
    if (event.error == 'no-speech') {
      start_img.src = './resources/microphone.png';
      showInfo('info_no_speech');
      ignore_onend = true;
    }
    if (event.error == 'audio-capture') {
      start_img.src = './resources/microphone.png';
      showInfo('info_no_microphone');
      ignore_onend = true;
    }
    if (event.error == 'not-allowed') {
      if (event.timeStamp - start_timestamp < 100) {
        showInfo('info_blocked');
      } else {
        showInfo('info_denied');
      }
      ignore_onend = true;
    }
  };

  /* 서비스가 끊어졌을 때 시작되는 콜백을 설정 */
  recognition.onend = function() {
    recognizing = false;
    if (ignore_onend) {
      return;
    }
    start_img.src = './resources/microphone.png';
    if (!final_transcript) {
      showInfo('info_start');
      return;
    }
    showInfo('');
    if (window.getSelection) {
      window.getSelection().removeAllRanges();
      var range = document.createRange();
      range.selectNode(document.getElementById('final_span'));
      window.getSelection().addRange(range);
    }
  };

  /* 음성인식기에서 결과를 반환 할 때 발생하는 콜백 설정 */
  recognition.onresult = function(event) {
    var interim_transcript = '';
    if (typeof(event.results) == 'undefined') {
      recognition.onend = null;
      recognition.stop();
      upgrade();
      return;
    }
    for (var i = event.resultIndex; i < event.results.length; ++i) {
      if (event.results[i].isFinal) {
        final_transcript += event.results[i][0].transcript;
      } else {
        interim_transcript += event.results[i][0].transcript;
      }
    }
    final_transcript = capitalize(final_transcript);
    final_span.innerHTML = linebreak(final_transcript);
    interim_span.innerHTML = linebreak(interim_transcript);
    if (final_transcript || interim_transcript) {
      showButtons('inline-block');
    }
  };
}

function upgrade() {
  start_button.style.visibility = 'hidden';
  showInfo('info_upgrade');
}

var two_line = /\n\n/g;
var one_line = /\n/g;
function linebreak(s) {
  return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
}

var first_char = /\S/;
function capitalize(s) {
  return s.replace(first_char, function(m) { return m.toUpperCase(); });
}



/* 시작버튼 눌렀을 때 이벤트 */
function startButton(event) {
  if (recognizing) {
    recognition.stop();
    return;
  }
  final_transcript = '';
  /*음성인식 언어설정  */
  recognition.lang = langs[select_language.selectedIndex][1];
  recognition.start();
  ignore_onend = false;
  final_span.innerHTML = '';
  interim_span.innerHTML = '';
  start_img.src = './resources/microphone.png';
  showInfo('info_allow');
  showButtons('none');
  start_timestamp = event.timeStamp;
}

function showInfo(s) {
  if (s) {
    for (var child = info.firstChild; child; child = child.nextSibling) {
      if (child.style) {
        child.style.display = child.id == s ? 'inline' : 'none';
      }
    }
    info.style.visibility = 'visible';
  } else {
    info.style.visibility = 'hidden';
  }
}

var current_style;
function showButtons(style) {
  if (style == current_style) {
    return;
  }
  current_style = style;
  copy_button.style.display = style;
  copy_info.style.display = 'none';
}
    </script>
</body>
</html>
