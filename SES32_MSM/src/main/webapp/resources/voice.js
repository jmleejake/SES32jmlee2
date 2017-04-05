(function(e, p) {
	var m = location.href.match(/platform=(win8|win|mac|linux|cros)/);
	e.id = (m && m[1])
			|| (p.indexOf('Windows NT 6.2') > -1 ? 'win8' : p
					.indexOf('Windows') > -1 ? 'win'
					: p.indexOf('Mac') > -1 ? 'mac'
							: p.indexOf('CrOS') > -1 ? 'cros' : 'linux');
	e.className = e.className.replace(/\bno-js\b/, 'js');
})(document.documentElement, window.navigator.userAgent)


window.___gcfg = {
	lang : 'en'
};
(function() {
	var po = document.createElement('script');
	po.type = 'text/javascript';
	po.async = true;
	po.src = 'https://apis.google.com/js/plusone.js';
	var s = document.getElementsByTagName('script')[0];
	s.parentNode.insertBefore(po, s);
})();

/*var select_language = document.getElementById("select_language");
 언어 종류 
var langs = [ [ '한국어', [ 'ko-KR' ] ],
		[ 'English', [ 'en-US', 'United States' ] ], [ '日本語', [ 'ja-JP' ] ] ];

for (var i = 0; i < langs.length; i++) {
	select_language.options[i] = new Option(langs[i][0], i);
}
updateCountry();
console.log('Speak now');*/

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
/*	start_button.style.display = 'inline-block';*/
	var recognition = new webkitSpeechRecognition();
	recognition.continuous = true;
	recognition.interimResults = true;

	/* 음석인식 서비스가 음성을 듣기 시작했을 때 발생하는 콜백을 설정 */
	recognition.onstart = function() {
		recognizing = true;
		console.log('Speak now');
		$('#mic_img').attr('src', './resources/calendarimg/Mic_rec.jpg');
	};

	/* 음석인식 오류가 발생하면 시작되는 콜백을 설정 */
	recognition.onerror = function(event) {
		if (event.error == 'no-speech') {
			$('#mic_img').attr('src', './resources/calendarimg/Mic_stop.jpg');
			console.log('No Speech');
			ignore_onend = true;
		}
		if (event.error == 'audio-capture') {
			$('#mic_img').attr('src', './resources/calendarimg/Mic_stop.jpg');
			console.log('no_microphone');
			ignore_onend = true;
		}
		if (event.error == 'not-allowed') {
			if (event.timeStamp - start_timestamp < 100) {
				console.log('blocked');
			} else {
				console.log('denied');
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
		if (!final_transcript) {
			console.log('start');
			return;
		}
		console.log('');
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
		if (typeof (event.results) == 'undefined') {
			recognition.onend = null;
			$('#mic_img').attr('src', './resources/calendarimg/Mic_stop.jpg');
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
		$('#final_span').attr("voiceresult1", linebreak(final_transcript));
		$('#interim_span').attr("voiceresult2", linebreak(interim_transcript));
	};
}

function upgrade() {
	start_button.style.visibility = 'hidden';
	console.log('upgrade');
}

var two_line = /\n\n/g;
var one_line = /\n/g;
function linebreak(s) {
	return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
}

var first_char = /\S/;
function capitalize(s) {
	return s.replace(first_char, function(m) {
		return m.toUpperCase();
	});
}

/* 시작버튼 눌렀을 때 이벤트 */
function startButton(event) {
	if (recognizing) {
		$('#mic_img').attr('src', './resources/calendarimg/Mic_stop.jpg');
		recognition.stop();
		return;
	}
	final_transcript = '';
	/* 음성인식 언어설정 */
	recognition.lang = langs[select_language.selectedIndex][1];
	recognition.start();// 음성인식 시작
	ignore_onend = false;
	final_span.innerHTML = '';
	interim_span.innerHTML = '';
	$('#mic_img').attr('src', './resources/calendarimg/Mic_rec.jpg');
	console.log('allow');
	start_timestamp = event.timeStamp;
}


$(document).ready(function() {
	$('#voicesubmit').on('click', submitvoice);

});

function submitvoice() {
	if(recognizing){
		alert("음성인식을 정지해야합니다");
		
		return false;
	}
/* 			$('#mic_img').attr('src', './resources/Mic_stop.jpg');
	recognition.stop(); */
	
	var voresult = $('#final_span').attr("voiceresult1");
	var voresult = $('#interim_span').attr("voiceresult2");

	$.ajax({
		url: 'insert'
		,type:'POST'
		,data: {result: voresult1 }
		,error: function (e) {
			alert(JSON.stringify(e));
		}
	});
}
