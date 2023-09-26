$(document).ready(function onDocumentReady() {
	$("table").addClass("table");
	$("img").each(function(index) {
		threshold = 400;
		width = this.clientWidth;
		height = this.clientHeight;

		if (width > threshold || height > threshold) {
			if (width > height) {
				height = height / (width / threshold);
				width = threshold;
			} else {
				width = width / (height / threshold);
				height = threshold;
			}

			$(this).prop("width", width);
			$(this).prop("height", height);

			src = $(this).attr("src");
			$(this).wrap("<a href='" + src + "' data-lightbox='" + src + "'></a>");
		}

		$(this).addClass("img-rounded");
	});
});
