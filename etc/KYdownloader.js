window.onload = function (){
	setTimeout(
		function () {
			var url = `/content/web_ebook/web_pdf/${ContentHelperJS.B.getInfo().coverUrl.split("/")[8]}/${KYService.Data.barcode}/${KYService.Data.barcode}/${KYService.Data.barcode}.PDF`;
			pdfjsLib.getDocument({
			  url: url,
			  httpHeaders: { Authorization: baseInfo.token },
			  withCredentials: true,
			}).promise.then(function(pdf) {
			  pdf.getData().then(function(data) {
			    var blob = new Blob([data], { type: 'application/pdf' });
			    var url = URL.createObjectURL(blob);
			    var link = document.createElement("a");
			    link.href = url;
			    link.download = document.title
+".pdf";
			    link.click();
			  });
			});
		}
	, 3000);
}
