$(function() {

	var start = moment().subtract(29, 'days');
	var end = moment();

	function cb(start, end) {
		$('#reportrange span').html(
				start.format('YYYY/MM/DD') + ' - ' + end.format('YYYY/MM/DD'));
		$('#reportrange span').attr("startday", start.format('YYYY/MM/DD'));
		$('#reportrange span').attr("endday", end.format('YYYY/MM/DD'));
	}

	$('#reportrange')
			.daterangepicker(
					{
						locale : {
							format : 'YYYY/MM/DD',
							applyLabel : '확인',
							cancelLabel : '취소'
						},
						startDate : start,
						endDate : end,
						ranges : {
							'Today' : [ moment(), moment() ],
							'Yesterday' : [ moment().subtract(1, 'days'),
									moment().subtract(1, 'days') ],
							'Last 7 Days' : [ moment().subtract(6, 'days'),
									moment() ],
							'Last 30 Days' : [ moment().subtract(29, 'days'),
									moment() ],
							'This Month' : [ moment().startOf('month'),
									moment().endOf('month') ],
							'Last Month' : [
									moment().subtract(1, 'month').startOf(
											'month'),
									moment().subtract(1, 'month')
											.endOf('month') ]
						},
					}, cb);

	cb(start, end);

	$('#saveBtn').click(function() {
		alert($('#reportrange span').attr("startday"));
		alert($('#reportrange span').attr("endday"));
	});

});