Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9224755ED7
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jul 2023 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGQI7z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jul 2023 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjGQI7v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jul 2023 04:59:51 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450EE7F
        for <linux-spi@vger.kernel.org>; Mon, 17 Jul 2023 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689584390; x=1721120390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Atl7ulgRmZbBVqo6NH76K5Mj40dfQz/WNoIzmN0IuHk=;
  b=Vgq50qpv9Q6yx05KERGRXBIb4afBmLXdjTnihFZNoQPMfNy11R+GAvDQ
   8pgKHpN4SuwU7VwoXuVwdA9dfzfZB53p+pFxDtm7I/N75z5bZSBzgO9IU
   EilZgIPWN26BRZy6mq2Jdd85HzXhN9KLEUTSEXZBT0ml5E8Xu/laQQNPE
   x3bblKQlLN5bhGCQXLeVHUXZENE2OFm4PppeRLoRUtdKKgI8jdzHveiie
   u9qpL5Hj6g30ROBiKzc3t1X1rPYkbICERBzW5M3t4stRb+aBpqOCPwA87
   on4NWGueSO5VC3mrAt+PM904+a1nRUGi/7o5ymP1yoaw6o0tlXnS0fIEu
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684792800"; 
   d="scan'208";a="31958424"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Jul 2023 10:59:47 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1CF6E280084;
        Mon, 17 Jul 2023 10:59:47 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 2/3] spi: spi-fsl-lpspi: Move controller initialization further down
Date:   Mon, 17 Jul 2023 10:59:33 +0200
Message-Id: <20230717085934.409476-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717085934.409476-1-alexander.stein@ew.tq-group.com>
References: <20230717085934.409476-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
* Rebase to next-20230717

 drivers/spi/spi-fsl-lpspi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 0a0677f11a3d..f3b7bb1e52eb 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -846,22 +846,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
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
-	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
-	controller->dev.of_node = pdev->dev.of_node;
-	controller->bus_num = pdev->id;
-	controller->num_chipselect = num_cs;
-	controller->slave_abort = fsl_lpspi_slave_abort;
-	if (!fsl_lpspi->is_slave)
-		controller->use_gpio_descriptors = true;
 
 	init_completion(&fsl_lpspi->xfer_done);
 
@@ -911,6 +895,22 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
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
+	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
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

