Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A978EFF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfG2PTt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 11:19:49 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40097 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387854AbfG2PTt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 11:19:49 -0400
X-Greylist: delayed 3197 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 11:19:46 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x6TEP6lN025573;
        Mon, 29 Jul 2019 17:25:06 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C3EFF622ED; Mon, 29 Jul 2019 17:25:06 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
        tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
        frieder.schrempf@exceet.de, tglx@linutronix.de
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [RFC v1 2/3] spi: spi-mem: add callback function to spi-mem device
Date:   Mon, 29 Jul 2019 17:25:03 +0300
Message-Id: <20190729142504.188336-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190729142504.188336-1-tmaimon77@gmail.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add callback function support to the spi-mem device
for passing an argument from the spi-mem layer
to the spi layer.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 include/linux/spi/spi-mem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 5f7d20bd2b09..b9841a9030be 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -13,6 +13,8 @@
 
 #include <linux/spi/spi.h>
 
+typedef size_t (*spi_mem_callback)(void *spi_mem_param);
+
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
 		.buswidth = __buswidth,				\
@@ -172,6 +174,9 @@ struct spi_mem_dirmap_desc {
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
  * @name: name of the SPI memory device
+ * @callback: routine for passing an argument from the
+ *            spi-mem layer to the spi layer.
+ * @callback_param: general parameter to pass to the callback routine
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
@@ -183,6 +188,8 @@ struct spi_mem {
 	struct spi_device *spi;
 	void *drvpriv;
 	const char *name;
+	spi_mem_callback callback;
+	void *callback_param;
 };
 
 /**
-- 
2.18.0

