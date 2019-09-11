Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0413AFAA3
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfIKKmU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:42:20 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:40061 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKKmU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:42:20 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 26FA1101903B3;
        Wed, 11 Sep 2019 12:42:19 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id D98726124A1A;
        Wed, 11 Sep 2019 12:42:18 +0200 (CEST)
X-Mailbox-Line: From 01625b9b26b93417fb09d2c15ad02dfe9cdbbbe5 Mon Sep 17 00:00:00 2001
Message-Id: <01625b9b26b93417fb09d2c15ad02dfe9cdbbbe5.1568187525.git.lukas@wunner.de>
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 03/10] spi: Guarantee cacheline alignment of driver-private
 data
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

__spi_alloc_controller() uses a single allocation to accommodate struct
spi_controller and the driver-private data, but places the latter behind
the former.  This order does not guarantee cacheline alignment of the
driver-private data.  (It does guarantee cacheline alignment of struct
spi_controller but the structure doesn't make any use of that property.)

Round up struct spi_controller to cacheline size.  A forthcoming commit
leverages this to grant DMA access to driver-private data of the BCM2835
SPI master.

An alternative, less economical approach would be to use two allocations.

A third approach consists of reversing the order to conserve memory.
But Mark Brown is concerned that it may result in a performance penalty
on architectures that don't like unaligned accesses.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2890923d256..f8b4654a57d3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2188,8 +2188,10 @@ extern struct class spi_slave_class;	/* dummy */
  * __spi_alloc_controller - allocate an SPI master or slave controller
  * @dev: the controller, possibly using the platform_bus
  * @size: how much zeroed driver-private data to allocate; the pointer to this
- *	memory is in the driver_data field of the returned device,
- *	accessible with spi_controller_get_devdata().
+ *	memory is in the driver_data field of the returned device, accessible
+ *	with spi_controller_get_devdata(); the memory is cacheline aligned;
+ *	drivers granting DMA access to portions of their private data need to
+ *	round up @size using ALIGN(size, dma_get_cache_alignment()).
  * @slave: flag indicating whether to allocate an SPI master (false) or SPI
  *	slave (true) controller
  * Context: can sleep
@@ -2211,11 +2213,12 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 					      unsigned int size, bool slave)
 {
 	struct spi_controller	*ctlr;
+	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
 
 	if (!dev)
 		return NULL;
 
-	ctlr = kzalloc(size + sizeof(*ctlr), GFP_KERNEL);
+	ctlr = kzalloc(size + ctlr_size, GFP_KERNEL);
 	if (!ctlr)
 		return NULL;
 
@@ -2229,7 +2232,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 		ctlr->dev.class = &spi_master_class;
 	ctlr->dev.parent = dev;
 	pm_suspend_ignore_children(&ctlr->dev, true);
-	spi_controller_set_devdata(ctlr, &ctlr[1]);
+	spi_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
 
 	return ctlr;
 }
-- 
2.23.0

