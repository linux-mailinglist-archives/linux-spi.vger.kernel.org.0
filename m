Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4F31EC7B
	for <lists+linux-spi@lfdr.de>; Thu, 18 Feb 2021 17:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhBRQqc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Feb 2021 11:46:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44164 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRNbu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Feb 2021 08:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613655110; x=1645191110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DwiOvq1QcHy6JlnUCm+lrwBHZVvgBShvBR+IoOqxj5M=;
  b=uQOApi13Q02MCeWero7iX9cndROKvky8UVO8+AApLLZzPrMlMjk5HLXg
   OJ3DS0/ftGtYEo5ZqneoEwvq7PbA42Oj6aSVrD6v7XqTHrJDv2zdNsGEF
   dekmbMH61oDQ1Ki3VfGlrOE00dlVHon4Km1+flgeEvxTHqBLMD/K+naXY
   czTHMt/HrL6XjWAKfA0ZziO/UkJg3VW2U2g3q0sqdxLCexDM0oDuRhkNA
   HPySB1H45pJKF8szI6o8OTfOpjO3gB/OwUjsyXrnvnw39dUjSupyJ56FG
   CvWimDaidcNSIs+puwwXvwuo4WLMr3OCOmimUYaKs/Cw2FBWdQNRMNkHk
   g==;
IronPort-SDR: ZfjT7QoQWC7E3bmgtnnjqe3AugjAQ70E6GiPujMwWkly976SbHhzdogv1qyLs5cezKmmb03wcg
 Gi53N/05TlhtZ4sTBFJAsRbQfNBWsPPyM22y1JiIdtB3T0sY+2fiKeKO2EuHeE/wi3SzGVvkrp
 WsAPjQbCp0ndrt+JkSF7K3rs0/buAU+AHCzsxsL/aArEGzKTF1AgJP2+lxyhzKv69EQGnbWLqD
 uOL6TGLr3wSKHBWN7znuu7AV53N23Z+sa0aXeVf8gBpG/g8EO1ZA7O96wLYTKptrZ4D4LQvkI4
 b3I=
X-IronPort-AV: E=Sophos;i="5.81,187,1610434800"; 
   d="scan'208";a="104291412"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2021 06:28:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 06:28:45 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Feb 2021 06:28:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: atmel: Drop unused variable
Date:   Thu, 18 Feb 2021 15:28:40 +0200
Message-ID: <20210218132840.131898-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The DMA cap mask is no longer used since:
commit 7758e390699f ("spi: atmel: remove compat for non DT board when requesting dma chan")
Drop it now.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-atmel.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0e5e64a80848..19d6f228efa0 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -506,10 +506,6 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 	struct device *dev = &as->pdev->dev;
 	int err;
 
-	dma_cap_mask_t mask;
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
 	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
 		err = dev_err_probe(dev, PTR_ERR(master->dma_tx),
-- 
2.25.1

