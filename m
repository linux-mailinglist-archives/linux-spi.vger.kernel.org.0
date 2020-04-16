Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E5D1ABF30
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633267AbgDPLae (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 07:30:34 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:45000 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505763AbgDPLJ1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 07:09:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 33C9627E0BD7;
        Thu, 16 Apr 2020 13:09:26 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xjj4Iru9kw1A; Thu, 16 Apr 2020 13:09:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id B938D27E0B48;
        Thu, 16 Apr 2020 13:09:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu B938D27E0B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1587035365;
        bh=/9ozp0KDY399qvVyuU0yqqBXwrfUSqHKw0SZnUo0Q9U=;
        h=From:To:Date:Message-Id;
        b=H5OHYSPBp/LiWVVmJQ7U2HkcSlFzBvz5BvLwI27H19YKRCmNMjJ4aMHWH9VkQHHkS
         YRrmeVE6Fyns2B7bSwLu7WJyLZDN7pWeE972GDDhr36Gn16YMfKLxsFqWhaq8p/n2S
         a592HBHzWCUznn9uqwq0XUapMZWH1nRUGU8W2H78=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JKONN3b7rFMU; Thu, 16 Apr 2020 13:09:25 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 9C5F127E02FA;
        Thu, 16 Apr 2020 13:09:25 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH 1/2] spi: dw: remove unused dw_spi_chip handling
Date:   Thu, 16 Apr 2020 13:09:15 +0200
Message-Id: <20200416110916.22633-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416110823.22565-1-cleger@kalray.eu>
References: <20200416110823.22565-1-cleger@kalray.eu>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The path of code using this struct is unused since there is no more user
of this. Remove code and struct definition.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/spi/spi-dw.c | 16 ----------------
 drivers/spi/spi-dw.h | 12 ------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 31e3f866d11a..fda8d433a769 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -399,7 +399,6 @@ static void dw_spi_handle_err(struct spi_controller *master,
 /* This may be called twice for each spi dev */
 static int dw_spi_setup(struct spi_device *spi)
 {
-	struct dw_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
 
 	/* Only alloc on first setup */
@@ -411,21 +410,6 @@ static int dw_spi_setup(struct spi_device *spi)
 		spi_set_ctldata(spi, chip);
 	}
 
-	/*
-	 * Protocol drivers may change the chip settings, so...
-	 * if chip_info exists, use it
-	 */
-	chip_info = spi->controller_data;
-
-	/* chip_info doesn't always exist */
-	if (chip_info) {
-		if (chip_info->cs_control)
-			chip->cs_control = chip_info->cs_control;
-
-		chip->poll_mode = chip_info->poll_mode;
-		chip->type = chip_info->type;
-	}
-
 	chip->tmode = SPI_TMOD_TR;
 
 	return 0;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 1bf5713e047d..44ef18187c15 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -235,18 +235,6 @@ static inline void spi_shutdown_chip(struct dw_spi *dws)
 	spi_set_clk(dws, 0);
 }
 
-/*
- * Each SPI slave device to work with dw_api controller should
- * has such a structure claiming its working mode (poll or PIO/DMA),
- * which can be save in the "controller_data" member of the
- * struct spi_device.
- */
-struct dw_spi_chip {
-	u8 poll_mode;	/* 1 for controller polling mode */
-	u8 type;	/* SPI/SSP/MicroWire */
-	void (*cs_control)(u32 command);
-};
-
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
-- 
2.17.1

