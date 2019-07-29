Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1514578EFE
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbfG2PTr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 11:19:47 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40097 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387854AbfG2PTr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 11:19:47 -0400
X-Greylist: delayed 3197 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 11:19:46 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x6TEP7Fj025574;
        Mon, 29 Jul 2019 17:25:07 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 29394622F0; Mon, 29 Jul 2019 17:25:07 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
        tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
        frieder.schrempf@exceet.de, tglx@linutronix.de
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [RFC v1 3/3] mtd: m25p80: add get Flash size callback support
Date:   Mon, 29 Jul 2019 17:25:04 +0300
Message-Id: <20190729142504.188336-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190729142504.188336-1-tmaimon77@gmail.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add get Flash size function support for
passing Flash size through callback use
to the spi layer.

Add get Flash size function support

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/mtd/devices/m25p80.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c50888670250..fd14c8c6d8d8 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -151,6 +151,15 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	return len;
 }
 
+/* Sending Flash size thourgh callback function to spi layer */
+size_t	m25p80_get_flash_size(void *param)
+{
+	struct spi_mem *spimem = param;
+	struct m25p *flash = spi_mem_get_drvdata(spimem);
+
+	return (u32)(flash->spi_nor.mtd.size >> 10) * 1024;
+}
+
 /*
  * board specific setup should have ensured the SPI clock used here
  * matches what the READ command supports, at least until this driver
@@ -188,6 +197,9 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_nor_set_flash_node(nor, spi->dev.of_node);
 	nor->priv = flash;
 
+	spimem->callback = m25p80_get_flash_size;
+	spimem->callback_param = spimem;
+
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem = spimem;
 
-- 
2.18.0

