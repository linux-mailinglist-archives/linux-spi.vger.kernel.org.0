Return-Path: <linux-spi+bounces-471-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5C82E1A7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9651C213B3
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F51A289;
	Mon, 15 Jan 2024 20:21:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63E199AA
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-0004xG-8Z; Mon, 15 Jan 2024 21:21:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-0005hh-Lt; Mon, 15 Jan 2024 21:21:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-000N91-1u;
	Mon, 15 Jan 2024 21:21:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH 28/33] usb: gadget: max3420_udc: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:14 +0100
Message-ID:  <e3d14feb1650c5b0cb1b6e8442255917c9c91529.1705348270.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=f/cZZybz0rDXkOgAZT4u7KQ9sJjpCOnhW2okoqjetow=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHgLgp2ObVv/gGT+g3dnvprnI/Rw5fdS9E3l 2mFAcvOrTWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR4AAKCRCPgPtYfRL+ TtzzB/4w36IgRLLFOWVenrFYS5rxGg46gy2XceNP8X9LZ5d/oprBfyk+igpRK8J82MQXKDAoU+y 3dvhKKZEsR3yC5/ZJWXsUH1CHxfmIh7UPQW2m0Y1kaG/dBfyIpaiCw/TVozE5mf4iZogNYRcbKt E/d7Kjdvy2dOsRvcIeNj0q2DXi37KFhqAtp43PDrTyUrpHCoG6b0t4YZOMbNnd7eJ3AGljxW14g S75ay55OQyYkRD3tCGotN7cIOPz+PhiBmpx7N0JsQ3M5sdKBOM46fuGTbE4WmjmeZdOJ1TN5JAE RaYeoHam1qrpCz9qPhFQso3oVBL5Rsd61FMV5KpGzodqKVpL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/gadget/udc/max3420_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 89e8cf2a2a7d..7349ea774adf 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -1201,7 +1201,7 @@ static int max3420_probe(struct spi_device *spi)
 	int err, irq;
 	u8 reg[8];
 
-	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
 		dev_err(&spi->dev, "UDC needs full duplex to work\n");
 		return -EINVAL;
 	}
-- 
2.43.0


