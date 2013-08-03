This has been tested on OS X

You will need to install qrencode (`brew install qrencode`) and
`vanitygen` as well.

Be sure to securely delete the mask after you have printed it!

<script src="http://coinwidget.com/widget/coin.js"></script>
<script>
CoinWidgetCom.go({
  wallet_address: "13AEtsPjyDm8SdhQFcwUMDJZYgR5hteZPS"
	, currency: "bitcoin"
	, counter: "count"
	, alignment: "bl"
	, qrcode: true
	, auto_show: false
	, lbl_button: "Donate"
	, lbl_address: "My Bitcoin Address:"
	, lbl_count: "donations"
	, lbl_amount: "BTC"
});
</script>
