Return-Path: <linux-spi+bounces-468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B66082E1A0
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E71C22181
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02AD199B9;
	Mon, 15 Jan 2024 20:21:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E31A27D
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0004lk-G7; Mon, 15 Jan 2024 21:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0005gl-Md; Mon, 15 Jan 2024 21:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-000N7x-1x;
	Mon, 15 Jan 2024 21:21:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	netdev@vger.kernel.org
Subject: [PATCH 14/33] net: ks8851: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:00 +0100
Message-ID:  <9d509f1065bd6fdf673022b46cb3e7e7faabf38d.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=k1rHvw5+PEKWPibrhhwO8xQSNsQkvYQeLgzRB6ik/XM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHQfCmZmX7LyGzP9mGTWF9K4DvV4q7L3xV+Z hmlkCDkEWaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR0AAKCRCPgPtYfRL+ TjFSB/49fj4XcGmIxTfRFpi6mEnqKtt9lrQdk1JYq/xN3aJC8PRWtoRobAONiOFtqy2W68CNSde HX8i+x3RJs6Tun6P0ItJGLEMhPHv4uY9pgkpHB37f7aXImPEbAeXAFai87joqMfe0N5ijm2Jr7v MIiqpy/Bhf7Nybfny/Cx30pSZ5WKUxKhsxvrIit5pVBjALxzSeM/usbNXSMOPKVXTBuJC84cLcV 0ymPT9N9wwb95sc598lLFeFklr7U5K687XzbDQAxI4n0evGLUGk/evnHv/Vm/V9boBRB6US+bjb 45bMo5AmaxqFKQsevi4CEsno0SvCDFtcZYX4XWoU4ze4BHF9
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
 drivers/net/ethernet/micrel/ks8851_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 54f2eac11a63..2f803377c9f9 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -156,7 +156,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
 
 	txb[0] = cpu_to_le16(op | KS_SPIOP_RD);
 
-	if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+	if (kss->spidev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
 		msg = &kss->spi_msg2;
 		xfer = kss->spi_xfer2;
 
@@ -180,7 +180,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
 	ret = spi_sync(kss->spidev, msg);
 	if (ret < 0)
 		netdev_err(ks->netdev, "read: spi_sync() failed\n");
-	else if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
+	else if (kss->spidev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		memcpy(rxb, trx, rxl);
 	else
 		memcpy(rxb, trx + 2, rxl);
-- 
2.43.0


