Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82214973CE
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jan 2022 18:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiAWRwO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 23 Jan 2022 12:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbiAWRwN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 23 Jan 2022 12:52:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4741C06173B
        for <linux-spi@vger.kernel.org>; Sun, 23 Jan 2022 09:52:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh29-0007aF-Qo; Sun, 23 Jan 2022 18:52:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh28-00BycG-BF; Sun, 23 Jan 2022 18:52:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh26-000tza-R3; Sun, 23 Jan 2022 18:52:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Noralf Tronnes <notro@tronnes.org>,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/5] staging: fbtft: Deduplicate driver registration macros
Date:   Sun, 23 Jan 2022 18:51:58 +0100
Message-Id: <20220123175201.34839-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6082; h=from:subject; bh=foBmuuEI1He7NuGg3QW3ixnzXwI1LphRcPTFGI3t6X8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh7ZWvvuKPqNnlGxkliBrLUAPrmqBmyjgXYcMtZRKf /OdSJuKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYe2VrwAKCRDB/BR4rcrsCQKdB/ 9sBcrdFWuKD0qO5mR5tfx7V99RsL9sa3essPy4tP8F1zgmNlTI+c/J1M7jmBWqkVi++cVYuMXpmSIK KiijgTxGBFHiLiYNjgP/fAymP0jHYKH3wHWWfclIN2e7gfhCsgrxEQU7NTtYMvn95rqgxunuYQiTGl CmlZHDzsSpxAmVUxWcnc8FUi8nrO6LYKp+UR6y47c1RxsmBBvys/7eJKwR+1kgueeeD2grtULKWqgr 5QIF0deXNH1uj85z3vf93rT/L/0zWIWiCtgM34u6J39dCh5X2T2jjtorNcYMs+2Dj7oNLfss3CFi9G /KRKOrig0xxNdVmMyl6neeSDKdjmJF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The two macros FBTFT_REGISTER_DRIVER and FBTFT_REGISTER_SPI_DRIVER
contain quite some duplication: Both define an spi driver and an of device
table and the differences are quite subtle.

So create two new macros and use both twice.

Link: https://lore.kernel.org/r/20220118181338.207943-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/fbtft/fbtft.h | 93 ++++++++++++++---------------------
 1 file changed, 36 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 55677efc0138..6a7545b5bcd2 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -272,21 +272,40 @@ void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...);
 void fbtft_write_reg16_bus8(struct fbtft_par *par, int len, ...);
 void fbtft_write_reg16_bus16(struct fbtft_par *par, int len, ...);
 
+#define FBTFT_DT_TABLE(_compatible)						\
+static const struct of_device_id dt_ids[] = {					\
+	{ .compatible = _compatible },						\
+	{},									\
+};										\
+MODULE_DEVICE_TABLE(of, dt_ids);
+
+#define FBTFT_SPI_DRIVER(_name, _compatible, _display, _spi_ids)		\
+										\
+static int fbtft_driver_probe_spi(struct spi_device *spi)			\
+{										\
+	return fbtft_probe_common(_display, spi, NULL);				\
+}										\
+										\
+static int fbtft_driver_remove_spi(struct spi_device *spi)			\
+{										\
+	struct fb_info *info = spi_get_drvdata(spi);				\
+										\
+	fbtft_remove_common(&spi->dev, info);					\
+	return 0;								\
+}										\
+										\
+static struct spi_driver fbtft_driver_spi_driver = {				\
+	.driver = {								\
+		.name = _name,							\
+		.of_match_table = dt_ids,					\
+	},									\
+	.id_table = _spi_ids,							\
+	.probe = fbtft_driver_probe_spi,					\
+	.remove = fbtft_driver_remove_spi,					\
+};
+
 #define FBTFT_REGISTER_DRIVER(_name, _compatible, _display)                \
 									   \
-static int fbtft_driver_probe_spi(struct spi_device *spi)                  \
-{                                                                          \
-	return fbtft_probe_common(_display, spi, NULL);                    \
-}                                                                          \
-									   \
-static int fbtft_driver_remove_spi(struct spi_device *spi)                 \
-{                                                                          \
-	struct fb_info *info = spi_get_drvdata(spi);                       \
-									   \
-	fbtft_remove_common(&spi->dev, info);                              \
-	return 0;                                                          \
-}                                                                          \
-									   \
 static int fbtft_driver_probe_pdev(struct platform_device *pdev)           \
 {                                                                          \
 	return fbtft_probe_common(_display, NULL, pdev);                   \
@@ -300,22 +319,9 @@ static int fbtft_driver_remove_pdev(struct platform_device *pdev)          \
 	return 0;                                                          \
 }                                                                          \
 									   \
-static const struct of_device_id dt_ids[] = {                              \
-	{ .compatible = _compatible },                                     \
-	{},                                                                \
-};                                                                         \
-									   \
-MODULE_DEVICE_TABLE(of, dt_ids);                                           \
+FBTFT_DT_TABLE(_compatible)						   \
 									   \
-									   \
-static struct spi_driver fbtft_driver_spi_driver = {                       \
-	.driver = {                                                        \
-		.name   = _name,                                           \
-		.of_match_table = dt_ids,                                  \
-	},                                                                 \
-	.probe  = fbtft_driver_probe_spi,                                  \
-	.remove = fbtft_driver_remove_spi,                                 \
-};                                                                         \
+FBTFT_SPI_DRIVER(_name, _compatible, _display, NULL)			   \
 									   \
 static struct platform_driver fbtft_driver_platform_driver = {             \
 	.driver = {                                                        \
@@ -351,42 +357,15 @@ module_exit(fbtft_driver_module_exit);
 
 #define FBTFT_REGISTER_SPI_DRIVER(_name, _comp_vend, _comp_dev, _display)	\
 										\
-static int fbtft_driver_probe_spi(struct spi_device *spi)			\
-{										\
-	return fbtft_probe_common(_display, spi, NULL);				\
-}										\
-										\
-static int fbtft_driver_remove_spi(struct spi_device *spi)			\
-{										\
-	struct fb_info *info = spi_get_drvdata(spi);				\
-										\
-	fbtft_remove_common(&spi->dev, info);					\
-	return 0;								\
-}										\
-										\
-static const struct of_device_id dt_ids[] = {					\
-	{ .compatible = _comp_vend "," _comp_dev },				\
-	{},									\
-};										\
-										\
-MODULE_DEVICE_TABLE(of, dt_ids);						\
+FBTFT_DT_TABLE(_comp_vend "," _comp_dev)					\
 										\
 static const struct spi_device_id spi_ids[] = {					\
 	{ .name = _comp_dev },							\
 	{},									\
 };										\
-										\
 MODULE_DEVICE_TABLE(spi, spi_ids);						\
 										\
-static struct spi_driver fbtft_driver_spi_driver = {				\
-	.driver = {								\
-		.name  = _name,							\
-		.of_match_table = dt_ids,					\
-	},									\
-	.id_table = spi_ids,							\
-	.probe  = fbtft_driver_probe_spi,					\
-	.remove = fbtft_driver_remove_spi,					\
-};										\
+FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)		\
 										\
 module_spi_driver(fbtft_driver_spi_driver);
 
-- 
2.34.1

