Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFF104D67
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 09:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUIKA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 03:10:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57718 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKUIKA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Nov 2019 03:10:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAL89wKX097906;
        Thu, 21 Nov 2019 02:09:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574323798;
        bh=dK4eXj5EEvgO3cvsnxwNSK/prItfj2cpptJ431X4p6w=;
        h=From:To:CC:Subject:Date;
        b=WyrA3cO5ub0tzCAqcHvcs6l8MWNvjwcMWjWiOWXyDvp52csnf5YGZA2qimMgxomjK
         Q3vYgo5GHu24KaDtJagBpMlbsHNOB86ZsaB1bWr6I6dnquQenOYhKE944/tXy7z33+
         vKtIkbDu51/fP9UubUwx/ZBOQv+5Y+4QzBEMTVTs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAL89wgt034493
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Nov 2019 02:09:58 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 21
 Nov 2019 02:09:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 21 Nov 2019 02:09:56 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAL89sYk028502;
        Thu, 21 Nov 2019 02:09:55 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>
CC:     <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: pic32: Retire dma_request_slave_channel_compat()
Date:   Thu, 21 Nov 2019 10:09:54 +0200
Message-ID: <20191121080954.14915-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no reason to use the dma_request_slave_channel_compat() as no
filter function and parameter is provided.

Switch the driver to use dma_request_chan() instead.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Trying to crack down on the dma_request_slave_channel_compat() in the tree...

Only compile tested!

Regards,
Peter

 drivers/spi/spi-pic32.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 69f517ec59c6..2f90ca5118af 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -609,22 +609,18 @@ static void pic32_spi_cleanup(struct spi_device *spi)
 static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 {
 	struct spi_master *master = pic32s->master;
-	dma_cap_mask_t mask;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-rx");
-	if (!master->dma_rx) {
+	master->dma_rx = dma_request_chan(dev, "spi-rx");
+	if (IS_ERR(master->dma_rx)) {
 		dev_warn(dev, "RX channel not found.\n");
+		master->dma_rx = NULL;
 		goto out_err;
 	}
 
-	master->dma_tx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-tx");
-	if (!master->dma_tx) {
+	master->dma_tx = dma_request_chan(dev, "spi-tx");
+	if (IS_ERR(master->dma_tx)) {
 		dev_warn(dev, "TX channel not found.\n");
+		master->dma_tx = NULL;
 		goto out_err;
 	}
 
@@ -637,11 +633,15 @@ static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 	return;
 
 out_err:
-	if (master->dma_rx)
+	if (master->dma_rx) {
 		dma_release_channel(master->dma_rx);
+		master->dma_rx = NULL;
+	}
 
-	if (master->dma_tx)
+	if (master->dma_tx) {
 		dma_release_channel(master->dma_tx);
+		master->dma_tx = NULL;
+	}
 }
 
 static void pic32_spi_dma_unprep(struct pic32_spi *pic32s)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

