<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- modal -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- //modal -->
<!-- voice -->
<meta content="initial-scale=1, minimum-scale=1, width=device-width"
	name="viewport">
<meta
	content="Google Chrome is a browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier."
	name="description">
<!-- //voice -->
<style type="text/css">
#start_button {
	margin-left: 20%;
	background-color: white;
	border: 0;
	outline: 0;
}

#mic_img {
	width: 150px;
	height: 150px;
}

#select_language {
	position: relative;
	left: -73px;
}

#results {
	font-size: 14px;
	font-weight: bold;
	border: 1px solid #ddd;
	padding: 15px;
	text-align: left;
	min-height: 150px;
}
</style>
<!-- voice -->
<script>
	(function(e, p) {
		var m = location.href.match(/platform=(win8|win|mac|linux|cros)/);
		e.id = (m && m[1])
				|| (p.indexOf('Windows NT 6.2') > -1 ? 'win8' : p
						.indexOf('Windows') > -1 ? 'win'
						: p.indexOf('Mac') > -1 ? 'mac'
								: p.indexOf('CrOS') > -1 ? 'cros' : 'linux');
		e.className = e.className.replace(/\bno-js\b/, 'js');
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
		profile : 'UA-26908291-1'
	});
</script>
<!-- //voice -->
</head>
<body>

	<!-- modal을 이용한 마이크녹음창 -->
	<div class="container">
		<h2>Modal Example</h2>
		<!-- Trigger the modal with a button -->
		<button type="button" class="btn btn-info btn-lg" data-toggle="modal"
			data-target="#myModal">Open Modal</button>

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">마이크 테스트</h4>
						<button id="start_button" onclick="startButton(event)">
							<img alt="mic" src="../resources/Mic.png" id="mic_img">
						</button>
					</div>
					<div class="modal-body">
						<div id="results">
							<span class="final" id="final_span"></span> <span class="interim"
								id="interim_span"></span>
						</div>

					</div>
					<div class="modal-footer">
						<select id="select_language" onchange="updateCountry()">
						</select>
						<button type="button" class="btn btn-default" data-dismiss="modal">등록</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!--voice -->
	<script>
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
		var langs = [ [ '한국어', [ 'ko-KR' ] ],
				[ 'English', [ 'en-US', 'United States' ] ],
				[ '日本語', [ 'ja-JP' ] ] ];

		for (var i = 0; i < langs.length; i++) {
			select_language.options[i] = new Option(langs[i][0], i);
		}
		updateCountry();
		console.log('Speak now');

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
				console.log('Speak now');
				$('#mic_img').attr('src','../resources/Mic_rec.jpg');
			};

			/* 음석인식 오류가 발생하면 시작되는 콜백을 설정 */
			recognition.onerror = function(event) {
				if (event.error == 'no-speech') {
					$('#mic_img').attr('src','../resources/Mic_stop.jpg');
					console.log('No Speech');
					ignore_onend = true;
				}
				if (event.error == 'audio-capture') {
					 $('#mic_img').attr('src','../resources/Mic_stop.jpg');
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
					 $('#mic_img').attr('src','../resources/Mic_stop.jpg');
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
				 $('#mic_img').attr('src','../resources/Mic_stop.jpg');
				recognition.stop();
				return;
			}
			final_transcript = '';
			/*음성인식 언어설정  */
			recognition.lang = langs[select_language.selectedIndex][1];
			recognition.start();//음성인식 시작
			ignore_onend = false;
			final_span.innerHTML = '';
			interim_span.innerHTML = '';
			 $('#mic_img').attr('src','../resources/Mic_rec.jpg');
			console.log('allow');
			start_timestamp = event.timeStamp;
		}
		
		


		function voiceTest() {
			var voiceData = '친구랑 다음 주 일요일 오후 7시에 강남역에서 약속있음';
		$.ajax({
			url : 'registScheduleVoice',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
				voiceData : voiceData
			},
			dataType : 'json',
			success : test,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
		}
			function test() {
				alert("성공");
			}
		</script>
	
		
	</script>
		
</body>
</html>