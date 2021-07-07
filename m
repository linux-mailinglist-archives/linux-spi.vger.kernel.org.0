Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9373BE45F
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhGGIaf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:30:35 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:5444 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230086AbhGGIac (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 04:30:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678RZkJ008701;
        Wed, 7 Jul 2021 10:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=9TyeVyZnMkgMi7rNxpIQgoXB5CHPNRptXN8NpMJB0Ss=;
 b=H9/eUmgtNtrjCYIgHISWo88+SMb2R97ZbWVh8XD/aK5NEqFW9/LBITD1lG/MKTr7xGSR
 u300M7Tt3WWzWg9Kcn56I/DyLbZrXJ5ILeGOlrlLR4fNczqeXLTtxWqtOAiBsQT4Jcor
 4TY3oycHiFyvxdAwAleoXFcPI3MVyuoJ6zUuBhjqo47zLkw8PaNvEWwmT8VUAFBs5u5V
 a8Mvk+FYGjrYIvZZqTxEO5wJxeoVZjOOBoP2FhdcI6IscjFSdLFEMdWohSHSfxwYE4g6
 ooeDZd+4oOqggjOL9JNO4OFx7kOim/409qIyW1Oy8t46GV9C1Lp7Wkv9qihnYjySqj6X Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39muqtu2xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:27:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FCC9100038;
        Wed,  7 Jul 2021 10:27:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64ABC215125;
        Wed,  7 Jul 2021 10:27:41 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul 2021 10:27:40
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 2/7] spi: stm32: enable pm_runtime autosuspend
Date:   Wed, 7 Jul 2021 10:27:01 +0200
Message-ID: <1625646426-5826-3-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
References: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This commit enables the pm_runtime autosuspend
and sets a 1ms autosuspend delay.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index a92a28933edb..fe35c5cfb820 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -162,6 +162,8 @@
 #define SPI_3WIRE_TX		3
 #define SPI_3WIRE_RX		4
 
+#define STM32_SPI_AUTOSUSPEND_DELAY		1	/* 1 ms */
+
 /*
  * use PIO for small transfers, avoiding DMA setup/teardown overhead for drivers
  * without fifo buffers.
@@ -1924,6 +1926,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->dma_tx || spi->dma_rx)
 		master->can_dma = stm32_spi_can_dma;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 STM32_SPI_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1935,6 +1940,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	dev_info(&pdev->dev, "driver initialized\n");
 
 	return 0;
@@ -1943,6 +1951,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 err_dma_release:
 	if (spi->dma_tx)
 		dma_release_channel(spi->dma_tx);
@@ -1967,6 +1976,8 @@ static int stm32_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
 	if (master->dma_rx)
-- 
2.25.1

