<script>
(function refreshCheckins() {
	$.ajax({
		url: 'ajax/test.html',
		success: function(data) {
			//$('.result').html(data);
		},
		complete: function() {
			// Schedule the next request when the current one's complete
			setTimeout(refreshCheckins, 10000);
		}
	});
})();

$(document).ready(function() {
	refreshCheckins();
});

</script>