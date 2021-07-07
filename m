Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016443BE467
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhGGIaj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:30:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20080 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230484AbhGGIaf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 04:30:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678MiYQ003176;
        Wed, 7 Jul 2021 10:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=iRf/VJrn2VuCJV9ab3IYUGwI4u2m4uedILiHLdRBxrI=;
 b=bAL3ZG7KEl5QbSpNnMy5zfVSt+9pS1dyIFNKxZRgCOLUa6MmWPODd8ZQ3DVtEqk506tU
 ZP523BkDqqeej7IqkLAqMYiRxvnX3m+QfX8LJpUxcuqyUlsz7Fpve+RK0JOWcjRplo02
 rzJJcDIU7egK6iDi1AnSOVgSmlyfmAffuH05FsudU/0WWgBB8xkaIneryj1LNa4b2kAc
 0aet3BvmFvwSivnBB3CxgakxqebJcvq1hOXAhrIRUtTidM6hfMVsLvRCE/ZS1eBcCuXW
 VhGmbXb5HGi5TlvoaWtxk5Y6+aeIJ9qz8vX4ZbkdSBvFIFeRRXEYzM+GyZEHvCoQr+WO Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39mxgxjrat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:27:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00A6A10002A;
        Wed,  7 Jul 2021 10:27:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E627F215125;
        Wed,  7 Jul 2021 10:27:40 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH v2 1/7] spi: stm32: fixes pm_runtime calls in probe/remove
Date:   Wed, 7 Jul 2021 10:27:00 +0200
Message-ID: <1625646426-5826-2-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
References: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
 drivers/spi/spi-stm32.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8ffcffbb8157..a92a28933edb 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1925,6 +1925,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		master->can_dma = stm32_spi_can_dma;
 
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = spi_register_master(master);
@@ -1940,6 +1941,8 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 err_dma_release:
 	if (spi->dma_tx)
 		dma_release_channel(spi->dma_tx);
@@ -1956,9 +1959,14 @@ static int stm32_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	spi_unregister_master(master);
 	spi->cfg->disable(spi);
 
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
 	if (master->dma_rx)
@@ -1966,7 +1974,6 @@ static int stm32_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spi->clk);
 
-	pm_runtime_disable(&pdev->dev);
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
-- 
2.25.1

