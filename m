Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C122A050D
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 13:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJ3MLX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 08:11:23 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:27517 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3MLX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 08:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604059883; x=1635595883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cuDhUCtdldLHfggrlEohm+QuxC5tqtZ6ddFavHBOtlw=;
  b=udxx/hN4J5KrkyU0eR14M+eE3vP7kUVOeIj2uX9MJKxN7cqA8D9bTPIy
   rdAjsE9KISPi3ktx3SadtvNcMcwWI6OVXMZJE5C5Pr7aZQkicFy59KgzM
   rJITqgoMn/Y9vcMqe5o2oxvx3qRPYM9ayQPcHk6pHjfDl9YdaPFTKH8nK
   KMTQqy+dYV/jYuNcICtVCx8bZwzU5yNkj2YiUFhaZ9Om3RX8xxbLkiiY+
   F+FLGbxj28q8uA37CtaDn346eG/XrSFq7c6Uqvg74segFr9NnOX2HGPwU
   kqMFJE6adX5qkSN3hmm2AHkF/iSV2/tvGqE3fOQbNPnHk4BJmg1bQyY8H
   g==;
IronPort-SDR: uowKYC6/GYLYCBbpzJD24CQMWAiD8D1Zx8Vjt10jhK5/xctj0+wyaT5vQ96bxztik/r3U5kqmt
 moBVaxgSKnNtNnIgu2dT5QFrsuJNGgP92f/yHiwjINxOEKa9eTy5llr15XUfOoYRpdULLwu9La
 TJcJjwUdyUBIyDbpQzrUxk7/d1n7Mzn912liLNvTl2fVp3HB7nNkNWnHH4WnMRIRhKBSHe+b4x
 RFtstUURzIzu44mh21NH5i8vx8u466Z8DTp8TtzQgqZlpqcVIvyvDQPXvJaeVmV/NtrMXGlWKC
 2Pg=
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="101575811"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2020 05:11:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 30 Oct 2020 05:11:22 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 30 Oct 2020 05:11:20 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: atmel: Downgrade to dev_dbg when dma_request_chan() fails
Date:   Fri, 30 Oct 2020 14:11:16 +0200
Message-ID: <20201030121116.869105-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The IP's DMA capabilities are described in the SoC dtsi, to spare
users duplicating the DMA bindings in their board device tree. Users
that don't want to use DMA, have to overwrite the DMA bindings in
their board device tree. An example is:
commit ddcdaeb88242 ("ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and UART flx4 functions")

When the DMA bindings are overwritten, one could see on the console:
atmel_spi fc018400.spi: error -ENODEV: No TX DMA channel, DMA is disabled
atmel_spi fc018400.spi: Atmel SPI Controller using PIO only

Choosing to not use DMA is not a reason to print an error message.
More, the user is already informed when PIO is used: "Atmel SPI Controller
using PIO only". Downgrade to dev_dbg when dma_request_chan() fails.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-atmel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0e5e64a80848..948396b382d7 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -512,8 +512,8 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 
 	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
-		err = dev_err_probe(dev, PTR_ERR(master->dma_tx),
-				    "No TX DMA channel, DMA is disabled\n");
+		err = PTR_ERR(master->dma_tx);
+		dev_dbg(dev, "No TX DMA channel, DMA is disabled\n");
 		goto error_clear;
 	}
 
@@ -524,7 +524,7 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 		 * No reason to check EPROBE_DEFER here since we have already
 		 * requested tx channel.
 		 */
-		dev_err(dev, "No RX DMA channel, DMA is disabled\n");
+		dev_dbg(dev, "No RX DMA channel, DMA is disabled\n");
 		goto error;
 	}
 
-- 
2.25.1

