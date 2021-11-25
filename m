Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55C45DA3E
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 13:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351837AbhKYMqf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 07:46:35 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46466 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350633AbhKYMof (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Nov 2021 07:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637844084; x=1669380084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UvL20kSfQpiwu4gQDL55HWjDeylOBEFGs1CcUR3JMng=;
  b=FDFhoO5EPNaSx8HovO/MSwMC5q3GjVygPt9VZ100bgAh91de+U1xtI4c
   /IrdNgQzRtmsah1wvGSApod5xhuUihkuiy8YFocE1zuvvGoTgMFrfMB+G
   QaVAgiQO6WZfJcn4uaVHklA/2BVFLUXsz1U9ogxi9rYPtdqJ47yLI/EGr
   QcvHbCOiWGsD7KO0j6ogYclem0d+2sbD8yOqjn74F8KVn6dfqhr7pr3Jn
   Z7ctLSMRqFhflMUvsSOW9NA0grZ7Jf0nn2AbLFxP4IrTT17oXyzEcluUM
   F6eKgFCCuo1w/XNsCSpohDFkP/gxsvW2Q5iIuHo7RzbaEib6G+WCGfTF0
   w==;
IronPort-SDR: q2Sj2Dk60CG8n94GXGT9nk3SIrM9ywyKf/5l9xhKbIDiQK3lBCPitTM/z5c+GKArDbWf99Cxxn
 C3/L/eD5RtfbT4WBqIaaIDi92yOlOqiVdu4Y36Ir8AdCW1h+iUxNIDoeIDDrRief7WTI2BYX9s
 cWC5Mc0TKHuiWXJjhU617rJp47ZalJDt+sEWGlvrwftOJxg0hDRJrn6YRyssK9CPPiTqbyVFTS
 qeyUt19mK6cm/kG1yHiOEfb8MSuqvl7e16+ffUgKoSlMSidJZLG+riAyMiVWwKnqdtgcsQOydm
 /R/SR55+MBPXsuiAQTtWOJXc
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="140297319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 05:41:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 05:41:23 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 05:41:21 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] spi: atmel: Remove setting of deprecated member of struct dma_slave_config
Date:   Thu, 25 Nov 2021 14:41:10 +0200
Message-ID: <20211125124110.838037-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125124110.838037-1-tudor.ambarus@microchip.com>
References: <20211125124110.838037-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'direction' member of 'struct dma_slave_config' is deprecated.
Instead, drivers should use the direction argument to the
device_prep_slave_sg and device_prep_dma_cyclic functions or the
dir field in the dma_interleaved_template structure.
spi-atmel uses the direction argument to dmaengine_prep_slave_sg.
slave_config.direction is not used in neither of the DMA controller
drivers (at_h/xdmac) that spi-atmel is using, we can just remove the
setting of slave_config.direction and live with whatever stack value
is there.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-atmel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 22c7239aff75..f6626be4d4f7 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -467,7 +467,6 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 	 * So we'd rather write only one data at the time. Hence the transmit
 	 * path works the same whether FIFOs are available (and enabled) or not.
 	 */
-	slave_config.direction = DMA_MEM_TO_DEV;
 	if (dmaengine_slave_config(master->dma_tx, &slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure tx dma channel\n");
@@ -482,7 +481,6 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 	 * So the receive path works the same whether FIFOs are available (and
 	 * enabled) or not.
 	 */
-	slave_config.direction = DMA_DEV_TO_MEM;
 	if (dmaengine_slave_config(master->dma_rx, &slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure rx dma channel\n");
-- 
2.25.1

