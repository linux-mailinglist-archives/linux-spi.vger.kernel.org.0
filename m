Return-Path: <linux-spi+bounces-472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DEC82E1A8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC41F22DE8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51301A5A3;
	Mon, 15 Jan 2024 20:21:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA51A29C
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSK-000556-N4; Mon, 15 Jan 2024 21:21:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-0005hx-Gy; Mon, 15 Jan 2024 21:21:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-000N9H-1R;
	Mon, 15 Jan 2024 21:21:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	James Clark <james.clark@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH 32/33] spi: Drop compat layer from renaming "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:18 +0100
Message-ID:  <e5bb84a234e7b0bdde2542c891ebf0cd76c12749.1705348270.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3719; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=yu7xNIM8JxCKE+AFbgKgMhwZWwewLVSSPd3EFE9Z4og=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHlTIqjOQiL5IfSzR7cFf3nQ1grO+FG40ndx H335N0mSOeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR5QAKCRCPgPtYfRL+ TnqfCAC54cxG0jYVsuWroHZdwRu6KGmBnmdbMhcuKWte62YXYilTL8cGZz0Oy8R8ZrO3qhmrpaR UXUFFSzWlipFOl2CMzDv3gXzrpbBXwUL53FFEGwiFwHa87/raRLz5mJYVP7u2ijcR774qBKAaLG KGlJMma1+gEnp06eCscXukWPNSBC6XkFsVwjgZDb9LDj6/yOkri/iwUkslFZ94+LNHw+CFhkRZn r6QHYf2NREyA7SWtpbrXL6an+Jp2bLJrb9WoJ1nTwRa1/5klmwfWQyBFbadNiRvJV4A9kqeT8LW uRvraO4eEPGGMEbKO/ia1KJCia+T2sOVyiF97aKuwzqnCild
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Now that all in-tree users followed the rename, the compat stuff can go
away.  This completes the renaming started with commit 8caab75fd2c2
("spi: Generalize SPI "master" to "controller"")

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  2 +-
 drivers/spi/spi.c                             |  2 +-
 include/linux/spi/spi.h                       | 20 +------------------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index c5f99d834ec5..49c6fd82cd5d 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -462,7 +462,7 @@ SLAVE DMA ENGINE
 SPI
   devm_spi_alloc_master()
   devm_spi_alloc_slave()
-  devm_spi_register_master()
+  devm_spi_register_controller()
 
 WATCHDOG
   devm_watchdog_register_device()
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7477a11e12be..2d7393045384 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -584,7 +584,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 		return NULL;
 	}
 
-	spi->master = spi->controller = ctlr;
+	spi->controller = ctlr;
 	spi->dev.parent = &ctlr->dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 471fe2ff9066..6a4f8cbba5ef 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -131,7 +131,6 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * struct spi_device - Controller side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
  * @controller: SPI controller used with the device.
- * @master: Copy of controller, for backwards compatibility.
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
@@ -185,7 +184,6 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
 struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
-	struct spi_controller	*master;	/* Compatibility layer */
 	u32			max_speed_hz;
 	u8			chip_select[SPI_CS_CNT_MAX];
 	u8			bits_per_word;
@@ -1298,7 +1296,7 @@ spi_max_transfer_size(struct spi_device *spi)
  */
 static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
 {
-	u32 bpw_mask = spi->master->bits_per_word_mask;
+	u32 bpw_mask = spi->controller->bits_per_word_mask;
 
 	if (bpw == 8 || (bpw <= 32 && bpw_mask & SPI_BPW_MASK(bpw)))
 		return true;
@@ -1670,20 +1668,4 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 	return list_is_last(&xfer->transfer_list, &ctlr->cur_msg->transfers);
 }
 
-/* Compatibility layer */
-#define spi_master			spi_controller
-
-#define spi_master_get_devdata(_ctlr)	spi_controller_get_devdata(_ctlr)
-#define spi_master_set_devdata(_ctlr, _data)	\
-	spi_controller_set_devdata(_ctlr, _data)
-#define spi_master_get(_ctlr)		spi_controller_get(_ctlr)
-#define spi_master_put(_ctlr)		spi_controller_put(_ctlr)
-#define spi_master_suspend(_ctlr)	spi_controller_suspend(_ctlr)
-#define spi_master_resume(_ctlr)	spi_controller_resume(_ctlr)
-
-#define spi_register_master(_ctlr)	spi_register_controller(_ctlr)
-#define devm_spi_register_master(_dev, _ctlr) \
-	devm_spi_register_controller(_dev, _ctlr)
-#define spi_unregister_master(_ctlr)	spi_unregister_controller(_ctlr)
-
 #endif /* __LINUX_SPI_H */
-- 
2.43.0


