Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E32104F35
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 10:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUJ1L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 04:27:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35056 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUJ1L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Nov 2019 04:27:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAL9R6dj035605;
        Thu, 21 Nov 2019 03:27:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574328426;
        bh=f5W680rnrw6YM2l6N3/M1ujb/sU/dUvUNZiu5ZBJVoo=;
        h=From:To:CC:Subject:Date;
        b=TXEa5bLpvC/PTEJNkGPEsEezDUrkUkJuqPxgCBVn9VfRo3SjeJ8k3BR7kIHr/tRxt
         AvtrRtt3eLS/oqhLFJB2j2jEGCYNXu9k2uaWu/RF9+pbDXYFba5h4U8zD0G7gcr24Z
         1xmXITrgbtbMXosELlWQnA6QADW5g3cUh82reQH0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAL9R5Xp065160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Nov 2019 03:27:06 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 21
 Nov 2019 03:27:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 21 Nov 2019 03:27:06 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAL9R4gp068975;
        Thu, 21 Nov 2019 03:27:04 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <geert@linux-m68k.org>
CC:     <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] spi: pic32: Retire dma_request_slave_channel_compat()
Date:   Thu, 21 Nov 2019 11:27:03 +0200
Message-ID: <20191121092703.30465-1-peter.ujfalusi@ti.com>
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

Switch the driver to use dma_request_chan() instead and add support for
deferred probing against DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v2:
- Fix copy-paste typo for TX channel request error

Changes since v1:
- Handle deferred probing against DMA channel request.

Trying to crack down on the use of dma_request_slave_channel_compat() in the
tree...

Only compile tested!

Regards,
Peter

 drivers/spi/spi-pic32.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 69f517ec59c6..156961b4ca86 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -606,25 +606,30 @@ static void pic32_spi_cleanup(struct spi_device *spi)
 	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 }
 
-static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
+static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 {
 	struct spi_master *master = pic32s->master;
-	dma_cap_mask_t mask;
+	int ret = 0;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	master->dma_rx = dma_request_chan(dev, "spi-rx");
+	if (IS_ERR(master->dma_rx)) {
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER)
+			ret = -EPROBE_DEFER;
+		else
+			dev_warn(dev, "RX channel not found.\n");
 
-	master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-rx");
-	if (!master->dma_rx) {
-		dev_warn(dev, "RX channel not found.\n");
+		master->dma_rx = NULL;
 		goto out_err;
 	}
 
-	master->dma_tx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-tx");
-	if (!master->dma_tx) {
-		dev_warn(dev, "TX channel not found.\n");
+	master->dma_tx = dma_request_chan(dev, "spi-tx");
+	if (IS_ERR(master->dma_tx)) {
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER)
+			ret = -EPROBE_DEFER;
+		else
+			dev_warn(dev, "TX channel not found.\n");
+
+		master->dma_tx = NULL;
 		goto out_err;
 	}
 
@@ -634,14 +639,20 @@ static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 	/* DMA chnls allocated and prepared */
 	set_bit(PIC32F_DMA_PREP, &pic32s->flags);
 
-	return;
+	return 0;
 
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
+
+	return ret;
 }
 
 static void pic32_spi_dma_unprep(struct pic32_spi *pic32s)
@@ -776,7 +787,10 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware	= pic32_spi_unprepare_hardware;
 
 	/* optional DMA support */
-	pic32_spi_dma_prep(pic32s, &pdev->dev);
+	ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
+	if (ret)
+		goto err_bailout;
+
 	if (test_bit(PIC32F_DMA_PREP, &pic32s->flags))
 		master->can_dma	= pic32_spi_can_dma;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

