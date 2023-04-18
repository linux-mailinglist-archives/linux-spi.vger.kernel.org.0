Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA36E5C23
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 10:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjDRIfS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 04:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjDRIfR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 04:35:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5225276
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1681806910; x=1713342910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EpL+GTwf+VU6IHgsMttB337kq77ZB+0+82oQfGvU02g=;
  b=kbrA8RvQG/JA1s3W/grVUwuhuD71IM0uJyq8gKjtH3Zvg3Be6rW92FUT
   XK/IFfW/TaRr+SXw8ll9fYap/BCtciu3Zv0U/JmItj/YkKDCppUE6h24h
   lzbvpH8xbSZhSqLa2ga6MOKz/j/L5mopn8mtctXqhng5lTcuq3XNQp25L
   5lBvJesjL1dmZOBgacm4UajVjtM0Z4zvuoE+EMZ9yvlX1szKinoWprdJY
   mjvOmPcVV2CHBri0CGXEyGeF/F8D/qEYbMCTN6pcH/m2E+kiLcMaJysu+
   GE05G7GzFIm6LYfZxndI7F/SEAc0JzUbZidqFl+Zy+i+S25CiC3HQvsVG
   A==;
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="30389895"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Apr 2023 10:35:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 18 Apr 2023 10:35:08 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 18 Apr 2023 10:35:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1681806908; x=1713342908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EpL+GTwf+VU6IHgsMttB337kq77ZB+0+82oQfGvU02g=;
  b=n83rkcTz5dNgFTtRrNFVaIMyoNm3nsRTzPUBmUXlWJRgjNtTYIuN+Cy2
   7lMaGmDwNbL4bNLyKy0KN9jBtURmJi9jRC06gOPeSN6hc+zifI3PqnZNj
   9nKtp8SZnH/aX36nHpc4FMhJK6/ENOoAo4lMQx3lmQE1J7oJpoS+hrc21
   nz1+H/qiOkmU8rkngydyczPeifRQWDUWSjcjyyNWnk9SQaKRr19Y26U1U
   vet3erbE/M/U8bFqpXbdMIVf4EfNgPrgJQrHqneJeZ8AyToW5bDSXmTBT
   DWBQPZ5WQ9kLAY82r6CEuXIwRDKdeavrO4fn2SL29Jzc9U+fjhbq36ZS2
   g==;
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="30389894"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Apr 2023 10:35:08 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4BB87280056;
        Tue, 18 Apr 2023 10:35:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] spi: spi-imx: Use dev_err_probe for failed DMA channel requests
Date:   Tue, 18 Apr 2023 10:35:05 +0200
Message-Id: <20230418083505.466198-1-alexander.stein@ew.tq-group.com>
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

If dma_request_chan() fails, no error is shown nor any information is
shown in /sys/kernel/debug/devices_deferred if -EPROBE_DEFER is returned.
Use dev_err_probe to fix both problems.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
With this patch applied /sys/kernel/debug/devices_deferred actually
shows these lines on my platform:
30820000.spi    spi_imx: can't get the TX DMA channel!
30830000.spi    spi_imx: can't get the TX DMA channel!

 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 34e5f81ec431e..b23325a3bb667 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1318,7 +1318,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	controller->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(controller->dma_tx)) {
 		ret = PTR_ERR(controller->dma_tx);
-		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
+		dev_err_probe(dev, ret, "can't get the TX DMA channel!\n");
 		controller->dma_tx = NULL;
 		goto err;
 	}
@@ -1327,7 +1327,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	controller->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(controller->dma_rx)) {
 		ret = PTR_ERR(controller->dma_rx);
-		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
+		dev_err_probe(dev, ret, "can't get the RX DMA channel!\n");
 		controller->dma_rx = NULL;
 		goto err;
 	}
-- 
2.34.1

