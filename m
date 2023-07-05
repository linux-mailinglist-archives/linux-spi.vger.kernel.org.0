Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13C748056
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjGEJCZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjGEJCS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 05:02:18 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658E1BCC
        for <linux-spi@vger.kernel.org>; Wed,  5 Jul 2023 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1688547721; x=1720083721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHWl1ZsYAtZFfHeU+QNzJosNvCJ8GCAn6dXN91Pu4p8=;
  b=bVQC7y33fPpGYVB5/Zg5ZaeCKYX9Zs8PBxToIpAWclQRMeH3HgFH2pXR
   s96Wk6fN1A3eSXYyuG1F7H9I4VJqcEpN+SIYlbuUAgJcprqUhfxH7Yiih
   mBpQcS4gIEAw9YYDw+FQLsAdQyf7JgtQxDZHnbDnqAM4bXZU66HI30b7r
   bOJpMY5TUivozUl0hayD3Sz1I/qhpiWN1UxARUXH1mx/fkfDdtXmYyZvC
   o5ALDLPVBkpm+xBQblU8iMXGZwij4DF0r5k0WHl+3Y3btyv4xfitxGRYo
   KB+gCbC7dSB/vMrBrz4bpaO9dVR4WrRjcciWvjM7VtLx2m0vT1An9Q1Hp
   g==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684792800"; 
   d="scan'208";a="31764884"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jul 2023 11:01:53 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4C9D7280088;
        Wed,  5 Jul 2023 11:01:53 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 2/3] spi: spi-fsl-lpspi: Move controller initialization further down
Date:   Wed,  5 Jul 2023 11:01:44 +0200
Message-Id: <20230705090145.1354663-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
References: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a preparation for reading number of chip-selects from hardware.
This needs IO resources mapped and peripheral clocking enabled.
No functional changes intended.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I opted to keep the controller assignments together for readability,
although not strictly necessary.

 drivers/spi/spi-fsl-lpspi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 486f4bc488fd..4b4d25e13ca4 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -847,22 +847,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->is_slave = is_slave;
 	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
 						"fsl,spi-only-use-cs1-sel");
-	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
-				 &num_cs))
-		num_cs = 1;
-
-	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
-	controller->transfer_one = fsl_lpspi_transfer_one;
-	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
-	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
-	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	controller->dev.of_node = pdev->dev.of_node;
-	controller->bus_num = pdev->id;
-	controller->num_chipselect = num_cs;
-	controller->slave_abort = fsl_lpspi_slave_abort;
-	if (!fsl_lpspi->is_slave)
-		controller->use_gpio_descriptors = true;
 
 	init_completion(&fsl_lpspi->xfer_done);
 
@@ -912,6 +896,22 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
 	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
+	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
+				 &num_cs))
+		num_cs = 1;
+
+	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
+	controller->transfer_one = fsl_lpspi_transfer_one;
+	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node = pdev->dev.of_node;
+	controller->bus_num = pdev->id;
+	controller->num_chipselect = num_cs;
+	controller->slave_abort = fsl_lpspi_slave_abort;
+	if (!fsl_lpspi->is_slave)
+		controller->use_gpio_descriptors = true;
 
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
-- 
2.34.1

