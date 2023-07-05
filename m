Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6BF748055
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjGEJCM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjGEJCD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 05:02:03 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68A199A
        for <linux-spi@vger.kernel.org>; Wed,  5 Jul 2023 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1688547715; x=1720083715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2St3MLrk2aG2ULQGB2nTNOi3wjOqaquFdKHHdlBbA7s=;
  b=cRumMkSjAmZQFbOfEJNjQJaNmMO6z+kdQ3eHp/haWhSNhoB8CMl/AVKT
   vhK92awKkI7eLTTEZOsd0yEvIw82H5Y99Z36fUSIICsvyDZhqd0SbDdrE
   x8xqb0oJxN2qt9L6G14ZiTxcLwUBRKmssvMzKHA6DRGJPO2ZumCEzywZ9
   p3ZF8ucUYZHetYb3avMsSbc3sGdtW3ziUT8XWjeljEsXLSmkPIEjKpNWF
   fOewsoaAquAWaYENHmKSiusf9dFvaAK+6sTbhB2jUwEIiBJf4IJtgIMx6
   e7aL2V98ebExXHeizoI/DELZlilamOB3fJTuXQGnipFTIpZFrt2dJq26V
   w==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684792800"; 
   d="scan'208";a="31764883"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jul 2023 11:01:53 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 33B7E280087;
        Wed,  5 Jul 2023 11:01:53 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/3] spi: spi-fsl-lpspi: Remove num_cs from device struct
Date:   Wed,  5 Jul 2023 11:01:43 +0200
Message-Id: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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

This is only used during probe() call, so there is no need to store it
longer than that.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/spi/spi-fsl-lpspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index fb68c72df171..486f4bc488fd 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -98,7 +98,6 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
-	u32 num_cs;
 	bool is_only_cs1;
 	bool is_first_byte;
 
@@ -826,6 +825,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	struct spi_controller *controller;
 	struct resource *res;
 	int ret, irq;
+	u32 num_cs;
 	u32 temp;
 	bool is_slave;
 
@@ -848,8 +848,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
 						"fsl,spi-only-use-cs1-sel");
 	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
-				 &fsl_lpspi->num_cs))
-		fsl_lpspi->num_cs = 1;
+				 &num_cs))
+		num_cs = 1;
 
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	controller->transfer_one = fsl_lpspi_transfer_one;
@@ -859,7 +859,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
 	controller->dev.of_node = pdev->dev.of_node;
 	controller->bus_num = pdev->id;
-	controller->num_chipselect = fsl_lpspi->num_cs;
+	controller->num_chipselect = num_cs;
 	controller->slave_abort = fsl_lpspi_slave_abort;
 	if (!fsl_lpspi->is_slave)
 		controller->use_gpio_descriptors = true;
-- 
2.34.1

