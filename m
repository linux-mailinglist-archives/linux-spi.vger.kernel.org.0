Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB638D454
	for <lists+linux-spi@lfdr.de>; Sat, 22 May 2021 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhEVHxL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 May 2021 03:53:11 -0400
Received: from perseus.uberspace.de ([95.143.172.134]:41992 "EHLO
        perseus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhEVHxL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 May 2021 03:53:11 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 May 2021 03:53:11 EDT
Received: (qmail 28581 invoked from network); 22 May 2021 07:45:03 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by perseus.uberspace.de with SMTP; 22 May 2021 07:45:03 -0000
From:   David Bauer <mail@david-bauer.net>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: ath79: drop platform data
Date:   Sat, 22 May 2021 09:44:52 +0200
Message-Id: <20210522074453.39299-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ath79 platform has been converted to pure OF. The platform data is
not needed anymore because of this.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/spi/spi-ath79.c                 |  8 --------
 include/linux/platform_data/spi-ath79.h | 16 ----------------
 2 files changed, 24 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-ath79.h

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 98ace748cd98..497d5c028496 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -19,7 +19,6 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/platform_data/spi-ath79.h>
 
 #define DRV_NAME	"ath79-spi"
 
@@ -138,7 +137,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct ath79_spi *sp;
-	struct ath79_spi_platform_data *pdata;
 	unsigned long rate;
 	int ret;
 
@@ -152,15 +150,9 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	platform_set_drvdata(pdev, sp);
 
-	pdata = dev_get_platdata(&pdev->dev);
-
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->flags = SPI_MASTER_GPIO_SS;
-	if (pdata) {
-		master->bus_num = pdata->bus_num;
-		master->num_chipselect = pdata->num_chipselect;
-	}
 
 	sp->bitbang.master = master;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
diff --git a/include/linux/platform_data/spi-ath79.h b/include/linux/platform_data/spi-ath79.h
deleted file mode 100644
index 81a388ff58cc..000000000000
--- a/include/linux/platform_data/spi-ath79.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  Platform data definition for Atheros AR71XX/AR724X/AR913X SPI controller
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- */
-
-#ifndef _ATH79_SPI_PLATFORM_H
-#define _ATH79_SPI_PLATFORM_H
-
-struct ath79_spi_platform_data {
-	unsigned	bus_num;
-	unsigned	num_chipselect;
-};
-
-#endif /* _ATH79_SPI_PLATFORM_H */
-- 
2.31.1

