Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7E1C37D8
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgEDLS7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLS7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 May 2020 07:18:59 -0400
X-Greylist: delayed 179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 May 2020 04:18:59 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66EC061A0E
        for <linux-spi@vger.kernel.org>; Mon,  4 May 2020 04:18:59 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 456AA100AF5ED;
        Mon,  4 May 2020 13:18:57 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C33C660F2900;
        Mon,  4 May 2020 13:18:56 +0200 (CEST)
X-Mailbox-Line: From a088b684ad292faf3bd036e51529e608e5c94638 Mon Sep 17 00:00:00 2001
Message-Id: <a088b684ad292faf3bd036e51529e608e5c94638.1588590210.git.lukas@wunner.de>
In-Reply-To: <cover.1588590210.git.lukas@wunner.de>
References: <cover.1588590210.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 4 May 2020 13:12:05 +0200
Subject: [PATCH 5/5] spi: amd: Drop superfluous member from struct amd_spi
To:     Mark Brown <broonie@kernel.org>,
        "Sanjay R Mehta" <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The AMD SPI driver stores a pointer to the spi_master in struct amd_spi
so that it can get from the latter to the former in amd_spi_fifo_xfer().

It's simpler to just pass the pointer from the sole caller
amd_spi_master_transfer() and drop the pointer from struct amd_spi.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi-amd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 00f2f3405e08..d0aacd4de1b9 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -38,7 +38,6 @@ struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	u32 rom_addr;
-	struct spi_master *master;
 	u8 chip_select;
 };
 
@@ -164,9 +163,9 @@ static int amd_spi_master_setup(struct spi_device *spi)
 }
 
 static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
+				    struct spi_master *master,
 				    struct spi_message *message)
 {
-	struct spi_master *master = amd_spi->master;
 	struct spi_transfer *xfer = NULL;
 	u8 cmd_opcode;
 	u8 *buf = NULL;
@@ -241,7 +240,7 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	 * Extract spi_transfers from the spi message and
 	 * program the controller.
 	 */
-	amd_spi_fifo_xfer(amd_spi, msg);
+	amd_spi_fifo_xfer(amd_spi, master, msg);
 
 	return 0;
 }
@@ -262,7 +261,6 @@ static int amd_spi_probe(struct platform_device *pdev)
 	}
 
 	amd_spi = spi_master_get_devdata(master);
-	amd_spi->master = master;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	amd_spi->io_remap_addr = devm_ioremap_resource(&pdev->dev, res);
-- 
2.26.2

