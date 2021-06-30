Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F793B7F54
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhF3IuR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 04:50:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15054 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233552AbhF3IuQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Jun 2021 04:50:16 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U8kf04002319;
        Wed, 30 Jun 2021 10:47:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=99okJ5yuem2cjSaKRsrNqXJFQUip9rbqc1E2aILDyKI=;
 b=ebhjce18YNYircBFXtfyyMhiofzINBtARiUzf6mN2QmW1pFxXKeyz0sOjXRlozyMwL34
 ZuZUGkni9/Rjv6vf2aVFyWBT2kIy+SXh/mSXABq2I7TE1ep/HEeogXWDcc8V/D83a2ox
 vxAZzcJDe5npOacMGMPirrBTbUOcfFCoPC4n2aZEn3IOjCTMhJMpJ9F2vn8zPv3TXK7i
 MFCPuwqueosKxtWdxEHd9AbVYwe4wFdKDcDtelNKAfDISKQHLL5WGla8r3m3azj6PRQ0
 wPfOUzgmmxEnnxnoaWX6qrP37CZfa4zcYRmScUjUmbVRLICoxsxCVKRvtCwY5+vfRFb+ zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39ghqhu60m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 10:47:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7CEED100034;
        Wed, 30 Jun 2021 10:47:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6F7EA21BF5F;
        Wed, 30 Jun 2021 10:47:34 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Jun 2021 10:47:34
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 1/6] spi: stm32: fixes pm_runtime calls in probe/remove
Date:   Wed, 30 Jun 2021 10:45:18 +0200
Message-ID: <1625042723-661-2-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
References: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_02:2021-06-29,2021-06-30 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

the pm_runtime is not fully configured (delay not setted).
Add pm_runtime calls in probe/probe error path and remove
in order to be consistent in all places in ordering and
ensure that pm_runtime is disabled prior to resources used
by the SPI controller.

This patch also fixes the 2 following warnings on driver remove:
WARNING: CPU: 0 PID: 743 at drivers/clk/clk.c:594 clk_core_disable_lock+0x18/0x24
WARNING: CPU: 0 PID: 743 at drivers/clk/clk.c:476 clk_unprepare+0x24/0x2c

Fixes: 038ac869c9d2 ("spi: stm32: add runtime PM support")

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8ffcffbb8157..fe35c5cfb820 100644
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
@@ -1924,7 +1926,11 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->dma_tx || spi->dma_rx)
 		master->can_dma = stm32_spi_can_dma;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 STM32_SPI_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = spi_register_master(master);
@@ -1934,12 +1940,18 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	dev_info(&pdev->dev, "driver initialized\n");
 
 	return 0;
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 err_dma_release:
 	if (spi->dma_tx)
 		dma_release_channel(spi->dma_tx);
@@ -1956,9 +1968,16 @@ static int stm32_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	spi_unregister_master(master);
 	spi->cfg->disable(spi);
 
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
 	if (master->dma_rx)
@@ -1966,7 +1985,6 @@ static int stm32_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spi->clk);
 
-	pm_runtime_disable(&pdev->dev);
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
-- 
2.25.1

